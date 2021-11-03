library(readr)
library(here)

#Importando a planilha da spp T. bandeira
bandeira <- readr::read_csv(here::here("00_dadosbrutos", 'tamandua_bandeira.csv.csv'))
bandeira

#Importando a planilha das duas especies
xen_spp <- readr::read_csv(here::here("00_dadosbrutos", 'tamanduas.csv.csv'))
xen_spp

# nº de indivídiuos por habitat
# Abundancia da spp. bandeira
bandeira |>  
  ggplot2::ggplot(ggplot2::aes(y=habitat))+
  ggplot2::geom_bar()+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Abundância')+
  ggplot2::ylab(label= 'Habitat')

# Abundancia das duas spp.
xen_spp |>  
  ggplot2::ggplot(ggplot2::aes(y=habitat))+
  ggplot2::geom_bar()+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Abundância')+
  ggplot2::ylab(label= 'Habitat')


#bandeira |>
  #ggplot2::ggplot(ggplot2::aes(x=as.numeric(long_x),y=as.numeric(lat_y)))+
  #ggplot2::geom_jitter(ggplot2::aes(col=as.character(year)))

#dendograma fazeer 
