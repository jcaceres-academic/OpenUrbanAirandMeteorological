# ============================================================
# Fig. 10b — Regenerar completamente el heatmap con etiquetas completas
# ============================================================

library(ggplot2)
library(readr)
library(tidyr)
library(dplyr)

# --- 1. Leer la tabla de correlaciones ---
cor_df <- read_csv("Table_4_Correlations.csv")

# --- 2. Pasar a formato largo y definir etiquetas completas ---
cor_long <- cor_df %>%
  pivot_longer(cols = c(NO2, O3), names_to = "Pollutant", values_to = "rho") %>%
  mutate(
    term = factor(term,
                  levels = c("WS", "T", "SR", "RH", "PREC"),
                  labels = c("Wind Speed", "Temperature", "Solar Radiation", "Relative Humidity", "Precipitation"))
  )

# --- 3. Crear el gráfico desde cero ---
p <- ggplot(cor_long, aes(x = Pollutant, y = term, fill = rho)) +
  geom_tile(color = "white", linewidth = 0.5) +
  geom_text(aes(label = sprintf("%.2f", rho)), color = "black", size = 4) +
  scale_fill_gradient2(
    low = "#2166AC", mid = "white", high = "#B2182B",
    midpoint = 0, limits = c(-1, 1),
    name = expression(rho)
  ) +
  scale_x_discrete(labels = c("NO2" = expression(NO[2]), "O3" = expression(O[3]))) +
  labs(
    x = "Pollutant",
    y = "Meteorological variable",
    title = expression("Fig. 10b. Spearman correlations between " * NO[2] * "/" * O[3] * " and meteorological variables")
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.title.x = element_text(face = "bold", margin = margin(t = 10)),
    axis.title.y = element_text(face = "bold", margin = margin(r = 10)),
    panel.grid = element_blank()
  )

# --- 4. Guardar la nueva versión ---
dir.create("images", showWarnings = FALSE)
ggsave("images/Fig10b_Correlations.png", plot = p, width = 6, height = 4, dpi = 300)
print(p)

