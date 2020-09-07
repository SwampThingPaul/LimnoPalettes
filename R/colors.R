#' Complete list of palettes
#'
#' Use [limno_palette()] to construct palettes of desired length.
#'
#' @export
#' 
limno_palettes <- list(
  IowaSummer = c("#E4E0DC", "#D8CBB0", "#C9B77D", "#B29F3C", "#9A8B1B", "#AC702B"),
  PeriFA = c("#CAC8BE", "#B9B5A4", "#ADA790", "#9C9479", "#94874D", "#867533","#6B4517", "#251B14"),
  Bloom1 = c("#BCC671", "#E3EA79", "#A3B25D", "#909A54", "#7B8347", "#656C38","#4E542A", "#35391A"),
  Bloom2 = c("#506036", "#6C7E4E", "#82956D", "#8DB8A4", "#9CB086", "#C3CDA2","#CAD2C1"),
  SuperIce = c("#7689A1", "#9EA8B6", "#C3C7C9", "#828581", "#A7A8A1", "#F0EDE4"),
  FlatheadRocks = c("#464D59", "#879CA9", "#697581", "#3D3835", "#685E54", "#948973"),
  ShelburnePond = c("#E1EBF4", "#D1DCE7", "#A6B0BA", "#8C97A1", "#5C666D", "#475158", "#30363F"),
  WetSoil = c("#4B3627", "#150F0B", "#31261D", "#624C3A", "#978467", "#AEA190","#6F655C", "#EDE5DB"),
  OrdRiver = c("#193F15", "#497540", "#789F6C", "#A3BB98", "#C3D7BC", "#EBF7E7","#56E4BF", "#2DD8AE")
)

#' A Limnology palette generator
#'
#' These are a handful of color palettes inspired by lakes, rivers, streams and wetlands. .
#'
#' @param n Number of colors desired. All color
#'   schemes are derived from photos provided by contributors to this  
#'   [twitter thread](https://twitter.com/SwampThingPaul/status/1301889771057356801?s=20).
#'   If omitted, uses all colours.
#' @param name Name of desired palette. Choices are:
#'   `IowaSummer`, `PeriFA`,  `Bloom1`,
#'   `Bloom2`, `SuperIce`,  `FlatheadRocks`, `ShelburnePond`,
#'   `WetSoil`,`OrdRiver`
#' @param type Either "continuous" or "discrete". Use continuous if you want
#'   to automatically interpolate between colours.
#'   @importFrom graphics rgb rect par image text
#' @return A vector of colours.
#' @export
#' @keywords colors
#' @examples
#' limno_palette("IowaSummer")
#' limno_palette("Bloom2")
#' limno_palette("PeriFA",10,"continuous")


limno_palette <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)
  
  pal <- limno_palettes[[name]]
  if (is.null(pal))
    stop("Palette not found.")
  
  if (missing(n)) {
    n <- length(pal)
  }
  
  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer")
  }
  
  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )
  structure(out, class = "palette", name = name)
}

#' Print a palette
#' 
#' @param x Desired palette
#' @param ... further arguments passed to or from other methods. 
#' 
#' @export 
#' @importFrom graphics rect par image text
#' @importFrom grDevices rgb
#' 
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))
  
  image(1:n, 1, as.matrix(1:n), col = x,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")
  
  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"),...)
  
}
