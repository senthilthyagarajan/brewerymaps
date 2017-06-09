library(rvest)
library(dplyr)
library(stringr)


html_file <- "beer.html"

page <- read_html(html_file) 

breweries<-page %>% html_nodes("div.brewery")
name<-sapply(breweries, function(x){x %>% html_node(".vcard .name") %>% html_text()})
address<-sapply(breweries, function(x){x %>% html_node(".vcard .address") %>% html_text()})
address_2<-sapply(breweries, function(x){x %>% html_node(".vcard .address_2") %>% html_text()})
type<-sapply(breweries, function(x){x %>% html_node(".vcard .brewery_type") %>% html_text()})
type<-gsub("^Type: ", "", type)
website<-sapply(breweries, function(x){x %>% html_node(".vcard .url a") %>% html_text()})

df <- tibble(name, address,address_2, type, website)
df
# Write CSV in R
write.csv(df, file = "beerdata.csv")