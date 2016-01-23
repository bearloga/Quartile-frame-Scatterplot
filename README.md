## Quartile-Frame Scatterplot with [ggplot2][1] (0.9.2+)


| Code By | Mikhail Y. Popov                                         |
| :---    | :---                                                     |
| email   | [mikhail@mpopov.com](mailto:mikhail@mpopov.com)|
| web     | [http://www.mpopov.com](http://www.mpopov.com)           |


Inspired by *The Visual Display of Quantitative Information* by Edward R. Tufte

The goal is to make the axes tell a better story about the data. This is done by turning the axes into quartile plots (cleaner boxplots).

## Install

```R
install.packages('devtools')
devtools::source_url('https://raw.githubusercontent.com/bearloga/Quartile-frame-Scatterplot/master/qfplot.R')
```

## Usage Example

Only x & y are required, everything else is optional.

```R
qfplot(x = mtcars$wt,
       y = mtcars$mpg,
       main = "Vehicle Weight-Gas Mileage Relationship",
       xlab = "Vehicle Weight",
       ylab = "Miles per Gallon",
       font.family = "Gill Sans")
```
You may need to specifiy an explicit font mapping:
```R
windowsFonts(TNR = windowsFont("Times New Roman"))
qfplot(x = Orange$age,y=Orange$circumference,
       main = "Growth of Orange Trees",
       xlab = "Age (days since 12/31/1968",
       ylab = "Circumference at breast height (mm)",
       font.family = "TNR")
```

## Sample Plot

![Sample output for Quartile-Frame Scatterplot][2]

[1]: https://github.com/hadley/ggplot2
[2]: https://github.com/briandk/Quartile-frame-Scatterplot/raw/master/qsplot-preview.png "Sample output for Quartile-Frame Scatterplot"
