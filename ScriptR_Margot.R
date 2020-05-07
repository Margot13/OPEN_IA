raw <- read.csv("../IsaraS8OpenDeepLearning/models.csv",
                sep=",",
                col.names = c(rep("numeric",2), "character", rep("numeric",2), "character", rep("numeric",2)),
                na.strings="NA")

names(raw) <- c("Nbr_classes", "Nbr_neurones", "Dataset_entrainement", "Nbr_images_entrainement", "Nbr_passes", "Dataset_test", "Nbr_images_test","Pourcentage_reussite")

raw$Factor<-paste(raw$Nbr_neurones, raw$Dataset_entrainement)


#ploting
png("plot1.png", width = 800, height = 600)
qplot(Nbr_passes, Pourcentage_reussite, data = raw, color=Factor, geom = "smooth")
dev.off()






library(ggplot2)

ggplot(raw, aes(Nbr_passes, Pourcentage_reussite))