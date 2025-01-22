# Code for modelling species distributions by RS data

library(sdm)
library(raster) # predictors
library(viridis)

file <- system.file("external/species.shp", package="sdm") 
species <- shapefile(file)

plot(species)

# SQL query: select, from, where
pres <- species[species$Occurrence == 1,]
abse <- species[species$Occurrence == 0,]

plot(pres, col="blue", pch=19)
points(abse, col="yellow", pch=19)


# predictors: look at the path
path <- system.file("external", package="sdm") 

# list the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T) #
lst

# The stack() function corresponds simply to the c() function in terra
preds <- stack(lst)

plot(preds)
plot(preds, col=viridis(100))

plot(preds$elevation, col=viridis(100), main="elevation")
points(species[species$Occurrence == 1,], pch=16, col="yellow")

plot(preds$temperature, col=viridis(100), main="temperature")
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=viridis(100), main="precipitation")
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=viridis(100), main="vegetation")
points(species[species$Occurrence == 1,], pch=16)

# set the data for the sdm
datasdm <- sdmData(train=species, predictors=preds)

# model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")

p1 <- predict(m1, newdata=preds) 
plot(p1, col=viridis(100))
points(pres, pch=19)





