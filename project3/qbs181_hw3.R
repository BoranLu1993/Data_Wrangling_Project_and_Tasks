library(tidyverse)
library(magrittr)
library(ggplot2)
#1
tabletwo <- table2
tabletwo %>% filter(type==c("cases")) %>% select(country, year,count)
tabletwo %>% filter(type==c("population")) %>% select(country, year,count)
table_n <- tabletwo %>% spread(type, count) %>%
  mutate(rate=cases/population*10000)

table4a <- table4a
table4b <- table4b
table4a <- table4a %>% gather('1999','2000',key='year', value = 'case')
table4b <- table4b %>% gather('1999','2000',key='year', value = 'population')
newtable <- merge(table4a,table4b,by=c('country','year'))
newtable <- newtable %>% mutate(rate=case/population*10000)

#2
table4a %>% gather(1999,2000,key="year",value="cases")
#the code fail because the position for argument is wrong
table4a %>% gather("year", "cases",2:3)

#3
#a
library(nycflights13)
flights <- flights
fly <- flights %>% 
  select(year,month,day,flight)

fly <- flights %>% 
  mutate(date=substr(time_hour,1,10))

fly_ms <- fly %>% 
  group_by(date) %>% 
  summarise(sum=sum(n()))

fly_ms %>% ggplot(aes(x = as.Date(date), y = sum)) +
  geom_line()+
  xlab("date")
#This graph shows that the total flights times of each day in 2013 


#b
fly3b <- flights %>% select(dep_time,sched_dep_time,dep_delay)
fly3b$ID <- 1:336776
fly3b$hour1 <- fly3b$dep_time%/%100
fly3b$minute1 <- fly3b$dep_time%%100
fly3b$hour2 <- fly3b$sched_dep_time%/%100
fly3b$minute2 <- fly3b$sched_dep_time%%100
fly3b$calculater <- (fly3b$hour1-fly3b$hour2)*60 + fly3b$minute1 - fly3b$minute2
a <- fly3b[which(fly3b$calculater!=fly3b$dep_delay),]
#They are not consistant. The data shows that all flights departure and arrive in the same day,
#that's why it causes unconsistancy. 

#check if in two days
a$calculater2 <- a$calculater + 24*60
b <- a[which(a$dep_delay!=a$calculater2),]
#The truth is that these flights actually departure in the next day. Thus if I change the dataset 
#of dep_delay to make sure they are in the next day. Then all of these unconsistant would be right.

#c
min_20_30 <- flights[flights$minute>=20&flights$minute<=30,]
min_20_30$delaycheck <- ifelse(min_20_30$dep_delay>0,1,0)

min_50_60 <- flights[flights$minute>=50&flights$minute<=59|flights$minute==0,]
min_50_60$delaycheck <- ifelse(min_50_60$dep_delay>0,1,0)
#Based on the delaycheck in two time period, I found that early departures of flights are caused
#by scheduled flights that leave early.

#4
library(rvest)
scraping_qbs <- read_html("https://geiselmed.dartmouth.edu/qbs/")
h1_text <- scraping_qbs %>% html_nodes("h1") %>%html_text()
h2_text <- scraping_qbs %>% html_nodes("h2") %>%html_text()
h3_text <- scraping_qbs %>% html_nodes("h3") %>%html_text()
length(h3_text)
h4_text <- scraping_qbs %>% html_nodes("h4") %>%html_text()



p_nodes <- scraping_qbs %>%html_nodes("p")
p_text <- scraping_qbs %>% html_nodes("p") %>%html_text()
length(p_text)

ul_text <- scraping_qbs %>% html_nodes("ul") %>%html_text()
length(ul_text)

li_text <- scraping_qbs %>% html_nodes("li") %>%html_text()
length(li_text)

all_text <- scraping_qbs %>%
  html_nodes("div") %>% 
  html_text()

scrap_qbs <- list(h1=h1_text,h2=h2_text,h3=h3_text,p=p_text,ul=ul_text,li=li_text)
#sort all information in the list


library(rvest)
library(stringr)
library(dplyr)
library(lubridate)
library(readr)
# Read web page
webpage <- read_html("https://geiselmed.dartmouth.edu/qbs/")
webpage
# Extract records info
results <- webpage %>% html_nodes(".rss_snippet_date")




