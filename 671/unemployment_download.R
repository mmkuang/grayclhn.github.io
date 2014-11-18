library(quantmod)

abbrevs <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL",
"GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
"MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM",
"NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN",
"TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")

cat("date,state,unemployment\n", file = "unemp.csv")
for (s in abbrevs) {
    dname <- sprintf("%sUR", s)
    d <- data.frame(s, getSymbols(dname, src = "FRED", auto.assign = FALSE))
    write.table(d, file = "unemp.csv", append = TRUE, sep = ",", quote=FALSE,
                col.names = FALSE)
}

