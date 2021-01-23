
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Configuração inicial

#### Passo 1: Instalar pacotes

``` r
install.packages("remotes")

# instalar pacote da Curso-R
remotes::install_github("curso-r/CursoR")

# instalar pacotes que vamos usar durante o curso
CursoR::instalar_dependencias()
```

#### Passo 2: Criar um projeto do RStudio

Faça um projeto do RStudio para usar durante todo o curso e em seguida
abra-o.

``` r
install.packages("usethis")
usethis::create_project("regressaolinear202101")
```

## Slides

| slide                              | link                                                                                 |
| :--------------------------------- | :----------------------------------------------------------------------------------- |
| slides/01-introducao-ao-curso.html | <https://curso-r.github.io/main-regressao-linear/slides/01-introducao-ao-curso.html> |
| slides/02-regressao-linear.html    | <https://curso-r.github.io/main-regressao-linear/slides/02-regressao-linear.html>    |

## Scripts usados em aula

| script             | link                                                                                          |
| :----------------- | :-------------------------------------------------------------------------------------------- |
| 00-laboratorio.Rmd | <https://curso-r.github.io/202101-regressao-linear/scripts_feitos_em_aula/00-laboratorio.Rmd> |

## Referências

#### Programação em R

  - [Livro da Curso-R (Curso-R)](https://livro.curso-r.com/)
  - [Tidyverse (Wickham H)](https://www.tidyverse.org/)
  - [R for Data Science (Wickham H)](https://r4ds.had.co.nz/)
  - [Advanced R (Wickham H)](https://adv-r.hadley.nz/)

#### Regressão Linear - Inferência

  - [Ciência de Dados: Fundamentos e
    Aplicações](https://curso-r.github.io/main-regressao-linear/referencias/Ci%C3%AAncia%20de%20Dados.%20Fundamentos%20e%20Aplica%C3%A7%C3%B5es.%20Vers%C3%A3o%20parcial%20preliminar.%20maio%20Pedro%20A.%20Morettin%20Julio%20M.%20Singer.pdf)
  - [Livro do Gilberto
    Paula](https://www.ime.usp.br/~giapaula/texto_2013.pdf)
  - Estatística básica 7a edição - BUSSAB e MORETTIN
  - [Tese sobre Regressão Linear da Sandra
    Rodrigues](https://ubibliorum.ubi.pt/bitstream/10400.6/1869/1/Tese%20Sandra%20Rodrigues.pdf)
  - [Aplicação de Regressão Linear
    Simples](https://www.ime.usp.br/~giapaula/slides_exemplo_cfoguete.pdf)
  - [Introduction to Econometrics with
    R](https://www.econometrics-with-r.org/6-5-the-distribution-of-the-ols-estimators-in-multiple-regression.html)

#### Regressão Linear - Predição

  - [Aprendizagem de Máquinas: Uma Abordagem Estatística (Rafael Izbicki
    e Thiago Mendonça, 2020)](http://www.rizbicki.ufscar.br/AME.pdf)
  - [Introduction to Statistical Learning (Hastie, et
    al)](https://www.ime.unicamp.br/~dias/Intoduction%20to%20Statistical%20Learning.pdf)
  - [Elements of Statistical Learning (Hastie, et
    al)](https://web.stanford.edu/~hastie/Papers/ESLII.pdf)
  - [Computer Age Statistical Inference (Hastie,
    Efron)](https://web.stanford.edu/~hastie/CASI_files/PDF/casi.pdf)
  - [Tidymodels (Kuhn, et al)](https://www.tidymodels.org/)
  - [Feature Engineering and Selection: A Practical Approach for
    Predictive Models (Kuhn, Kjell)](http://www.feat.engineering/)
  - [Kaggle](https://www.kaggle.com/)
