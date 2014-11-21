## Available at:
## http://pseudotrue.com/671/unemployment_showdown.R

library(XML)
library(lattice)

d <-read.csv("http://pseudotrue.com/671/forecasts_2014.csv")
plot(d[,c("gray", "team1", "team2", "team3")])
stripplot(team ~ weight, data.frame(team = rep(1:3, each = 50),
            state = d$state,
            weight = c(d[,c("w1", "w2", "w3")], recursive = TRUE)),
          cex = 1.5, lex = 2, jitter = .5, col = rgb(0,0,0,.75))

dnew <- readHTMLTable("http://www.bls.gov/web/laus/laumstrk.htm",
                      skip.rows = 1, stringsAsFactors = FALSE)[[1]]

d$unemp <- as.numeric(sapply(d$state, function(s)
    dnew[toupper(state.name[state.abb == s]) == dnew$State,"Rate"]))

wmse <- function(forecast, target = d$unemp, weights = d$w_avg) {
    sqrt(sum((forecast - target)^2 * weights))
}
wmse(d$team1)
wmse(d$team2)
wmse(d$team3)
wmse(d$gray)

d$patch3 <- c(d$team3[1:33], d$team3[35:50], 4.707913)
plot(d[,c("gray", "team1", "team2", "patch3")])
wmse(d$patch3)
wmse(d$patch3, weights = rep(1/50, 50))
wmse(d$team1, weights = rep(1/50, 50))
wmse(d$team2, weights = rep(1/50, 50))
