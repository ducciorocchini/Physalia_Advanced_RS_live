# Code related to colorblindness simulation and solving

# SIMULATION

library(imageRy)
library(terra)
library(colorblindcheck)
library(colorblindr)
library(patchwork)
library(cblindplot)

im.list()

sentdol <- im.import("sentinel.dolomites")

ndvi <- im.ndvi(sentdol, 4, 3)
plot(ndvi)

clgr <- colorRampPalette(c("black","dark grey","light grey"))(100)
clbr <- colorRampPalette(c("blue","white","red"))(100)
clbg <- colorRampPalette(c("brown","yellow","green"))(100)

plot(ndvi, col=clgr)
plot(ndvi, col=clbr)
plot(ndvi, col=clbg)

par(mfrow=c(2,2))
plot(ndvi)
plot(ndvi, col=clgr)
plot(ndvi, col=clbr)
plot(ndvi, col=clbg)

# Simulation of color vision deficiency (CVD)
palraw <- colorRampPalette(c("red", "orange", "red", "chartreuse", "cyan",
                             "blue"))(100)
palraw_grey <- colorRampPalette(c("dark orange", "orange", "grey", "dark grey",
                                  "light grey", "blue"))(100)

par(mfrow=c(1,2))
plot(ndvi, col=palraw)
plot(ndvi, col=palraw_grey)

setwd("~/Desktop")
vinicunca <- rast("vinicunca.jpg")

plot(vinicunca)

# in case your image is upside down, flip t!
viniflip <- flip(vinicunca)

dev.off()

par(mfrow=c(1,2))
im.plotRGB(vinicunca, 1, 2, 3, title="Standard vision")
im.plotRGB(vinicunca, 2, 2, 3, title="Protanopia") # protanopia 

# Simluation of color vision deficiencies

rainbow_pal <- rainbow(7)
palette_check(rainbow_pal, plot=TRUE)

rainbow_pal <- rainbow(20)
palette_check(rainbow_pal, plot=TRUE)

# colorblindr
explot <- ggplot(iris, aes(Sepal.Length, fill=Species)) +
geom_density(alpha=0.7)
explot 

cvd_grid(explot)

explot2 <- ggplot(iris, aes(Sepal.Length, fill = Species)) + 
  geom_density(alpha=0.7) + scale_fill_OkabeIto()
explot2

explot + explot2

#---- 

rb <- rast("rainbow.jpg")
plot(rb)

cblind.plot(rb, cvd="protanopia")
cblind.plot(rb, cvd="deuteranopia")
cblind.plot(rb, cvd="tritanopia")


