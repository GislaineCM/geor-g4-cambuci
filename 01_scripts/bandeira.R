library(readr)
library(here)

#Importando a planilha da spp T. bandeira
dados_tamandua <- readr::read_csv(here::here("00_dadosbrutos", 'tamanduas.csv'))
dados_tamandua


# nº de indivídiuos por habitat
# Abundancia das duas spp.
dados_tamandua |>  
  ggplot2::ggplot(ggplot2::aes(y=habitat))+
  ggplot2::geom_bar()+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Abundância')+
  ggplot2::ylab(label= 'Habitat')


#bandeira |>
  #ggplot2::ggplot(ggplot2::aes(x=as.numeric(long_x),y=as.numeric(lat_y)))+
  #ggplot2::geom_jitter(ggplot2::aes(col=as.character(year)))

#dendograma fazeer 
