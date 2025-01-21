# How to measure variability in space

library(imageRy)
library(terra)
library(viridis)
library(rasterdiv)


im.list()

sent <- im.import("sentinel.png")

# 1 NIR
# 2 red
# 3 green

im.plotRGB(sent, 1, 2, 3)
im.plotRGB(sent, 2, 1, 3)
im.plotRGB(sent, 2, 3, 1)

nir <- sent[[1]]

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

var3 <- focal(nir, matrix(1/9, 3, 3), fun=var)
plot(var)

#----- Shannon entropy

ext <- c(0, 20, 0, 20)
cropnir <- crop(nir, ext)
plot(cropnir)

# blue = 0.8 green = 0.2 
# H = -((0.8*log(0.8)) + (0.2*log(0.2)))
# 0.5004024

# blue = 0.8 green = 0.2 
# H = -((0.5*log(0.5)) + (0.5*log(0.5)))
# 0.6931472

shan3 <- Shannon(nir, window=3)
shan3 <- Shannon(cropnir, window=3) 

# rao3 <- paRao(nir, window=3, alpha=2) # it is important that the terra package is uploaded first!






