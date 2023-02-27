library(data.table)
library(tidyverse)

df2 = fread(here("data/all_data_together_by_specific_ages.csv"))
head(df2)
df2$age = factor(df2$age,levels=unique(df2$age),labels = c("< 5", "15-24","60+"))
g = ggplot(df2[data_source != "worldpop"],aes(x=age,y=population))
g = g + geom_bar(stat="identity", aes(fill=data_source),position = "dodge2")
g = g + facet_wrap(~ region,scales="free")
g

