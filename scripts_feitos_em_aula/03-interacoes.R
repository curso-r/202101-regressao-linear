library(tidyverse)

params_sem_parabola <- expand.grid(
  interceptA = -2:2,
  interceptB = -2:2,
  interceptC = -2:2,
  slopeA = c(-4, 1, 0, 1, 4),
  slopeB = c(-4, 1, 0, 1, 4),
  slopeC = c(-4, 1, 0, 1, 4),
  quadraticoA = 0,
  quadraticoB = 0,
  quadraticoC = 0
)

params_com_parabola <- expand.grid(
  interceptA = -1:1,
  interceptB = -1:1,
  interceptC = -1:1,
  slopeA = -1:1,
  slopeB = -1:1,
  slopeC = -1:1,
  quadraticoA = -1:3,
  quadraticoB = -1:3,
  quadraticoC = -1:3
)

params <- bind_rows(
  params_sem_parabola,
  params_com_parabola
) %>%
  distinct() %>%
  as.matrix()

set.seed(2)
n = 100
x <- tibble(
  var_continua = runif(n),
  var_categ = sample(c("A", "B", "C"), n, replace = TRUE) %>% as.factor()
)
xm <- model.matrix(~ 0 + var_categ + var_continua:var_categ + I(var_continua^2):var_categ, data = x)


interacoes <- function(parametros = NULL, com_parabolas = FALSE, cores = TRUE) {
  
  if(is.null(parametros)) {
    if(com_parabolas) {
      parametros <- params[sample.int(nrow(params), 1),]
    } else {
      parametros <- unlist(params_sem_parabola[sample.int(nrow(params_sem_parabola), 1),])
    }
  }
  
  y <- as_tibble(xm %*% t(t(parametros)), .name_repair = "minimal") %>%
    set_names("y")
  
  y <- y + rnorm(nrow(y), sd = 0.2)
  
  xy <- bind_cols(x, y)
  
  base <- ggplot(xy, aes(x = var_continua)) 
  
  if(cores) {
    base <- base + geom_point(aes(colour = var_categ))
  } else {
    base <- base + geom_point()
  }
  
  base <- base +
    geom_vline(xintercept = 0, colour = "grey40") +
    geom_hline(yintercept = 0, colour = "grey40") +
    theme_minimal()
  
  
  modelo <- lm(y ~ (var_continua)* var_categ, data = xy)
  
  grafico <- base + aes(y = y) + geom_smooth(method = "lm", se = FALSE, colour = "black") 
  if(all(parametros[7:9] == 0)) {
    if(cores) {
      grafico <- grafico + geom_smooth(aes(colour = var_categ), method = "lm", se = FALSE)
    } else {
      grafico <- grafico + geom_smooth(method = "lm", se = FALSE)
    }
  } else {
    if(cores) {
      grafico <- grafico + geom_smooth(aes(colour = var_categ), method = "lm", formula = y ~ poly(x, 2), se = FALSE)
    } else {
      grafico <- grafico + geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE)
    }
  }
    
  summary <- summary(modelo)
  list(
    grafico = grafico,
    summary = summary,
    parametros = parametros,
    modelo = modelo
  )
} 


# sem efeito de nada
infos <- interacoes(c(
  intercepto_do_A = 0, 
  intercepto_do_B = 0, 
  intercepto_do_C = 0, 
  
  inclinacao_do_A = 0, 
  inclinacao_do_B = 0, 
  inclinacao_do_C = 0, 
  
  ao_quadrado_do_A = 0, 
  ao_quadrado_do_B = 0, 
  ao_quadrado_do_C = 0
)
)
infos$summary
infos$grafico
infos$parametros %>% t %>% t



# apenas efeito da var_categ
infos <- interacoes(c(
  intercepto_do_A = 0, 
  intercepto_do_B = 1, 
  intercepto_do_C = 2, 
  
  inclinacao_do_A = 0, 
  inclinacao_do_B = 0, 
  inclinacao_do_C = 0, 
  
  ao_quadrado_do_A = 0, 
  ao_quadrado_do_B = 0, 
  ao_quadrado_do_C = 0
)
)
infos$summary
infos$grafico
infos$parametros %>% t %>% t




# apenas efeito da var_continua
infos <- interacoes(c(
  intercepto_do_A = 0, 
  intercepto_do_B = 0, 
  intercepto_do_C = 0, 
  
  inclinacao_do_A = 1, 
  inclinacao_do_B = 1, 
  inclinacao_do_C = 1, 
  
  ao_quadrado_do_A = 0, 
  ao_quadrado_do_B = 0, 
  ao_quadrado_do_C = 0
  )
)
infos$summary
infos$grafico
infos$parametros %>% t %>% t




# efeitos marginais da var_categ e var_continua
infos <- interacoes(c(
  intercepto_do_A = 0, 
  intercepto_do_B = 1, 
  intercepto_do_C = 2, 
  
  inclinacao_do_A = 1, 
  inclinacao_do_B = 1, 
  inclinacao_do_C = 1, 
  
  ao_quadrado_do_A = 0, 
  ao_quadrado_do_B = 0, 
  ao_quadrado_do_C = 0
)
)
infos$summary
infos$grafico
infos$parametros %>% t %>% t




# efeito de interação entre var_categ e var_continua
infos <- interacoes(c(
  intercepto_do_A = 0, 
  intercepto_do_B = 1, 
  intercepto_do_C = 2, 
  
  inclinacao_do_A = -1, 
  inclinacao_do_B = 1, 
  inclinacao_do_C = 2, 
  
  ao_quadrado_do_A = 0, 
  ao_quadrado_do_B = 0, 
  ao_quadrado_do_C = 0
)
)
infos$summary
infos$grafico
infos$parametros %>% t %>% t



infos <- interacoes()
infos$summary
infos$grafico
infos$parametros

# Exemplo: Paradóxo de Simpson 
set.seed(1)
infos <- interacoes(c(
    intercepto_do_A = -1, 
    intercepto_do_B = 0, 
    intercepto_do_C = 1, 
    
    inclinacao_do_A = 2, 
    inclinacao_do_B = 0, 
    inclinacao_do_C = -2, 
    
    ao_quadrado_do_A = 0, 
    ao_quadrado_do_B = 0, 
    ao_quadrado_do_C = 0
  ),
  cores = TRUE
)

infos$summary
infos$grafico
infos$parametros






# exercício1: gere um gráfico e avalie:
# se há efeito de 'var_continua'
# se há efeito de 'var_categ'
# se há interação entre 'var_continua' com 'var_categ' em relação ao intercepto
# se há interação entre 'var_continua' com 'var_categ' em relação a inclinação
set.seed(1)
infos <- interacoes()
infos$grafico
# se há efeito de 'var_continua'

# se há efeito de 'var_categ'

# se há interação entre 'var_continua' com 'var_categ' em relação a inclinação



# exercício2: repita o exercício 1, mas agora com outro gráfico sorteado.
set.seed(896)
infos <- interacoes()
infos$grafico
# se há efeito de 'var_continua'

# se há efeito de 'var_categ'

# se há interação entre 'var_continua' com 'var_categ' em relação a inclinação



# exercício3: repita o exercício 1, mas agora com outro gráfico sorteado.
set.seed(905)
infos <- interacoes()
infos$grafico
infos$summary

# se há efeito de 'var_continua'

# se há efeito de 'var_categ'

# se há interação entre 'var_continua' com 'var_categ' em relação a inclinação



