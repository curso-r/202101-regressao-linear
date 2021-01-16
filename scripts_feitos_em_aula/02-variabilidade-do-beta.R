library(tidyverse)
library(glue)
b1s <- c()

visao <- readr::read_csv2("https://raw.githubusercontent.com/curso-r/main-regressao-linear/master/misc/visao.csv")
glimpse(visao)

visao_amostra <- sample_n(visao, 5)

ggplot(data = visao, aes(x = idade, y = distancia)) +
  geom_point() +
  geom_smooth(data = visao_amostra, method = "lm", se = FALSE,fullrange = TRUE) +
  geom_point(data = visao_amostra, colour = "red", size = 3) +
  lims(x = c(15, 90), y = c(85, 200))

lm(distancia ~ idade, data = visao_amostra)

summary(lm(distancia ~ idade, data = visao_amostra))

b1 <- lm(distancia ~ idade, data = visao_amostra)[[1]][2]
b1s <- c(b1s, b1)



summary(lm(distancia ~ idade, data = visao))
summary(lm(distancia ~ idade, data = visao_amostra))

