library(here)
library(data.table)
library(tidyverse)

## todo for Aisha: add < 5 and > 60 rows from Facebook
## switch Census to 2020
## rename "none" for age to "all ages"
## todo: change WorldPop age_group 0 to match Census age_group 0
## by adding together the < 1 (labeled 0) and 1-4 (labeled 1)
## double-check province boundaries as there are 4 provinces that don't agree, but the others look perfect

df = fread(here("data/all_data_together.csv"))
df = df[df$age != "0"]
df.allages = df[data_source != "facebook", list(population=sum(population)), by=list(year,data_source,region,sex)]
df.allages[21,] ## todo for Aisha: check that the code above matches the all age aggregation done for census_world_facebook.csv
df.allages$age = "all_ages"
df = rbind(df,df.allages)

table(df$age, df$data_source)
# df$age = as.numeric()
head(df)
table(df$sex,df$data_source)
names(df)
g = ggplot(df[data_source != "facebook" & age != "all_ages"],aes(x=as.numeric(age),y=population))
g = g + geom_bar(stat="identity", aes(fill=data_source),position = "dodge2")
g = g + facet_wrap(region ~ sex, scales="free")
g

g = ggplot(df[data_source != "facebook" & age != "all_ages" & region == "lesotho"],aes(x=as.numeric(age),y=population))
g = g + geom_bar(stat="identity", aes(fill=data_source),position = "dodge2")
g = g + facet_wrap(region ~ sex, scales="free")
g

g = ggplot(df[age == "all_ages"],aes(x=sex,y=population))
g = g + geom_bar(stat="identity", aes(fill=data_source),position = "dodge2")
g = g + facet_wrap(~ region,scales="free")
g

g = ggplot(df[age == "all_ages" & data_source != "facebook"],aes(x=sex,y=population))
g = g + geom_bar(stat="identity", aes(fill=data_source),position = "dodge2")
g = g + facet_wrap(~ region,scales="free")
g
