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

#Pacote de cor
#install.packages("RColorBrewer")
library(RColorBrewer)

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
dados_tamandua2 <- list.files(pattern = 'QUALITATIVE.csv')
dados_tamandua2 <- read.csv(dados_tamandua2,sep=';')


biom_2019 <- read_biomes(year = 2019, simplified = TRUE) %>% 
  filter(name_biome != "Sistema Costeiro") %>% 
  sf::st_transform(crs = 4326)
biom_2019


dados_tamandua_sf <- dados_tamandua2 %>% 
  dplyr::filter(COUNTRY=='BRAZIL'& SPECIES == "Myrmecophaga tridactyla" | SPECIES == "Tamandua tetradactyla") %>% 
  tidyr::drop_na(LONG_X, LAT_Y) %>% 
  dplyr::mutate(lon = as.numeric(LONG_X), lat = as.numeric(LAT_Y)) %>% 
  dplyr::filter(lon > -180 & lon < 180, lat > -90, lat < 90) %>% 
  sf::st_as_sf(coords = c("LONG_X", "LAT_Y"), crs = 4326) %>% 
  .[biom_2019, ]
dados_tamandua_sf


#Selecionando a cor do mapa e criando um objeto para ela
pastel <- brewer.pal(10, "Pastel1")

#Mapa do Maurício
png(filename = here::here("02_mapas", "map_tamandua_bioma.png"),
    width = 20, height = 20, units = "cm", res = 300)
tm_shape(biom_2019) +
  tm_polygons(col = "name_biome", pal = pastel) +
  tm_shape(dados_tamandua_sf) +
  tm_bubbles(size = .058, col = "SPECIES", pal = c("blue", "red"), shape = 21) +
  # tm_facets(along = "year", free.coords = FALSE) +
  tm_layout(legend.position = c("left", "bottom"),
            legend.height = 0.45,
            legend.bg.color = "white",
            legend.frame = T,
            legend.frame.lwd = 2,
            bg.color = "antiquewhite",
            main.title = "Registros de duas espécies de tamanduá nos biomas brasileiros",
            main.title.position = "center",
            main.title.size = 1.5,
  ) +
  tm_compass(position = c("right", "top"), type = "4star", size = 3, show.labels = 2) +
  tm_scale_bar(text.size = 0.8) +
  # tm_grid(ticks = (labels.show = TRUE))
  tm_graticules(ticks = (labels.show = TRUE))
dev.off()


#==============================================================================

# MAPA 2
# Mapa animado p/ mostrar variação na abundância ao longo dos anos de registros

map_anim_tempo <-  tm_shape(biom_2019) +
  tm_polygons(col = "name_biome", pal = viridis::viridis(6)) +
  tm_shape(dados_tamandua_sf) +
  tm_bubbles(size = .06, col = "SPECIES", pal = c("cyan4", "purple")) +
  tm_facets(along = "COL_STRT_YR", free.coords = FALSE)+
  tm_layout(legend.position = c("left", "bottom")) +
  tm_compass() +
  tm_scale_bar() +
  tm_graticules(lines = FALSE)


tmap::tmap_animation(tm = map_anim_tempo, 
                     filename = here::here("03_dados", "mapas", "map_anim_tempo.gif"), 
                     delay = 30)
#'
#'
#'
#'
#'
#'
