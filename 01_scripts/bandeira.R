bandeira<-readr::read_csv('tamandua_bandeira.csv.csv')
bandeira |>
  ggplot2::ggplot(ggplot2::aes(x=as.numeric(long_x),y=as.numeric(lat_y)))+
  ggplot2::geom_jitter(ggplot2::aes(col=as.character(year)))


# nº de indivídiuos por habitat

bandeira |>  
  ggplot2::ggplot(ggplot2::aes(y=habitat))+
  ggplot2::geom_bar()+
  ggplot2::theme_classic()+
  ggplot2::xlab(label = 'Densidade')+
  ggplot2::ylab(label= 'Habitat')

#dendograma fazeer 
