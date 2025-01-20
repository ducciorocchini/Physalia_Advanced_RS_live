# Code related to the use of the imageRy pacakge

library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
library(patchwork)

# library(devtools)
# devtools::install_github("ducciorocchini/imageRy")

# List the data
im.list()

b2 <- im.import("sentinel.dolomites.b2.tif")
plot(b2, col=inferno(100))
plot(b2, col=inferno(4))
plot(b2, col=inferno(3))

sent <- im.import("sentinel.dolomites")

# b2 = blue, layer 1
# b3 = green, layer 2
# b4 = red, layer 3
# b8 = nir, layer 4

im.plotRGB(sent, r=3, g=2, b=1, title='natural color') # natural color
im.plotRGB(sent, r=4, g=3, b=2, title='false color') # false color
im.plotRGB(sent, r=3, g=4, b=2, title='false color') # false color
im.plotRGB(sent, r=3, g=2, b=4, title='false color') # false color

im.plotRGB(sent, 3, 2, 1, title='natural color') # natural color

# 8 bit image
# 0-255 (2^8=256 values)
# nir - red = 255 - 0 = 255
# ndvi = 255/(255+0) = 1

# 4 bit image
# 0-15 (2^4=16 values)
# nir - red = 15 - 0 = 15
# ndvi = 15/(15+0) = 1

dvisent <- im.dvi(sent, 4, 3)
ndvisent <- im.ndvi(sent, 4, 3)

# multitemporal visualization
# nir 1 # red 2
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
im.plotRGB(m1992, r=2, g=1, b=3)
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=1, b=3)

ndvi1992 <- im.ndvi(m1992, 1, 2)
ndvi2006 <- im.ndvi(m2006, 1, 2)

# correlation
# 3 bands - 3*2/2 N(N-1)/2
# 4 bands - 6 correlations
pairs(m1992)
pairs(m2006)

# Classifying data
m1992c <- im.classify(m1992, num_clusters=2)
f1992 <- freq(m1992c)
p1992 <- f1992 * 100 / ncell(m1992c)

# building a dataframe
class <- c("Forest","Human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

tabout <- data.frame(class, y1992, y2006)
tabout

p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + 
geom_bar(stat="identity", fill="white") +
ylim(c(0 ,100))

p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + 
geom_bar(stat="identity", fill="white") +
ylim(c(0 ,100))

p1 + p2 

# importing data from outside R
setwd("~/Downloads/")
sun <- rast("superflarecombo_lrg.jpg")

ext <- c(100, 1500, 100, 1500)
sunc <- crop(sun, ext)
plot(sunc)

writeRaster(sunc, "suncropped.png")



