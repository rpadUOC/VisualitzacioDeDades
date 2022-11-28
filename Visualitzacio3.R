
install.packages("circlize")
library(circlize)
library(dplyr)
library(readr)

# Carreguem les dades
data <- read_delim("Exportacions_realitzades_per_Catalunya_a_nivell_mundial.csv", delim = ",", escape_double = FALSE, na = "NA", trim_ws = TRUE)
data <- subset( data, select = -c(2,3,6 ) )
df <- data
df <- subset( data, select = -c(1,2,3 ) )
df$Pais = data$`País`
df$Any = data$Any
imp <- sub("\\.", "", data$Import)
imp <- sub("\\.", "", imp)
imp <- sub(",", "\\.", imp)

df$Import = as.numeric(imp)
df$Import[is.na(df$Import)] <- 0
df$Import <- round(df$Import, digits = -3) 


#Filtrarem pels països que ens interesen
df <- filter(df, grepl('Alemanya|Itàlia|França|Japó|Suècia', Pais))
print(df,n=nrow(df))

#Anem agafant les dades del Dataframe filtrant per any i ho transpassem tot a una matriu.
df_2020 <- filter(df, Any == 2020)
names(df_2020)[names(df_2020) == "Import"] <- "Import_2020"
mat <- as.matrix(df_2020)
rownames(mat) <- mat[,1]
mat <- mat[, -1] 

df_2019 <- filter(df, Any == 2019)
df_2019
names(df_2019)[names(df_2019) == "Import"] <- "Import_2019"
mat<-cbind(mat,df_2019$Import_2019)

df_2018 <- filter(df, Any == 2018)
df_2018
names(df_2018)[names(df_2018) == "Import"] <- "Import_2018"
mat<-cbind(mat,df_2018$Import_2018)

df_2017 <- filter(df, Any == 2017)
df_2017
names(df_2017)[names(df_2017) == "Import"] <- "Import_2017"
mat<-cbind(mat,df_2017$Import_2017)

df_2016 <- filter(df, Any == 2016)
df_2016
names(df_2016)[names(df_2016) == "Import"] <- "Import_2016"
mat<-cbind(mat,df_2016$Import_2016)


colnames(mat) <- c("any", "Catalunya_2020", "Catalunya_2019" , "Catalunya_2018" , "Catalunya_2017" , "Catalunya_2016")
colnames(mat)
mat <- mat[, -1]
mat



mat_num <- matrix(as.numeric(mat),ncol = ncol(mat))
colnames(mat_num) <- colnames(mat)
rownames(mat_num) <- rownames(mat)
mat_num

#Chord diagram
png(file = "ChordDiagram.png", width=700, height=700) # Preparem el nom del fitxer en el que desarem el chart
chordDiagram(mat_num)
dev.off() # Desem el fitxer
circos.clear()# Restart circular layout parameters

