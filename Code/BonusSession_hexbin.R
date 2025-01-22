library(terra)
library(imageRy)
# install.packages("hexbin")
library(hexbin)

ndvi <- im.import("Sentinel2_NDVI_2020")
names(ndvi) <- c("feb","may","aug","nov")

plot(ndvi[[1]], ndvi[[3]])
abline(0, 1, col="red")

dol <- im.import("sentinel.dol")

dol1 = dol[[1]]
dol2 = dol[[2]]
plot(dol1, dol2)
abline(0, 1, col="red")

# translating to dataframe
dol1 <- dol[[1]]
dol2 <- dol[[2]]

dol1d <- as.data.frame(dol1)
dol2d <- as.data.frame(dol2)

hbin <- hexbin(dol1d[[1]], dol2d[[1]], xbins = 10)
plot(hbin)

hbin <- hexbin(dol1d[[1]], dol2d[[1]], xbins = 40)
plot(hbin)

hbin <- hexbin(dol1d[[1]], dol2d[[1]], xbins = 100)
plot(hbin)

