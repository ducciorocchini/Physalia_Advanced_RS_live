# How to represent change in time of ecosystems

library(terra)
library(imageRy)
library(ggridges)
library(ggplot2)
library(viridis)

im.list()

EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

par(mfrow=c(1,2))
plot(EN01)
plot(EN13)

diffEN = EN01[[1]] - EN13[[1]]

###- Greenland

gr <- im.import("greenland")
grt <- c(gr[[1]], gr[[4]])
diffgr = gr[[1]] - gr[[4]]

###- Biomass over the alpine area

ndvi <- im.import("Sentinel2_NDVI_")
im.ridgeline(ndvi, scale=1, palette="viridis")

# changing names
names(ndvi) <- c("02_Feb", "05_May", "08_Aug", "11_Nov")
names(ndvi) <- c("Feb", "May", "Aug", "Nov")

# Now I will be able to make the ridgline plot
im.ridgeline(ndvi, scale=1, palette="viridis")
im.ridgeline(ndvi, scale=2, palette="mako")

# RGB scheme 
im.plotRGB(ndvi, r=1, g=2, b=3)
# X11()
setwd("~/Desktop")
png("rgb_ndvi.png")
im.plotRGB(ndvi, r=1, g=2, b=3)
dev.off()



