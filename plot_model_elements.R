library(data.table)
library(ggplot2)

mtcars <- data.table(mtcars)

model <- lm(data=mtcars, hp ~ cyl + wt + gear + carb)

model$coefficients

dt <- data.table(fitted = numeric(length = nrow(mtcars)))
dt[, fitted := as.numeric(as.matrix(mtcars[, .(cyl, wt, gear, carb)]) %*% as.matrix(model$coefficients[2:5]) + model$coefficients[1])]

dt[, intercept := model$coefficients[1]]
dt[, cyl := as.numeric(as.matrix(mtcars[, .(cyl)]) %*% as.matrix(model$coefficients[2]))]
dt[, wt := as.numeric(as.matrix(mtcars[, .(wt)]) %*% as.matrix(model$coefficients[3]))]
dt[, gear := as.numeric(as.matrix(mtcars[, .(gear)]) %*% as.matrix(model$coefficients[4]))]
dt[, carb := as.numeric(as.matrix(mtcars[, .(carb)]) %*% as.matrix(model$coefficients[5]))]

round(dt[, intercept + cyl + wt + gear + carb], 4) == round(dt$fitted, 4)

ggplot(data = dt) +
  geom_line(aes(x = 1:32, y = intercept + cyl)) + 
  geom_line(aes(x = 1:32, y = intercept + cyl + wt)) + 
  geom_line(aes(x = 1:32, y = intercept + cyl + wt + gear)) + 
  geom_line(aes(x = 1:32, y = intercept + cyl + wt + gear + carb))
