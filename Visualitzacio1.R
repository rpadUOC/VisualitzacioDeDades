#Instalem i importem "rio" que ens permetr?? llegir el fitxer xlsx i accedir facilment a les diferents fulles
install.packages("rio")
install.packages("doBy")
library(doBy)
library(rio)
library(dplyr)
library(ggplot2)

# Carreguem les dades
data <- import_list("dades-informes-catala947.xlsx")

# Mostrem les dades que ens interessen per veure que s'hagin carregat correctament
print (data$dades_3_2)

df_3_2 = data$dades_3_2


df_3_2 <- orderBy(~id, df_3_2)



#Posem les primeres lletres en maj??scula
names(df_3_2)[names(df_3_2) == 'territori'] <- 'Territori'
names(df_3_2)[names(df_3_2) == 'entendre'] <- 'Entendre'
names(df_3_2)[names(df_3_2) == 'parlar'] <- 'Parlar'
names(df_3_2)[names(df_3_2) == 'llegir'] <- 'Llegir'
names(df_3_2)[names(df_3_2) == 'escriure'] <- 'Escriure'
print(df_3_2)



png(file = "barChart_Entendre.png") # Preparem el nom del fitxer en el que desarem el chart 
ggplot(df_3_2, aes(x = Entendre, y = Territori, fill = Entendre)) + geom_col()
dev.off() # Desem el fitxer

png(file = "barChart_Parlar.png") # Preparem el nom del fitxer en el que desarem el chart 
ggplot(df_3_2, aes(x = Parlar, y = Territori, fill = Parlar)) + geom_col()
dev.off() # Desem el fitxer

png(file = "barChart_ParlarEntendre.png") # Preparem el nom del fitxer en el que desarem el chart 
ggplot(df_3_2, aes(x = Parlar, y = Territori, fill = Entendre)) + geom_col()
dev.off() # Desem el fitxer

png(file = "barChart_General.png") # Preparem el nom del fitxer en el que desarem el chart 
dfm <- tidyr::pivot_longer(df_3_2, cols=c('Entendre', 'Parlar', 'Llegir', 'Escriure'), names_to='variable',values_to="value")
ggplot(dfm, aes(x=Territori, y=value, fill=variable)) + labs(x = "Territori", y = "Percetatges(%)", fill = "Llegenda") + geom_bar(stat='identity', position='dodge') + geom_col() + theme(axis.text.x = element_text(angle=90, vjust=.5, hjust=1))
dev.off() # Desem el fitxer







