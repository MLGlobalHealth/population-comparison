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
par(mfrow=c(2,2))
for (i in seq(from = 0, to = 10, by = 5)) {
  admin_level1_shape <- st_read(here::here(paste0('~/Desktop/data/meta_worldpop/worldpop/lso_f_', i, '_output.shp')))
  
  #Cartograms
  admin_level1_transformed <- st_transform(admin_level1_shape, crs = 2311)
  admin_level1_cartogram <- cartogram_cont(admin_level1_transformed, "population", itermax = 5)
  
  # visualising the created cartogram
  p <- ggplot() +
    geom_sf(data = admin_level1_cartogram, aes(fill = population)) +
    labs(
      title = paste("Cartogram of population in Lesotho for female ", i, sep = ""),
      x = "Longitude",
      y = "Latitude",
      fill = "Population"
    ) +
    scale_fill_continuous(name = "Population")
  
  # save the plot as a PNG file
  ggsave(paste0("plot_", i, ".png"), p, width = 8, height = 6, dpi = 300)
  
  print(p) # display the plot
}
par(mfrow = c(1, 1)) #reset this parameter







library(gridExtra)
library(cartogram)
library(ggplot2)
library(gganimate)
# Create a list of ggplot objects
plot_list <- list()
for (i in seq(from = 0, to = 15, by = 5)) {
  
  admin_level1_shape <- st_read(here::here(paste0('~/Desktop/data/meta_worldpop/worldpop/lso_f_', i, '_output.shp')))
  
  #Cartograms
  admin_level1_transformed <- st_transform(admin_level1_shape, crs = 2311)
  admin_level1_cartogram <- cartogram_cont(admin_level1_transformed, "population", itermax = 5)
  
  # Determine age range
  age_range <- paste0(i, "-", i+4)
  
  # Visualize the created cartogram
  p <- ggplot() +
    geom_sf(data = admin_level1_cartogram, aes(fill = population)) +
    labs(
      title = paste("Lesotho for female age ", age_range, sep = ""),
      fill = "Population"
    ) +
    scale_fill_continuous(name = "Population") +
    theme(panel.background = element_blank(),
          plot.background = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank())
  
  plot_list[[i/5+1]] <- p
}



# grid.arrange(plot_list[0] ,plot_list[1] , ncol=2,top="Main Title")
grid.arrange(grobs = plot_list, row = 2, ncol = 2)





# Use gganimate to create the animation
# gg_animate(plot_list, title_frame = FALSE, fps = 5)
# Load gganimate package
# Load ggplot2 and gganimate packages
library(ggplot2)
library(gganimate)

# Create a data frame with the age categories
df <- data.frame(age = seq(from = 0, to = 15, by = 5))

# Create a function to generate each plot
generate_plot <- function(i) {
  admin_level1_shape <- st_read(here::here(paste0('~/Desktop/data/meta_worldpop/worldpop/lso_f_', i, '_output.shp')))
  admin_level1_transformed <- st_transform(admin_level1_shape, crs = 2311)
  admin_level1_cartogram <- cartogram_cont(admin_level1_transformed, "population", itermax = 5)
  
  p <- ggplot() +
    geom_sf(data = admin_level1_cartogram, aes(fill = population)) +
    labs(
      title = paste("Lesotho for female age ", i, "-", i + 4, sep = "")
    ) +
    scale_fill_continuous(name = "Population")
  
  return(p)
}

# Map the generate_plot function to the age categories to create a list of ggplot objects
plot_list <- lapply(df$age, generate_plot)

# Use the transition_manual and enter_fade functions to create an animation
p <- ggplot() +
  transition_manual(values = plot_list) +
  enter_fade() +
  labs(title = "Lesotho for female age {frame_value}") +
  scale_fill_continuous(name = "Population")

# Animate the plot
animate(
  p,
  nframes = length(plot_list),
  fps = 10,
  width = 600,
  height = 400,
  renderer = animation_renderer()
)

animate(animation, renderer = gifski_renderer())







##### Lesotho population for Female for different ages####
library(ggplot2)
library(sf)
library(cartogram)
library(cowplot)

# Create an empty list to store the plots
plot_list <- list()

# Generate the plots and store them in the list
for (i in seq(from = 0, to = 80, by = 5)) {
  if (i == 0) {
    i <- 1
  }
  admin_level1_shape <- st_read(here::here(paste0('~/Desktop/data/meta_worldpop/worldpop/lso_f_', i, '_output.shp')))
  
  #Cartograms
  admin_level1_transformed <- st_transform(admin_level1_shape, crs = 2311)
  admin_level1_cartogram <- cartogram_cont(admin_level1_transformed, "population", itermax = 5)
  
  # Determine age range
  age_range <- paste0(i, "-", i+4)
  # Determine age range
  age_range <- paste0(i, "-", i+4)
  if (i == 80) {
    age_range <- paste0(">", i)
  }
  # Visualize the created cartogram
  p <- ggplot() +
    geom_sf(data = admin_level1_cartogram, aes(fill = population)) +
    labs(
      title = paste("Age ", age_range, sep = ""),
      fill = "Population"
    ) +
    scale_fill_continuous(name = "Population") +
    theme(panel.background = element_blank(),
          plot.background = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank())
  
  plot_list[[i/5+1]] <- p
}

# Combine all the plots into one grid
library(gridExtra)
grid.arrange(grobs = plot_list, nrow=5, ncol=4,top ='Lesotho population for female by age group')
# Save the combined plots to a PDF file
ggsave("Lesotho_female_combined_plots.pdf")



##### Lesotho population for male for different ages####
library(ggplot2)
library(sf)
library(cartogram)
library(cowplot)

# Create an empty list to store the plots
plot_list <- list()

# Generate the plots and store them in the list
for (i in seq(from = 0, to = 80, by = 5)) {
  if (i == 0) {
    i <- 1
  }
  admin_level1_shape <- st_read(here::here(paste0('~/Desktop/data/meta_worldpop/worldpop/lso_m_', i, '_output.shp')))
  
  #Cartograms
  admin_level1_transformed <- st_transform(admin_level1_shape, crs = 2311)
  admin_level1_cartogram <- cartogram_cont(admin_level1_transformed, "population", itermax = 5)
  
  # Determine age range
  age_range <- paste0(i, "-", i+4)
  if (i == 80) {
    age_range <- paste0(">", i)
  }
  # Visualize the created cartogram
  p <- ggplot() +
    geom_sf(data = admin_level1_cartogram, aes(fill = population)) +
    labs(
      title = paste("Age ", age_range, sep = ""),
      fill = "Population"
    ) +
    scale_fill_continuous(name = "Population") +
    theme(panel.background = element_blank(),
          plot.background = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank())
  
  plot_list[[i/5+1]] <- p
}

# Combine all the plots into one grid
library(gridExtra)
grid.arrange(grobs = plot_list, nrow=5, ncol=4,top ='Lesotho population for male by age group')
# Save the combined plots to a PDF file
ggsave("Lesotho_male_combined_plots.pdf")
