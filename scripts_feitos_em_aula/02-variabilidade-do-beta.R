library(tidyverse)
library(glue)
b1s <- c()

visao <- readr::read_csv2("https://raw.githubusercontent.com/curso-r/main-regressao-linear/master/misc/visao.csv")
glimpse(visao)

visao_amostra <- sample_n(visao, 10)

ggplot(data = visao, aes(x = idade, y = distancia)) +
  geom_point() +
  geom_smooth(data = visao_amostra, method = "lm", se = FALSE,fullrange = TRUE) +
  geom_point(data = visao_amostra, colour = "red", size = 3) +
  lims(x = c(15, 90), y = c(85, 200))

lm(distancia ~ idade, data = visao_amostra)

summary(lm(distancia ~ idade, data = visao_amostra))

b1 <- lm(distancia ~ idade, data = visao_amostra)[[1]][2]
b1s <- c(b1s, b1)

hist(b1s, breaks = 100)


summary(lm(distancia ~ idade, data = visao))
summary(lm(distancia ~ idade, data = visao_amostra))



a <- replicate(1000, {
  visao_amostra <- sample_n(visao, 10)

  b1 <- lm(distancia ~ idade, data = visao_amostra)[[1]][2]
  b1s <<- c(b1s, b1)
})

hist(b1s, breaks = 100)


# HIPOTESE ZERO (H0)
# A minha hipótese é de que o B1 = 0
# B1 ~ t(media = -1)
visao_amostra <- sample_n(visao, 10)
lm(distancia ~ idade, data = visao_amostra)
summary(lm(distancia ~ idade, data = visao_amostra))

# VALOR-P
# B1 = 0 ------> distribuição do B1 ~ t(media = 0)
lm(distancia ~ idade, data = visao_amostra)
hist(b1s - mean(b1s), breaks = 100, xlim = c(-2, 1))

# Conclusão: a hipótese de que B1 = 0 não é plausível. Os dados
# mostraram que essa hipótese é altamente improvável de ser verdade.


df <- data.frame(
  idade = sample.int(80, 30)
) %>%
  mutate(
    # y = b0 + b1 * x
    distancia = 0 + 0 * idade + rnorm(30)
  )

df %>%
  ggplot(aes(x = idade, y = distancia)) +
  geom_point() +
  lims(y = c(-2, 2))


# código que simula varios B1s
a <- replicate(1000, {
  df <- sample_n(df, 10)

  b1 <- lm(distancia ~ idade, data = df)[[1]][2]
  b1s <<- c(b1s, b1)
})

hist(b1s, breaks = 100, xlim = c(-0.1, 0.1))
points(-0.03, 0, col = "red")
points(-0.0, 0, col = "red")
# VALOR-P
# o quão provável de eu ter observado -1.125 se B1 realmente fosse 0
# Valor-p ~ 0
# Valor-p ~ 0.25
# Valor-p ~ 1


t = (-1.125 - 0)/0.2084

x <- seq(-5.4, 5.4, by = 0.1)
pt <- dt(x, df = 30)
pt <- ifelse(x > 0, pt, 0)
plot(x, pt, type = "l")
points(abs(-1.125) , 0, col = "red")
abs(-1.125)

2*(1 - pt(abs(t), 8))

-1.1249 - 0.2084 * 1.96
-1.1249 + 0.2084 * 1.96

# B1 = 0 ???
B1h = -1.1249
[-1.533, -0.716] # o zero tá fora desse intervalo. Então, eu acho que a H0 é falsa.

abs(t)
modelinho <- lm(distancia ~ idade, data = visao_amostra)
linearHypothesis(modelinho, c("(Intercept)" = 0, "idade" = 10))
summary(modelinho)

tbl_regression(modelinho)
glance(modelinho)
plot(modelinho)

mean(visao$distancia)
summary(lm(distancia ~ 1, data = visao))

1 - (14.64^2)/(27.28^2)
