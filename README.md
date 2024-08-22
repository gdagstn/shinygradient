# shinygradient
Shiny app to generate gradient RGB palettes

This is a first exercise in Shiny app creation. 

I saw Inigo Quilez's beautiful [video](https://www.youtube.com/shorts/TH3OTy5fTog) and decided to write an R implementation. It then made sense to make it interactive, giving me an excuse to learn some Shiny development. 

This is a barebones implementation that seems to get the job done.

## Requirements

You need to have `shiny` installed. It can be found on CRAN:

```{r}
install.packages("shiny")
```

Or you can go to the online deployment [here](https://gdagstn.shinyapps.io/shinygradient/).

## Usage

Clone this repository and open the `app.R` file in RStudio, then run the app. 

You can use the slides for the 4 parameters that control the RGB curves. Each color channel can be controlled independently.

- A: controls the brightness/luminance of the R, G, B curves (how tall does the whole cosine wave sit?)
- B: controls the contrast of the R, G, B (how quickly does the wave change?)
- C: controls how much R, G, B change across the color vector
- D: controls where the maxima for each channel are.

You can also choose the number of colors. The color vector is printed at the end of the page. 

<img width="1485" alt="Screenshot 2024-08-22 at 11 26 53 PM" src="https://github.com/user-attachments/assets/00a002b9-4df5-457d-a819-3d40aa29b0b9">
