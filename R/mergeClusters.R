#' @rdname mergeClusters
#' @title Manual cluster merging
#'
#' @description \code{mergeClusters} provides a simple wrapper to
#' store a manual merging inside the input \code{SingleCellExperiment}.
#'
#' @param x a \code{\link[SingleCellExperiment]{SingleCellExperiment}}.
#' @param k a character string specifying the clustering to merge.
#'   Should be one of \code{colnames(cluster_codes(x))}.
#' @param table a merging table with 2 columns containing the cluster IDs to
#'   merge in the 1st, and the cluster IDs to newly assign in the 2nd column.
#' @param id character string. Used as a label for the merging.
#' 
#' @details in the following code snippets, 
#' \code{x} is a \code{SingleCellExperiment} object.
#' \itemize{
#' \item{merging codes are accesible through \code{cluster_codes(x)$id}}
#' \item{all functions that ask for specification of a clustering 
#'   (e.g. \code{\link{plotAbundances}}, \code{\link{plotClusterHeatmap}})
#'   take the merging ID as a valid input argument.}}
#' 
#' @return Writes the newly assigend cluster codes into 
#' the metadata slot \code{cluster_codes} of the input 
#' \code{SingleCellExperiment} and returns the latter.
#' 
#' @author Helena Lucia Crowell \email{helena.crowell@uzh.ch}
#' 
#' @references 
#' Nowicka M, Krieg C, Weber LM et al. 
#' CyTOF workflow: Differential discovery in 
#' high-throughput high-dimensional cytometry datasets.
#' \emph{F1000Research} 2017, 6:748 (doi: 10.12688/f1000research.11622.1)
#' 
#' @examples
#' # construct SCE & run clustering
#' data(PBMC_fs, PBMC_panel, PBMC_md, merging_table)
#' sce <- prepData(PBMC_fs, PBMC_panel, PBMC_md)
#' sce <- cluster(sce)
#' 
#' # merge clusters
#' sce <- mergeClusters(sce, k="meta20", table=merging_table, id="merging")
#' plotClusterHeatmap(sce, k="merging", hm2="pS6")
#' 
#' @importFrom methods is
#' @importFrom SingleCellExperiment colData
#' @importFrom S4Vectors metadata
#' @export

mergeClusters <- function(x, k, table, id) {
    # validity checks
    stopifnot(is(x, "SingleCellExperiment"), 
        "cluster_id" %in% colnames(colData(x)))
    .check_validity_of_k(x, k)
    
    table <- data.frame(table)
    stopifnot(length(id) == 1)
    if (id %in% colnames(metadata(x)$cluster_codes))
        stop("There already exists a clustering named ",
            id, ". Please specify a different identifier.")
    stopifnot(length(table[, 1]) == length(unique(table[, 1])))
    stopifnot(all(table[, 1] %in% levels(cluster_codes(x)[, k])))
    
    m <- match(cluster_codes(x)[, k], table[, 1])
    new_ids <- table[m, 2]
    metadata(x)$cluster_codes[, id] <- factor(new_ids)
    return(x)
}