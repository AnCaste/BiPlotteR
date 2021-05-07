#' @title Iris 4 BiPlotteR
#'
#' @description This is an adaptation of the iris dataset (embedded in the
#' "datasets" R-package) to the needs of the BiPlotteR functions (i.e.
#' \code{Biplot 3D}, \code{Biplot 2D} and \code{Scatterplot}).
#' You have to follow the same structure when building your input data frame.
#'
#' @format A \code{data frame} with six columns.
#' \describe{
#' \item{Sample Number}{This column offers a number codification for the
#' iris samples; elements in this column will appear as point annotations in
#' the biplot when using the \code{Biplot 3D} and \code{Biplot 2D} functions.}
#' \item{Species}{This column contains a-priori information about your samples; in
#' this particular case, plant samples are grouped according to their species.
#' Points referred to samples that have the same value in the second column of
#' the dataset (the name of the species in this case) will be displayed with
#' the same color in the biplot}.
#' \item{Sepal.Length}{The sepal length measured for each plant sample}
#' \item{Sepal.Width}{The sepal width measured for each plant sample}
#' \item{Petal.Length}{The petal length measured for each plant sample}
#' \item{Petal.Width}{The petal width measured for each plant sample}
#' }
#'
#' @docType data
#'
#' @usage data("Iris_4BPLTR")

"Iris_4BPLTR"
