# Análise de um portfólio teórico durante a pandemia: Historical vs. Parametric VaR

## Sobre o Projeto

Este projeto tem como objetivo calcular e comparar as duas metodologias de mensuração de risco de mercado mais simples: o **Value at Risk (VaR) Histórico** e o **VaR Paramétrico (Variância-Covariância)**, além do **Expected Shortfall (ES)**.


Os dados históricos de preços de fechamento (`price_close`) foram obtidos via API do Yahoo Finance (`yfR`), simulando uma carteira com alocação customizada nos quatro maiores ativos da B3 em valor (`PETR4`, `ITUB4`, `VALE3` e `BPAC11`).



## Tecnologias Utilizadas

* **Linguagem:** R

* **Manipulação de Dados:** `tidyverse` (`dplyr`, `tidyr`, `ggplot2`)

* **Extração de Dados Financeiros:** `yfR`



## Metodologia

1. **Coleta de Dados:** Extração diária de preços de fechamento no período de 2020 a 2023.

2. **Retornos da Carteira:** Cálculo dos retornos simples ponderados pelo vetor de alocação financeira (`$vec <- c(4000, 2000, 1000, 3000)$`).

3. **VaR Histórico:** Abordagem não-paramétrica baseada nos percentis empíricos da distribuição real dos retornos da carteira.

4. **VaR Paramétrico:** Suposição de normalidade dos retornos, utilizando a matriz de covariância dos ativos e o desvio padrão da carteira.

5. **Expected Shortfall (ES):** Métrica de perda esperada além do limiar do VaR.



## Estrutura do Repositório

```text

├── var_analysis.R     
├── var_comparison.png 
└── README.md          
