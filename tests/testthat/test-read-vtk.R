test_that("read points works", {
	f <- system.file("extdata/STRUCTURED_GRID/volcano_points.vtk", package = "vtkr", mustWork = TRUE)
	xyz <- read_vtk_points(f)
  expect_equivalent(xyz[,3L], as.vector(volcano))

  expect_equivalent(sort(unique(xyz[,1])), seq_len(nrow(volcano)))
  expect_equivalent(sort(unique(xyz[,2])), seq_len(ncol(volcano)))

})


test_that("read triangles works", {
	f <- system.file("extdata/UNSTRUCTURED_GRID/rbc_001.vtk", package = "vtkr", mustWork = TRUE)
	m0 <- read_vtk_triangles(f)
	expect_named(m0, c("xyz", "tri"))
	expect_equal(dim(m0$xyz), c(500L, 3L))
	expect_length(m0$tri, 996 * 3)
	expect_equivalent(range(m0$tri), c(1L, 500L))


})
