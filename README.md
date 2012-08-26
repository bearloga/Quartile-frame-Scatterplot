## Quartile-Frame Scatterplot with [ggplot2][1]


| Code By | Mikhail Y. Popov                                         |
| :---    | :---                                                     |
| email   | [mpopov@cmu.edu](mailto:mpopov@cmu.edu)|
| web     | [http://www.mpopov.com](http://www.mpopov.com)           |


Inspired by *The Visual Display of Quantitative Information* by Edward R. Tufte

The goal is to make the axes tell a better story about the data. This is done by turning the axes into quartile plots (cleaner boxplots).

## Usage Example

Only x & y are required, everything else is optional.

```
qsplot(x=mtcars$wt,
       y=mtcars$mpg,
       main="Vehicle Weight-Gas Mileage Relationship",
       xlab="Vehicle Weight",
       ylab="Miles per Gallon",
       font.family="Gill Sans") # alternatively: font.family="Times New Roman"
```

## Sample Plot

![Sample output for Quartile-Frame Scatterplot][2]

[1]: https://github.com/hadley/ggplot2
[2]: https://github.com/briandk/Quartile-frame-Scatterplot/raw/master/qsplot-preview.png "Sample output for Quartile-Frame Scatterplot"