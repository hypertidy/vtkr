% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_vtk.R
\name{read_vtk_triangles}
\alias{read_vtk_triangles}
\title{Read VTK triangles}
\usage{
read_vtk_triangles(x, ..., quiet = FALSE)
}
\arguments{
\item{x}{VTK file name}

\item{...}{ignored}

\item{quiet}{if `FALSE` (the default), refrain from reporting extra information}
}
\value{
list, with 'xyz' matrix of x, y, z coordinates, and 'tri' matrix of triangle index (1-based)
}
\description{
Read a VTK (Visualization Toolkit ) UNSTRUCTURED GRID of POINTS with triangle CELLS.
}
\details{
Note that we currently do not recreate the matrix of data, just return the points and
the triangle. The header is printed if `verbose = TRUE`.

Specification of the format found at \url{https://people.sc.fsu.edu/~jburkardt/data/vtk/vtk.html}
on 2019-10-09.
}
\examples{
f <- system.file("extdata/UNSTRUCTURED_GRID/rbc_001.vtk", package = "vtkr", mustWork = TRUE)
mesh0 <- read_vtk_triangles(f)
#library(rgl)
#tm <- tmesh3d(t(mesh0$xyz), t(mesh0$tri), homogeneous = FALSE)
#shade3d(tm, col = "grey")
#rglwidget()
}
