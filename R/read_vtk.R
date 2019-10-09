#' Read VTK points
#'
#' Read a VTK (Visualization Toolkit ) STRUCTURED GRID of POINTS.
#'
#' Only BINARY supported for now.
#'
#' Note that we currently do not recreate the matrix of data, just return the points. The
#' header is printed if `verbose = TRUE` so the dimensions reported there may be used.
#'
#' Specification of the format found at \url{https://vtk.org/wp-content/uploads/2015/04/file-formats.pdf}
#' on 2019-10-09.
#' @param x VTK file name
#' @param ... ignored
#' @param quiet if `FALSE` (the default), refrain from reporting extra information
#'
#' @return matrix of x, y, z coordinates
#' @export
#' @examples
#' f <- system.file("extdata/STRUCTURED_GRID/volcano_points.vtk", package = "vtkr", mustWork = TRUE)
#' xyz <- read_vtk_points(f)
read_vtk_points <- function(x, ..., quiet = FALSE) {
	con <- file(x, open = "rb")
	on.exit(close(con), add = TRUE)
	##
	## read the header lines
	header <- readLines(con, n = 6L)
	if (!grepl("^BINARY", header[3L])) {
		stop("not a BINARY VTK file, ASCII not yet supported")
	}
	if (!grepl("^POINTS", header[6L])) {
		if (!quiet) print(header)
		stop("does not look like a STRUCTURED_GRID of POINTS")
	}
	nn <- as.integer(strsplit(header[6L], "\\s+", perl = TRUE)[[1L]][[2L]])
  xyz <- matrix(readBin(con, n= nn * 3L, what = "numeric", size = 4, endian = "big"), ncol = 3, byrow = TRUE)

  xyz
}


#' Read VTK triangles
#'
#' Read a VTK (Visualization Toolkit ) UNSTRUCTURED GRID of POINTS with triangle CELLS.
#'
#' Note that we currently do not recreate the matrix of data, just return the points and
#' the triangle. The header is printed if `verbose = TRUE`.
#'
#' Specification of the format found at \url{https://people.sc.fsu.edu/~jburkardt/data/vtk/vtk.html}
#' on 2019-10-09.
#' @param x VTK file name
#' @param ... ignored
#' @param quiet if `FALSE` (the default), refrain from reporting extra information
#'
#' @return list, with 'xyz' matrix of x, y, z coordinates, and 'tri' matrix of triangle index (1-based)
#' @export
#' @examples
#' f <- system.file("extdata/UNSTRUCTURED_GRID/rbc_001.vtk", package = "vtkr", mustWork = TRUE)
#' mesh0 <- read_vtk_triangles(f)
#' #library(rgl)
#' #tm <- tmesh3d(t(mesh0$xyz), t(mesh0$tri), homogeneous = FALSE)
#' #shade3d(tm, col = "grey")
#' #rglwidget()
read_vtk_triangles <- function(x, ..., quiet = FALSE) {
	con <- file(x, open = "rt")
	on.exit(close(con), add = TRUE)
	header <- readLines(con, n = 6L)
	if (!grepl("^ASCII", header[3L])) {
		if (!quiet) print(header)
		stop("not a ASCII VTK file, BINARY not yet supported")
	}
	if (!grepl("^POINTS", header[6L])) {
		if (!quiet) print(header)
		stop("does not look like an UNSTRUCTURED_GRID of POINTS")
	}
	## POINTS
	nn <- as.integer(strsplit(header[6L], "\\s+", perl = TRUE)[[1L]][[2L]])
	if (is.na(nn)) stop("cannot determine number of points")
  xyz <- do.call(rbind, lapply(strsplit(readLines(con, n = nn), "\\s+", perl = TRUE), as.numeric))
  ## CELLS
  idx <- length(header) + nrow(xyz)
  cell_header <- readLines(con, n = 1L)
  if (!grepl("^CELLS", cell_header[1L])) {
  	if (!quiet) print(header)
  	stop("does not look like an UNSTRUCTURED_GRID of TRIANGLES")
  }
  nn_cell <- as.integer(strsplit(cell_header, "\\s+", perl = TRUE)[[1]][[2]])
  if (is.na(nn_cell)) stop("cannot determine number of cells")
  cells <- do.call(rbind, lapply(strsplit(readLines(con, n = nn_cell), "\\s+", perl = TRUE), as.integer))

  ## sanity
  if (!ncol(cells) == 4L) stop("read failed, problem with cells")
  if (!all(cells[,1L] == 3L)) stop("assumption of triangle cells not held")

  list(xyz = xyz, tri = cells[,-1L] + 1L)
}

