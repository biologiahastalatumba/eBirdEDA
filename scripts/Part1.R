# Part1.R
# Created: 06 Jan 2021
# Authors: Margaret Swift <margaret.swift@duke.edu>
#          Lane Scher <lane.scher@duke.edu>

# Part 1 of our hurricanes + ebird lesson plan

# PART 1 OUTLINE:
# 1. How to open your data
#     - Loading from a .rdata file
#     - Loading libraries
# 2. How to look at your data
#     - head()
#     - str()
#     - View()
#     - unique()
#     - table()
#     - Indexing [1,2]
#     - Common mistakes?
# 3. What questions can you ask about your data?
# 4. Answering these with plots (basic ggplot)
#     - Observations across NC on one day (fave bird?)
#     - Over time -- migration of one or a few birds
#     - Effort over time -- holidays or weekends?
  
################################################################################
# SETUP

rm(list=ls())

# first we load some libraries (more on this later)
pacman::p_load(dplyr, ggplot2, lubridate, mapproj, maps, 
               rnaturalearth, rnaturalearthdata,
               scales, sf, usmap)

# then we make sure R knows where we want to load our data from.
# wd = "working directory", tells R which folder we're working from.
setwd("~/Documents/DukeFiles/Projects/hurricaneBirds")

# loading data is easy if someone has already collected it for you!

# ebird data
load("NCdata.rdata")

# map data
states <- map("state", plot = FALSE, fill = TRUE)
states <- st_as_sf(states)

# Sometimes I like to use these functions like this to avoid confusion:
states <- maps::map("state", plot = FALSE, fill = TRUE)

# Let's add a quick "is it NC?" column for later.
states$isNC <- states$ID == 'north carolina'

# Get NC cities with populations over 1 million, too.
data(us.cities)
cities <- filter(us.cities, country.etc == "NC", pop > 1e5)

################################################################################
# Looking at your data
# Wait, what did we call the ebird data? Check out the "environment" tab

# Looks like it's called just "data"! Let's create a copy to save it for later
# comparison.
originalData <- data

# Let's take a look at your data! How would you change this with your new data name?
names(data) #this tells us all the column names of the data
dim(data) #this tells us how big "data" is

# What time period is this data for? Use the unique() function on the "year" column.
unique(data$year)

# Let's see how the data are spread out across months.
data$month <- factor( lubridate::month(data$observation_date) )
table(data$month)

# what about data points across years?
table(data$year)

# Okay, so it looks like these data are from 2010 to 2018, and only 
# for the months August-November.

# What species are in this dataset? unique() shows us 
unique(data$scientific_name)

# top 10 most common birds?
x1 <- table(data$scientific_name)
x1
x2 <- sort(x1, decreasing=T)
head(x2, 10)

# So far we have been just looking at the count of data points. But we have this 
# nifty column labeled "observation_count"; what is this for?
data$observation_count

# Well that's useful information. Most of these are numbers, but a few are 
# labeled as "X" or maybe NA; how do we deal with these?

# first, force all the observation_counts to be numbers. Letters will be turned
# into NAs
data$count <- as.numeric( data$observation_count ) 

# Next, we filter the dataset to remove NAs
data <- data[ !is.na(data$count), ]

# compare to our original data: we have lost some rows and gained a column.
dim(data)
dim(originalData)

# Okay, so now we have "counts" for each species per each observation. 


################################################################################
# Plotting your data

# Let's take a look at some chimney swift (Chaetura pelagica) data. In order
# to do this, we'll create a new data frame that is just swifts:
chaePela <- data[ data$scientific_name == "Chaetura pelagica", ]

# compare the new dataset to the old one.
dim(data)
dim(chaePela) #much smaller!

# Okay, ready to plot! For these plots, our x and y axes are going to be 
# the same throughout, so let's set them now.
xlab <- "observation date"
ylab <- "number of observations"
plot.theme <- theme( text = element_text(size=18), title = element_text(size=20) )

################################################################################
# Three different ways of looking at bird data
# For this section we're just doing 2018 data.

# First, filter the dataset to just 2018.
chaePela2018 <- chaePela[ chaePela$year == 2018, ]

ggplot(data=chaePela2018, aes(x=observation_date)) + 
  geom_bar(aes(y=count), stat="identity") +
  ggtitle("Chimney swift counts for 2018") +
  xlab(xlab) + ylab(ylab) + plot.theme

ggplot(data=chaePela2018, aes(x=observation_date)) + 
  geom_line(stat="count", color='purple') +
  ggtitle("Chimney swift observations for 2018") +
  xlab(xlab) + ylab(ylab) + plot.theme

# We have to make our state map, cities points, and data points into "simple 
# features" objects so that we can plot them better
states <- st_as_sf(states)
cities <- st_as_sf(cities, coords=c('long', 'lat'), crs=4326, remove=F)
chaePela2018 <- st_as_sf(chaePela2018, coords=c('longitude', 'latitude'), crs=4326)

ggplot() + 
  geom_sf(data=states, aes(fill=(ID == "north carolina"))) +
  geom_sf(data=chaePela2018, aes(size=count, color=(month==9)), alpha=0.5) +
  # geom_sf(data=cities, fill='black', shape=23, size=3) +
  coord_sf(xlim = c(-85, -74), ylim = c(33.3, 37.5), expand = FALSE) +
  guides(fill = FALSE) +
  ggtitle("Chimney swift observations for 2018") + 
  scale_fill_brewer() + 
  xlab(xlab) + ylab(ylab) + plot.theme

  




################################################################################
# Great, what about every year?
ggplot(data=chaePela, aes(x=observation_date)) +
  geom_bar(stat='count')

# Hm, that's not quite what we wanted. In order to view all the years stacked up 
# on top of themselves, we have to create a kind of 'month-day' date system
# so that we can compare, say, September 1 2017 to September 1 2018.
chaePela$md <- as.Date(yday(chaePela$observation_date), "1970-01-01")
chaePela$year <- as.factor(chaePela$year)
ggplot(data=chaePela, aes(x=md, color=year)) +
  geom_line(stat='count')

# Woah, that's a mess. We can see the migration pattern in general, but 
# let's split up into different panels.
ggplot(data=chaePela, aes(x=md, y=count, fill=year)) +
  geom_bar(stat='identity')  +
  facet_wrap(~year)

# much better. 

