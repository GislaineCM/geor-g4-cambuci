#' ---
#' Titulo: Projeto Final - Analise de dados geoespaciais no R
#' Autores: Daiana, Gislaine, Luana, Rafael, Willian
#' Data: 2021-11-03
#' ---

# PERGUNTA: Entender como os tipos de habitats influenciam a abundância de 
# tamandua-bandeira (Myrmecophaga tridactyla) e de tamandua-mirim (Tamandua 
# tetradactyla) no Brasil.

# OBJETIVO: 


# Carregando os pacotes necessários
library(readr)
library(here)
library(ggplot2)

#Importando os dados de ocorrencia das spp
dados_tamandua <- readr::read_csv(here::here("00_dadosbrutos", 'tamanduas.csv'))
dados_tamandua


# n de indivídiuos por habitat
# Abundancia das duas spp.
dados_tamandua |>  
  ggplot2::ggplot(ggplot2::aes(y=habitat))+
  ggplot2::geom_bar()+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Abundância')+
  ggplot2::ylab(label= 'Habitat')


#dados_tamandua |>
  #ggplot2::ggplot(ggplot2::aes(x=as.numeric(long_x),y=as.numeric(lat_y)))+
  #ggplot2::geom_jitter(ggplot2::aes(col=as.character(year)))

