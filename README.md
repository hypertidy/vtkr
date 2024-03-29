
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vtkr

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/hypertidy/vtkr.svg?branch=master)](https://travis-ci.org/hypertidy/vtkr)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/hypertidy/vtkr?branch=master&svg=true)](https://ci.appveyor.com/project/hypertidy/vtkr)
<!-- badges: end -->

The goal of vtkr is to read data from files in [Visualization Toolkit
format](https://en.wikipedia.org/wiki/VTK).

Currently very much in-development, but in time we can read in these
models as rgl mesh forms.

The format is describe at these sites:

  - <https://people.sc.fsu.edu/~jburkardt/data/vtk/vtk.html> (has
    examples in ASCII)
  - <https://lorensen.github.io/VTKExamples/site/VTKFileFormats/>
  - <https://vtk.org/wp-content/uploads/2015/04/file-formats.pdf>

## Other VTK readers for R

I don’t know many VTK readers that’s of use to R. If you do please let
me know\!

One is by Chris Black:

  - <https://gitlab.com/LynchLab/simrootR/blob/vtu_reader/R/vtu.R>

Should also check this out: <https://github.com/Chrismarsh/mesher>

## TODO

  - DONE Basic example read
  - Support the structured points in ASCII form
  - Support the triangles in BINARY form
  - Get out the triangle CELLS attributes
  - Generalize the functions to read header, points-only, detect format,
    etc.
  - Support more formats\!

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hypertidy/vtkr")
```

## Example

This is a basic example to read an in-built VTK file.

``` r
library(vtkr)
f <- system.file("extdata/STRUCTURED_GRID/volcano_points.vtk", package = "vtkr", mustWork = TRUE)
xyz <- read_vtk_points(f)
str(xyz)
#>  num [1:5307, 1:3] 1 2 3 4 5 6 7 8 9 10 ...
```

Currently, we can only read

  - STRUCTURED\_GRID POINTS (BINARY format) - we get a matrix of 3D
    coordinates
  - UNSTRUCTURED\_GRID POINTS triangles CELLS (ASCII format) - we get a
    list with 3D coordinates and triangle indices

No CELL attributes are yet read.

Please get in touch\! I’m especially keen if you have example files that
aren’t supported yet.

-----

Please note that the ‘vtkr’ project is released with a [Contributor Code
of
Conduct](https://github.com/hypertidy/vtkr/blob/master/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.
