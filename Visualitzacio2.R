library(ggplot2)


library(doBy)
library(rio)
library(dplyr)
library(ggplot2)



# Carreguem les dades
data <- import_list("dades-informes-catala947.xlsx")

# Mostrem les dades que ens interessen per veure que s'hagin carregat correctament
print (data$dades_4_2)
df_4_2 = data$dades_4_2
df_4_2 <- orderBy(~id, df_4_2)


#Posem les primeres lletres en majúscula
names(df_4_2)[names(df_4_2) == 'usaMolt'] <- 'Usa molt'
names(df_4_2)[names(df_4_2) == 'usaForça'] <- 'Usa força'
names(df_4_2)[names(df_4_2) == 'usaMitjanament'] <- 'Usa mitjanament'
names(df_4_2)[names(df_4_2) == 'usaPoc'] <- 'Usa poc'
names(df_4_2)[names(df_4_2) == 'noUsaMai'] <- 'No usa mai'
names(df_4_2)[names(df_4_2) == 'territori'] <- 'Territori'
print(df_4_2)



png(file = "smallmultiples.png", width=2000) # Preparem el nom del fitxer en el que desarem el chart
dfm <- tidyr::pivot_longer(df_4_2, cols=c('Usa molt', 'Usa força', 'Usa mitjanament', 'Usa poc', 'No usa mai'), names_to='variable',values_to="value")
dfm$value = dfm$value * 100

dfm$ordre <- as.numeric(ifelse(dfm$variable == 'Usa molt', "5",
                                    ifelse(dfm$variable == 'Usa força', "4",
                                           ifelse(dfm$variable == 'Usa mitjanament', "3", 
                                                  ifelse(dfm$variable == 'Usa poc', "2", "1")))))
dfm
ggplot(dfm, aes(x=value, y=reorder(variable, ordre), fill=factor(variable))) + labs(x = "Percetatge(%)", y = "Ús", fill = "Llegenda") + geom_bar(stat="identity", position='dodge') + facet_wrap(~Territori) + theme(plot.title = element_text(family="Arial", face="bold", size=30, hjust=0, color="#555555")) +ggtitle("Ús del català") + theme(axis.text.x = element_text(angle=90)) + scale_fill_discrete(breaks=c('Usa molt', 'Usa força', 'Usa mitjanament', 'Usa poc', 'No usa mai'))
dev.off() # Desem el fitxer







