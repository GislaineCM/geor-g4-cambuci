---
  #' Titulo: Projeto Final - Analise de dados geoespaciais no R
  #' Autores: Daiana, Gislaine, Luana, Rafael, Willian
  #' Data: 2021-11-03
  #' ---
  
  # PERGUNTA: Entender como os tipos de habitats influenciam a abundância de 
  # tamandua-bandeira (Myrmecophaga tridactyla) e de tamandua-mirim (Tamandua 
  # tetradactyla) no Brasil.
  
  # OBJETIVO: 
  

# Carregando os pacotes necessarios
library(readr)
library(here)
library(ggplot2)
library(geobr)
library(dplyr)

#===============================================================================

#Importando os dados de ocorrencia das spp
dados_tamandua <- readr::read_csv(here::here("00_dadosbrutos", 'tamanduas.csv'))
dados_tamandua

#PLOT 1
# Número de indivídiuos total por habitat
# Abundancia das duas spp.

dados_tamandua |>  
  ggplot2::ggplot(ggplot2::aes(y=habitat))+
  ggplot2::geom_bar()+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Abundância')+
  ggplot2::ylab(label= 'Habitat')
#===============================================================================

# PLOT 2
# Número de indivídiuos de cada espécie por habitat
# Abundancia de cada spp.

dados_tamandua |>  
  ggplot2::ggplot(ggplot2::aes(y=habitat,fill=specie))+
  ggplot2::geom_bar(position='dodge')+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Abundância')+
  ggplot2::ylab(label= 'Habitat')

#==============================================================================
# PLOT 3
## Variação temporal da Abundancia das duas spp.por habitat
dados_tamandua |>  
  dplyr::filter(year>2008)|>
  ggplot2::ggplot(ggplot2::aes(y=habitat,fill=specie))+
  ggplot2::geom_bar(position='dodge')+
  ggplot2::facet_wrap(~year,scale='free')+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Abundância')+
  ggplot2::ylab(label= 'Habitat')
#===============================================================================

## PLOT 4
# Dispersão spp. no Brasil


###csv original qualitativo
 
dados_tamandua2 <- list.files(pattern = 'QUALITATIVE.csv')
dados_tamandua2 <- read.csv(dados_tamandua2,sep=';')

# Dados Estados do Brasil IBGE para 2020
br_2020 <- read_country(year = 2020, simplified = TRUE)
br_2020
plot(br_2020$geom)


# Dados Biomas do Brasil IBGE para 2019
biom_2019 <- read_biomes(year = 2019, simplified = TRUE)
biom_2019
plot(biom_2019$geom)

plot(br_2020$geom, col = "gray", main = NA, axes = TRUE, graticule = TRUE)
#plot(dados_tamandua2$geometry, pch = 20, add = TRUE)


dados_tamandua2 |> 
  dplyr::filter(COUNTRY=='BRAZIL'& SPECIES == "Myrmecophaga tridactyla" | SPECIES == "Tamandua tetradactyla")|> 
  ggplot2::ggplot(ggplot2::aes(x=as.numeric(LONG_X), y=as.numeric(LAT_Y),color=SPECIES))+
  ggplot2::geom_point()+
  ggplot2::xlab(label = "Longitude")+
  ggplot2::ylab(label="Latitude")+
  ggplot2::xlim(-80,-30)+
  ggplot2::ylim(-40,10)


###csv original quantitativo
dados_tamandua3 <- list.files(pattern = 'QUANTITATIVE.csv')
dados_tamandua3 <- read.csv(dados_tamandua3)

#dados_tamandua3 |> 
#dplyr::filter(SPECIES == "Myrmecophaga tridactyla" | SPECIES == "Tamandua tetradactyla")|> 
#ggplot2::ggplot(ggplot2::aes(x=as.numeric(LONG_X), y=as.numeric(LAT_Y),color=SPECIES))+
#ggplot2::geom_point()+
#ggplot2::xlab(label = "Longitude")+
#ggplot2::ylab(label="Latitude")

