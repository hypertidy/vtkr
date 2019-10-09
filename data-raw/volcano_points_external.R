xyz <- cbind(as.matrix(expand.grid(x = seq_len(nrow(volcano)),
									 y = seq_len(ncol(volcano)))),
									 z = as.vector(volcano))

## writeBin can't specify the type, has be inherent
xyz <- matrix(as.numeric(xyz), ncol = ncol(xyz))

nn <- nrow(xyz)
nrs <- nrow(volcano)
ncls <- ncol(volcano)
con <- file("inst/extdata/STRUCTURED_GRID/volcano_points.vtk", open = "wb")
header <- c("# vtk DataFile Version 3.0", "vtkr R package", "BINARY", "DATASET STRUCTURED_GRID",
						glue::glue("DIMENSIONS   {nrs}    {ncls} 1"), glue::glue("POINTS     {nn} float"))
writeLines(as.character(header), con)
writeBin(as.vector(t(xyz)), con, size = 4L, endian = "big")
close(con)



