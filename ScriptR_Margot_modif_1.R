install.packages("gridExtra")
install.packages("ggpot2")

#Trouver la source du fichier : set working directory
# Ouvrir le tableau depuis son ordinateur

graph <- read.csv("../IsaraS8OpenDeepLearning/models.csv",
                sep=",",
                col.names = c(rep("numeric",2), "character", rep("numeric",2), "character", rep("numeric",2)),
                na.strings="NA")

#On renomme les colonnes avec des titres plus simples et plus courts

names(graph) <- c("Nbr_classes", "Nbr_neurones", "Dataset_entrainement", "Nbr_images_entrainement", "Nbr_passes", "Dataset_test", "Nbr_images_test","Pourcentage_reussite")

# Charger ggpot pour avoir nos graphiques 

library(ggplot2)

#1.Interressant de voir le pourcentage de r�ussite en fonction du nombre de passage 
# Le pourcentage de r�ussite depend de beaucoup de facteur :
# - Nombre de neurones : plus j'ai de neurones, plus de je suis intelligent, mieux il r�ussit
# - Nombre d'images � l'entrainement : plus j'ai d'image, plus je r�ussis
# - Nombre de passes : plus de fait de passage, plus de r�ussis 


#1 Pourcentage de r�ussite en fonction du nombre de neurones

graph1 <- qplot(Nbr_neurones, Pourcentage_reussite, data = graph, geom = "auto", 
      xlim = c(0,550), 
      ylim = c(0,75), 
      main = "% R�ussite en fonction du nbr de neurones",
      xlab = "Nombre de neurones",
      ylab = "Pourcentage de reussite au test") + theme(
   plot.title = element_text(color="#990000", size=14, face="bold"),
   axis.title.x = element_text(color="#333000", size=14),
   axis.title.y = element_text(color="#333000", size=14)) + geom_point(color='#990000')

#2 Pourcentage de r�ussite en fonction du nombre d'image � l'entrainement 

graph2 <- qplot(Nbr_images_entrainement, Pourcentage_reussite, data = graph, geom = "auto", 
      xlim = c(0,2000), 
      ylim = c(0,75), 
      main = "% R�ussite en fonction du nbr images entrainement",
      xlab = "Nombre d'image � l'entrainement",
      ylab = "Pourcentage de reussite au test")+ theme(
   plot.title = element_text(color="#330066", size=14, face="bold"),
   axis.title.x = element_text(color="#333000", size=14),
   axis.title.y = element_text(color="#333000", size=14)) + geom_point(color='#330066')

#3 Pourcentage de r�ussite en fonction du nombre de passe

graph3 <- qplot(Nbr_passes, Pourcentage_reussite, data = graph, geom = "auto", 
      xlim = c(0,70), 
      ylim = c(0,75), 
      main = "% R�ussite en fonction du nbr de passes",
      xlab = "Nombre de passes",
      ylab = "Pourcentage de r�ussite au test") + theme(
   plot.title = element_text(color="#006600", size=14, face="bold"),
   axis.title.x = element_text(color="#333000", size=14),
   axis.title.y = element_text(color="#333000", size=14)) + geom_point(color='#006600')


#Combiner plusieurs graphiques sur la m�me page

library("gridExtra")

png("Combin�.png", width = 1200, height = 500)
grid.arrange(graph1,graph2,graph3, ncol=3)
dev.off()


#Ce qu'on remarque c'est qu'il n'y a pas un modele parfait. Tous les facteurs interagisse entre eux  
# Pour faire interagir les trois facteurs : Neurones / Passes / Nbrs d'images --> on concatene
# Or on ne peut pas concatener : neurones et nbr d'image vu que ce sont deux num�riques 
# Mais le dataset_entrainement correspond � un nombre d'image de l'entrainement 
# Catdog = 1589 images 
# Savane50 = 334 images
# Savane 100 = 693 images 
# On va donc pouvoir concatener un num�rique et un non num�rique pour expliquer les diff�rents facteurs 

#On cocatene : Nombres de neuronnes et data set entrainement 

graph$Nombre_neurones_et_images<-paste(graph$Nbr_neurones, graph$Dataset_entrainement)


#On peut faire le graphique pour voir l'interaction des param�tres 

png("Pourcentage_de_reussite.png", width = 800, height = 600)
qplot(Nbr_passes, Pourcentage_reussite, data = graph, color=Nombre_neurones_et_images, geom = c("point", "smooth"),  
      main = "Pourcentage de reussite en fonction du nombre de passes",
      xlab = "Nombre de passes",
      ylab = "Pourcentage de r�ussite au test") + theme(
   plot.title = element_text(color="#333333", size=16, face="bold"),
   axis.title.x = element_text(color="#333333", size=14),
   axis.title.y = element_text(color="#333333", size=14))
dev.off()

#128 catdog = 128 neurones + 1589 images --> palier � 35 passes. Jusqu� 20 passes, peu de diff�rence (68%). Meilleure r�ussite : 80%
#128 savane100 = 128 neurones + 334 images --> Meilleure r�ussite : 60%. Palier � 5 passes, jamais meilleure 
#128 savane50 = 128 neurones + 693 images --> Faible r�ussite par rapport � 128 savane50 : 8%. Trop d'images, mais autant de neurones, et ne peut plus g�rer ?
#512 savane100 = 512 neurones + 693 images --> Fauble r�ussite � 10% et palier peu importe le nombre de passe, meme r�ussite.Trop de neurones, ne peu plus g�rer ? 
#... ?