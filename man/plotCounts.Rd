% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotCounts.R
\name{plotCounts}
\alias{plotCounts}
\title{Plot cell counts}
\usage{
plotCounts(x, color_by = "condition", anno = TRUE)
}
\arguments{
\item{x}{a \code{\link[SingleCellExperiment]{SingleCellExperiment}}.}

\item{color_by}{character string specifying 
a \code{colData(x)} column to color by.}

\item{anno}{logical. Whether to annotate cell numbers as text above bars.}
}
\value{
a \code{\link{ggplot}} object.
}
\description{
Barplot of the number of cells measured for each sample.
}
\examples{
data(PBMC_fs, PBMC_panel, PBMC_md)
sce <- prepData(PBMC_fs, PBMC_panel, PBMC_md)
plotCounts(sce)

}
\references{
Nowicka M, Krieg C, Weber LM et al. 
CyTOF workflow: Differential discovery in 
high-throughput high-dimensional cytometry datasets.
\emph{F1000Research} 2017, 6:748 (doi: 10.12688/f1000research.11622.1)
}
\author{
Helena Lucia Crowell
}
