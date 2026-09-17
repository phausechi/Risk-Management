# Análise de um portfólio teórico durante a pandemia: Historical vs. Parametric VaR

## Sobre o Projeto

Este projeto tem como objetivo calcular e comparar as duas mais simples metodologias de mensuração de risco de mercado : o **Value at Risk (VaR) Histórico** e o **VaR Paramétrico (Variância-Covariância)**, além do **Expected Shortfall (ES)**.


Os dados históricos de preços de fechamento (`price_close`) foram obtidos via API do Yahoo Finance (`yfR`), simulando uma carteira com alocação customizada nos quatro maiores ativos da B3 em valor (`PETR4`, `ITUB4`, `VALE3` e `BPAC11`). Os códigos são diretos: o VaR histórico é dado por multiplicar o portfólio teórico pelos retornos observados e depois pedir o quinto percentil à esquerda. O VaR paramétrico foi feito sob a hipótese de normalidade e obtido pelos cálculos usuais de covariância da amostra. 



## Tecnologias Utilizadas

* **Linguagem:** R

* **Manipulação de Dados:** `tidyverse` (`dplyr`, `tidyr`, `ggplot2`)

* **Extração de Dados Financeiros:** `yfR`



## Metodologia

1. **Coleta de Dados:** Extração diária de preços de fechamento no período de 2020 a 2023.

2. **Retornos da Carteira:** Pelos retornos simples, como proposto por Hull.

3. **VaR Histórico de 95%:** Abordagem não-paramétrica baseada nos percentis empíricos da distribuição real dos retornos da carteira.

4. **VaR Paramétrico de 95%:** Suposição de normalidade dos retornos, utilizando a matriz de covariância dos ativos e o desvio padrão da carteira.

5. **Expected Shortfall (ES) de 95%:** Métrica de perda esperada além do limiar do VaR. O histórico foi obtido como a média das perdas que atravessavam o threshold do VaR, enquanto o paramétrico foi obtido pela fórmula usual, retirada de Hull. 

## Discussão dos resultados

<img width="1614" height="972" alt="Rplot" src="https://github.com/user-attachments/assets/351fd145-eed2-4d97-b160-7762755dfaad" />

Os retornos históricos foram plotados contra distribuição normal teórica. A linha vermelha representa o resultado do VaR paramétrico enquanto a azul representa o resultado do histórico. O portfólio é composto por R$4000 em BPAC11, R$2000 em ITUB4, R$1000 em PETR4 e R$3000 em VALE3. 

Nota-se, como esperado, que os retornos são **leptocúrticos**, tendo mais massa no centro e caudas, e menos ao meio. Observa-se também que **o paramétrico retornou um VaR de R$ -404**, enquanto **o histórico retornou R$ -313**. Os ES contam uma história diferente, no entanto: **a perda média que cruza o threshold do paramétrico é de R$ -507 enquanto a do histórico é de R$ -544**.
    
