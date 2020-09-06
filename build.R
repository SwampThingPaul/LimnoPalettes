# LimnoPalettes

## To build the package
library(roxygen2)
library(roxygen2md)
library(pkgdown)

## Process a package
roxygen2::roxygenise()

## Convert from Rd to Markdown
roxygen2md::roxygen2md()


devtools::document()

devtools::check()

##
devtools::check_rhub()

## Builds package down webpage
pkgdown::build_site()
