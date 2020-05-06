install.packages("ggplot2")
library(ggplot2)

tab <- read.csv("models.csv",
                sep=",",
                colClasses=c(rep("numeric",2), "character", rep("numeric",2), "character", rep("numeric",2)),
                na.strings="NA")

str(tab)
summary(tab)

names(tab) <- c("Nbr_classes", "Nbr_neurones", "Dataset_entrainement", "Nbr_images_entrainement", "Nbr_passes", "Dataset_test", "Nbr_images_test","Pourcentage_reussite")

tab$Factor <- paste(tab$Nbr_neurones, tab$Dataset_entrainement)


png("plot1.png", width=800, height=600)
qplot(Nbr_passes, Pourcentage_reussite, data = tab, color = Factor)



