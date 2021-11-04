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
library(tidyverse)
library(tmap)
#===============================================================================

#Importando os dados de ocorrencia das spp
dados_tamandua <- readr::read_csv(file = "00_dadosbrutos/tamanduas.csv")
dados_tamandua

#PLOT 1
# Número de indivídiuos total por habitat
# Abundancia das duas spp.

#dir.create(here::here("03_graficos"))
png(filename = here::here("03_graficos", "graf_indiv_habit.png"),
    width = 20, height = 20, units = "cm", res = 300)
dados_tamandua |>  
  ggplot2::ggplot(ggplot2::aes(y=habitat))+
  ggplot2::geom_bar()+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Abundância')+
  ggplot2::ylab(label= 'Habitat')
dev.off()

#===============================================================================

# PLOT 2
# Número de indivídiuos de cada espécie por habitat
# Abundancia de cada spp.

png(filename = here::here("03_graficos", "graf_indiv_habit2.png"),
    width = 20, height = 20, units = "cm", res = 300)
dados_tamandua |>  
  ggplot2::ggplot(ggplot2::aes(y=habitat,fill=specie))+
  ggplot2::geom_bar(position='dodge')+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Abundância')+
  ggplot2::ylab(label= 'Habitat')
dev.off()

#==============================================================================

# PLOT 3
## Variação temporal da Abundancia das duas spp.por habitat

png(filename = here::here("03_graficos", "graf_abund_tempo.png"),
    width = 30, height = 20, units = "cm", res = 300)
dados_tamandua |>  
  dplyr::filter(year>2008)|>
  ggplot2::ggplot(ggplot2::aes(y=habitat,fill=specie))+
  ggplot2::geom_bar(position='dodge')+
  ggplot2::facet_wrap(~year,scale='free')+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Abundância')+
  ggplot2::ylab(label= 'Habitat')
dev.off()

#===============================================================================

# MAPA 1
## Criando e exportando mapa de registros para os biomas brasileiros
# Dados Biomas do Brasil IBGE para 2019
dados_tamandua_sf <- dados_tamandua2 %>% 
  dplyr::filter(COUNTRY=='BRAZIL'& SPECIES == "Myrmecophaga tridactyla" | SPECIES == "Tamandua tetradactyla") %>% 
  tidyr::drop_na(LONG_X, LAT_Y) %>% 
  dplyr::mutate(lon = as.numeric(LONG_X), lat = as.numeric(LAT_Y)) %>% 
  dplyr::filter(lon > -180 & lon < 180, lat > -90, lat < 90) %>% 
  sf::st_as_sf(coords = c("LONG_X", "LAT_Y"), crs = 4326) %>% 
  .[biom_2019, ]
dados_tamandua_sf


biom_2019 <- read_biomes(year = 2019, simplified = TRUE) %>% 
  filter(name_biome != "Sistema Costeiro") %>% 
  sf::st_transform(crs = 4326)
biom_2019


png(filename = here::here("02_mapas", "map_tamandua_bioma.png"),
    width = 20, height = 20, units = "cm", res = 300)
tm_shape(biom_2019) +
  tm_polygons(col = "name_biome", pal = viridis::viridis(6)) +
  tm_shape(dados_tamandua_sf) +
  tm_bubbles(size = .06, col = "SPECIES", pal = c("cyan4", "purple")) +
  # tm_facets(along = "year", free.coords = FALSE) +
  tm_layout(legend.position = c("left", "bottom")) +
  tm_compass() +
  tm_scale_bar() +
  tm_graticules(lines = FALSE)
dev.off()
#############
#############
#############


## PLOT 4
# Dispersão spp. no Brasil
###csv original qualitativo
 
dados_tamandua2 <- list.files(pattern = 'QUALITATIVE.csv')
dados_tamandua2 <- read.csv(dados_tamandua2,sep=';')


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

