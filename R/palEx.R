#' Color Palettes extractor
#' 
#' A function to extract a Color palette from a input `.jpg` file.
#' @param file `.jpg` file of image
#' @param n Number of colors extracted
#' @importFrom jpeg readJPEG
#' @export
#' @return A list of color values extracted from a user provided image (jpg format) based on k-means clustering of the image. 
#' @seealso [stats::kmeans]


palEx=function(file,n){

  # internal function
Coolness = function(P) { 
  RGB <- col2rgb(P)
  (RGB[3,] - RGB[1,]) / (RGB[3,] + RGB[1,])
}


img2 < -readJPEG(file)
img2Dm <- dim(img2)

imgRGB <- data.frame(
  x = rep(1:img2Dm[2], each = img2Dm[1]),
  y = rep(img2Dm[1]:1, img2Dm[2]),
  R = as.vector(img2[,,1]),
  G = as.vector(img2[,,2]),
  B = as.vector(img2[,,3])
)

kClusters <- n
kMean <- kmeans(imgRGB[, c("R", "G", "B")], centers = kClusters)
kColours <- rgb(kMean$centers[kMean$cluster,])

cols <- unique(kColours)
cols.sum <- sort(table(kColours)/sum(table(kColours))*100)
cols.order <- cols[data.frame(cols.sum)[,1]]

vals <- cols.order[order(Coolness(cols.order))]
return(vals)

}
