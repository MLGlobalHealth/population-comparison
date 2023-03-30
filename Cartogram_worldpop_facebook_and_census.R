# install.packages("remotes")
# install.packages(c("ggplot2"))
# install.packages(c("sf", "here"))
library(remotes)
library(here)
library(ggplot2)
library(sf)
library(sp)
library(raster)
library(tmap)
library(RColorBrewer)
library(cartogram)


# Population of different administrative levels of Lesotho by ages
admin_level1_shape <- st_read(here::here(paste0('~/Desktop/data/laos/censu/census_cartogram/cartogram_census_output.shp')))
  
#Cartograms
admin_level1_transformed <- st_transform(admin_level1_shape, crs = 2311)
admin_level1_cartogram <- cartogram_cont(admin_level1_transformed, "population", itermax = 5)

# visualising the created cartogram
p1 <- ggplot() +
    geom_sf(data = admin_level1_cartogram, aes(fill = population)) +
    labs(
      title = "Cartogram for US Census data",
      x = "Longitude",
      y = "Latitude",
      fill = "Population"
    ) +
    scale_fill_continuous(name = "Population")+
# geom_col( fill = "Population")+
theme(legend.position = "none")+
  theme(panel.background = NULL,
        plot.background = NULL,
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank())
# save the plot as a PNG file
# ggsave(paste0("plot_", i, ".png"), p, width = 8, height = 6, dpi = 300)
  
print(p1) # display the plot




# Population of different administrative levels of Lesotho by ages
admin_level1_shape <- st_read(here::here(paste0('~/Desktop/data/laos/censu/facebook_cartogram/cartogram_fb_output.shp')))

#Cartograms
admin_level1_transformed <- st_transform(admin_level1_shape, crs = 2311)
admin_level1_cartogram <- cartogram_cont(admin_level1_transformed, "population", itermax = 5)

# visualising the created cartogram
p2 <- ggplot() +
  geom_sf(data = admin_level1_cartogram, aes(fill = population)) +
  labs(
    title = "Cartogram for Facebook data",
    x = "Longitude",
    y = "Latitude",
    fill = "Population"
  ) +
  scale_fill_continuous(name = "Population")+
  # geom_col( fill = "Population")+
  theme(legend.position = "none")+
  theme(panel.background = NULL,
        plot.background = NULL,
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank())

# save the plot as a PNG file
# ggsave(paste0("plot_", i, ".png"), p, width = 8, height = 6, dpi = 300)

print(p2) # display the plot


# Population of different administrative levels of Lesotho by ages
admin_level1_shape <- st_read(here::here(paste0('~/Desktop/data/laos/censu/cartogram_worldpop/cartogram_worldpop_output.shp')))

#Cartograms
admin_level1_transformed <- st_transform(admin_level1_shape, crs = 2311)
admin_level1_cartogram <- cartogram_cont(admin_level1_transformed, "population", itermax = 5)

# visualising the created cartogram
p3 <- ggplot() +
  geom_sf(data = admin_level1_cartogram, aes(fill = population)) +
  labs(
    title = "Cartogram for WorldPop data",
    x = "Longitude",
    y = "Latitude",
    fill = "Population"
  ) +
  scale_fill_continuous(name = "Population")+
  # geom_col( fill = "Population")+
  theme(legend.position = "none")+
  theme(panel.background = NULL,
        plot.background = NULL,
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank())

# save the plot as a PNG file
# ggsave(paste0("plot_", i, ".png"), p, width = 8, height = 6, dpi = 300)

print(p3) # display the plot

# arrange the 2 plots in a single row
prow <- plot_grid( p1 + theme(legend.position="none"),
                   p2 + theme(legend.position="none"),
                   p3 + theme(legend.position="none"),

                   align = 'population')

# Combine all the plots into one grid
# combined_plots <- grid.arrange(p1,p2, nrow=1, ncol=2,top ='Facebok vs US Census population data for Lesotho')
# grid_arrange_shared_legend(arrangeGrob(plot_list+nt, ncol=4,nrow=5))
legend <- get_legend(p2 + theme(legend.position="bottom")) 

p <- plot_grid( prow, legend,ncol = 1, rel_heights = c(1, .2)) 
p
