# Instalar pacotes se necessário
#if (!require(survival)) install.packages("survival")
#if (!require(survminer)) install.packages("survminer")
#if (!require(ggplot2)) install.packages("ggplot2")

# Carregar pacotes
library(survival)
library(survminer)
library(ggplot2)

### 1. Criar dados simulados (exemplo realista)

set.seed(123) # Para reprodutibilidade

n <- 200 # Número de pacientes

# Simular dados
data <- data.frame(
  time = rexp(n, rate = 0.02) * 100, # Tempo até evento (dias)
  event = rbinom(n, 1, 0.6),         # 1 = evento ocorreu (recaída), 0 = censurado
  treatment = sample(c("A", "B"), n, replace = TRUE),
  age = rnorm(n, mean = 60, sd = 10),
  gender = sample(c("M", "F"), n, replace = TRUE)
)

# Garantir que tempo não seja negativo
data$time <- pmax(data$time, 1)

# Visualizar primeiras linhas
head(data)

### 2. criar objeto de sobrevivência com Surv()

# Criar objeto de sobrevivência
survival <- Surv(time = data$time, event = data$event)

# Verificar estrutura
str(survival)

### 3.Estimar curvas de Kaplan-Meier por grupo de tratamento

# Curva de Kaplan-Meier por tratamento
km_fit <- survfit(survival ~ treatment, data = data)

# Resumo das curvas
summary(km_fit)

# Plotar curvas com confiança e número de risco
ggsurvplot(
  km_fit,
  data = data,
  pval = TRUE,                     # Mostrar p-valor do Log-Rank
  risk.table = TRUE,               # Tabela de risco
  conf.int = TRUE,                 # Intervalo de confiança
  ggtheme = theme_minimal(),
  title = "Survival Curves by Treatment",
  xlab = "Time (days)",
  ylab = "Probability of Relapse-Free Survival"
)

### 4. Teste Log-Rank para comparar grupos

# Teste Log-Rank (já aparece no gráfico acima, mas podemos extrair explicitamente)
logrank_test <- survdiff(survival ~ treatment, data = data)

# Estatística qui-quadrado
chisq_val <- logrank_test$chisq

# Graus de liberdade = número de grupos - 1
df <- length(logrank_test$n) - 1

# Calcular p-valor
p_val <- pchisq(chisq_val, df = df, lower.tail = FALSE)

# Exibir resultados
cat("\n--- LOG-RANK TEST ---\n")
cat("Chi-square =", round(chisq_val, 3), "\n")
cat("Degrees of freedom =", df, "\n")
cat("p-value =", format.pval(p_val, digits = 3), "\n")

### 5. Modelo de Cox Proporcional de Riscos

# Certifique-se de que o modelo foi ajustado com os dados disponíveis no ambiente
cox_model <- coxph(survival ~ treatment + age + gender, data = data)

# Resumo do modelo
summary(cox_model)

# Coeficientes e HR (Hazard Ratio)
exp(coef(cox_model)) # Hazard Ratios

# Agora, use `ggforest()` passando `data = dados` explicitamente
ggforest(cox_model, data = data, main = "Hazard Ratios – Cox Proportional Hazards Model")

### 6. Verificação de suposições do modelo de Cox (Proporcionalidade dos riscos)

# Teste de proporção de riscos
cox_zph <- cox.zph(cox_model)
print(cox_zph)

# Gráficos dos resíduos de Schoenfeld
plot(cox_zph, var = "treatment")
plot(cox_zph, var = "age")
plot(cox_zph, var = "gender")

### 7. Previsão de sobrevivência para novos pacientes (opcional)

# Novo paciente: tratamento B, 65 anos, feminino
new_patient <- data.frame(treatment = "B", age = 65, gender = "F")

# Prever sobrevivência
surv_pred <- summary(survfit(cox_model, newdata = new_patient), times = seq(0, 365, by = 30))

# Mostrar probabilidades de sobrevivência ao longo do tempo
print(surv_pred)

### 8. Salvar resultados (opcional)

# Salvar gráficos
ggsave("kaplan_meier_curves.png", width = 10, height = 6, dpi = 300)

# Salvar tabela de resumo do modelo de Cox
write.csv(summary(cox_model)$coefficients, "cox_coefficients_model.csv", row.names = TRUE)
