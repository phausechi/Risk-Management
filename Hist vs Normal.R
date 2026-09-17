library(yfR)
library(tidyverse)

#Importando dados do Yahoo
names <- c("PETR4.SA", "ITUB4.SA", "VALE3.SA", "BPAC11.SA")

stocks <- yf_get(tickers = names, 
                      first_date = "2020-01-01",  
                      last_date = "2023-01-01")

price_close <- stocks %>% 
  select(Data = ref_date, Ticker = ticker, Price = price_close)

matrix_wide <- price_close %>% pivot_wider(
  names_from = "Ticker",
  values_from = "Price"
)

#Calculando retornos aritméticos
returns <-mutate (matrix_wide,
                  across(c(PETR4.SA, ITUB4.SA, VALE3.SA, BPAC11.SA),
                         \(x) x / lag(x) - 1))%>%
  na.omit()

#Cálculo matricial para o VaR histórico
transpose <-t(returns[-1])
vec <-c(4000,2000,1000,3000)
result <- as.numeric(vec %*% transpose)
VaR_data <-tibble(result)

#Var histórico de 95%
q5 <- quantile(result, 0.05, type = 1)
q5

#ES histórico de 95%
ES_data<-as_tibble(result[result < q5])
ES95hist <- mean(result[result <= q5])
ES95hist


#VaR e ES paramétrico de 95%
covar <- cov(returns[-1])
standard_deviation <- sqrt(vec%*%covar%*%vec)
VaR95 <-qnorm(0.05, mean=0, sd=standard_deviation)
VaR95
numerador <-exp(1)^((-qnorm(0.05)^2)/2)
denominador <- sqrt(2*pi)*(1-0.95)
ES95param <- standard_deviation*(numerador/denominador)
ES95param


#Plotando comparação dos modelos
ggplot(VaR_data, aes(x = result)) +
  geom_histogram(aes(y = after_stat(density)),
                 bins = 100,
                 fill = "lightblue",
                 color = "white")+
  stat_function(
    fun = dnorm,
    args = list(sd = standard_deviation),
    color = "red",
    linewidth = 1.2
  ) +
  geom_vline(
    xintercept = q5,
    color = "blue",
    linetype = "dashed",
    linewidth = 1
  ) +
  geom_vline(
    xintercept = VaR95,
    color = "red",
    linetype = "dashed",
    linewidth = 1
  ) +
  labs(
    title = "Retornos da carteira: VaR Histórico vs. Paramétrico",
    x = "Retorno da carteira",
    y = "Densidade"
  ) +
  theme_minimal()+
coord_cartesian(xlim = c(-1000, 1000))
