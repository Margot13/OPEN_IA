#Trouver la source du fichier : set working directory
# Ouvrir le tableau depuis son ordinateur

graphique <- read.csv("../IsaraS8OpenDeepLearning/models.csv",
                sep=",",
                col.names = c(rep("numeric",2), "character", rep("numeric",2), "character", rep("numeric",2)),
                na.strings="NA")

#On renomme les colonnes avec des titres plus simples et plus courts

names(graphique) <- c("Nbr_classes", "Nbr_neurones", "Dataset_entrainement", "Nbr_images_entrainement", "Nbr_passes", "Dataset_test", "Nbr_images_test","Pourcentage_reussite")

# Charger ggpot pour avoir nos graphiques 

library(ggplot2)

#1.Interressant de voir le pourcentage de réussite en fonction du nombre de passage 
#1.Premier essai avec un type de graphique : Pourcantage_passes

png("Pourcentage_passes.png")
qplot(Nbr_passes, Pourcentage_reussite, data = graphique, geom = "auto", 
      xlim = c(0,70), 
      ylim = c(0,55), 
      main = "Pourcentage de réussite en fonction du nombre de passage",
      xlab = "Pourcentage de réusitte",
      ylab = "Nombre de passes")
dev.off()

      
#Il semblerait que plus le nombre de passes augmentent, plus le pourcentage de réussite soit bas. 
#Mais est-ce que ça veut aussi dire que plus le nombre de passes est élévée, plus l'erreur est faible, et donc oui le pourcentage
#est faible mais les images sont fidèles a la recherche ? Si on demande un girafe = que des girafe avec un passe de 25; alors que passe de 5 on se retrouve avec des abeilles ?
# Résultat logique ? 

#Pour faire l'entrainement deux jeux de données différents pour la savane : un qui s'apelle sanae50 (334 images) et savane100 (693 images)
#Pour faire le test ils ont utilisés le meme jeu de données savane 100 et il contient 178 images 


#On co

raw$Factor<-paste(raw$Nbr_neurones, raw$Dataset_entrainement)


#ploting

png("plot1.png", width = 800, height = 600)
qplot(Nbr_passes, Pourcentage_reussite, data = raw, color=Factor, geom = "smooth",  main = NULL)
dev.off()








ggplot(raw, aes(Nbr_passes, Pourcentage_reussite))