# Understanding coastal bird responses to hurricanes with Big Data and R

Many scientific fields are currently experiencing a heyday of Big Data. In Ecology, large datasets often come from continuous automated sensors, satellite imagery, and increasingly, community-collected scientific data. For example, with the advent of the eBird database in 2003, casual and expert birders alike have been able to add to the body of bird locational data around the world. Although citizen science datasets can help us understand many ecological questions, they also present unique challenges for analysis. This project will lead students through an analysis of eBird data, where they will be exposed to basic tools in EDA, manipulating large datasets, and data visualization.

This tutorial is the first of a two-part series on eBird data, co-authored by Margaret Swift and C. Lane Scher, and funded by Duke University's [Data Expeditions Initiative](https://bigdata.duke.edu/data-expeditions). You can check out the tutorials on RPubs here:

- Part One: [Exploratory Data Analysis with eBird](https://rpubs.com/margaret-swift/eda-with-ebird)
- Part Two: [How do hurricanes affect the distribution of shorebirds?](https://rpubs.com/clanescher/730898)

## Learning Goals

This analysis demonstrates basic skills in manipulating and visualizing Big Data, and applies these skills to understand how coastal birds are affected by hurricanes. We use a subset of the massive eBird dataset to practice Exploratory Data Analysis (EDA) techniques that can help us understand the format and contents of large datasets. These skills are particularly important when the method of data collection is not fully known, which is increasingly common as large, open access datasets become more widely available and used. We then practice manipulating the data to answer a specific question: how do hurricanes affect the distribution of birds typically found near the coast? Finally, we practice a few ways to visualize the results using the ggplot2 package.

## Guiding Questions

What are some ways to understand and begin to manipulate large datasets? How can we get a better understanding of datasets that we did not collect ourselves?
How do hurricanes affect the distribution of coastal birds? What are some ways we can visualize changes in the distribution of birds across a geographic region?

## The Dataset

The dataset used for this analysis comes from eBird, a global citizen science project that collects bird observations from birdwatchers. The dataset currently includes over 53 million observations, or “checklists,” from over 600,000 contributors. We use a subset of this large dataset that includes checklists submitted in Virginia, North Carolina, and South Carolina during approximately hurricane season (August 15 - October 15) from 2017 to 2019. We include only checklists for which observers reported all birds that they identified in their birdwatching session. Our dataset includes a total of 48,282 checklists with sightings of 414 species. 

There are several features of each submitted checklist that are important to our analysis. First, each checklist includes the species observed, and either the number of individuals of each species or an X indicating that the species was present but individuals were not counted. Each checklist also includes the lat/lon coordinates indicating the location of the starting point of the observation, as well as the date and time that the observation began. Finally, each checklist contains information on the “effort” of the observation--that is, the duration of the observation in minutes and the distance the observer traveled in kilometers. 

## In-Class Exercises

In this lesson, students learned how to collect data for eBird, and then completed a two-part tutorial in R. We suggest using each R tutorial in a separate class period. Both lessons have suggestions for additional analyses throughout, which could be independent class work or ideas for homework. We also recommend having students collect eBird data themselves, using this video as a guide, before working through the tutorials.

In Part 1, we introduce the concept of Exploratory Data Analysis (EDA) and walk students through different methods of exploring their data. This includes creating and sorting data tables, frequency analysis through histograms, and plotting the location and number of birds per checklist on a map. We also cover the question of effort and how that might affect bird counts in different areas, and the difference between abundance and presence-absence datasets.

In Part 2, we introduce the ecological question of how hurricanes affect coastal bird distributions. We examine three hurricanes that occurred during 2017, 2018, and 2019. We subset the data to isolate just the genera that we want to analyze, and spend some time getting the data into the correct format for the visualizations. We then visualize the effect of hurricanes in two ways. First, we produce three maps to compare coastal bird distribution in the days before and in the days after a hurricane. Second, we look at the longitudinal distribution of coastal birds over time using a bar plot.

## Source of the Data

eBird Basic Dataset. Version: EBD_relDec-2020. Cornell Lab of Ornithology, Ithaca, New York. Dec 2020.
