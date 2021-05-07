
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Getting Started with BiPlotteR

How many times did you wish to dive into a three-dimensional biplot,
enjoying the dispersion of your data sample like in a sky full of stars?
The `BiPlotteR` R-package makes it possible! BiPlotteR is based on the
`Plotly` interactive graphical interface and allows you to create
captivating 2D and 3D biplots after performing the Principal Component
Analysis using the prcomp function available in the “stats” R package.

### Install BiPlotteR

You can install the development version of `BiPlotteR` from GitHub. For
this purpose, you have to formerly install the `devtools` package.

``` r
install.packages("devtools")
devtools::install_github("AnCaste/BiPlotteR")
```

### Uninstall BiPlotteR

You can remove the `BiPlotteR` package in any moment using the following
code line:

``` r
remove.packages("BiPlotteR")
```

### Load BiPlotteR

Prior to further operations, the content of the `BiPlotteR` package can
be loaded into the R environment using the `library` function, as shown
below.

``` r
library("BiPlotteR")
```

## Organize your Data

All the `BiPlotteR` functions require a definite input database
structure. Specifically, the dataset has to be generated in R-mode,
i.e. showing variables (features) in columns and samples (objects) in
rows. Additionally, the first column should contain all the sample
annotations (e.g. sample name, sample number, etc.), which will be
displayed next to each point in the biplot. Furthermore, the second
column has to be filled with parameters (e.g., types, species,
treatments, etc.) useful for samples classification into groups. In this
way, all the points referring to samples sharing the same properties
will have the same color in the biplot. Variable values are listed
starting from the third column onwards. Here, column headers should
contain the name of the related feature. These names will be displayed
next to the corresponding loading vector in the biplot. As an example,
the `BiPlotteR` package offers you the `Iris_4BPLTR` data frame as a
template. This is an adaptation of the iris dataset (embedded in the
“datasets” R-package) to the needs of the BiPlotteR functions. You can
load it into the R environment using the following code line:

``` r
data("Iris_4BPLTR")
```

Here you can explore the content of the Iris\_4BPLTR dataset:

| Sample Number |  Species   | Sepal.Length | Sepal.Width | Petal.Length | Petal.Width |
|:-------------:|:----------:|:------------:|:-----------:|:------------:|:-----------:|
|       1       |   setosa   |     5.1      |     3.5     |     1.4      |     0.2     |
|       2       |   setosa   |     4.9      |     3.0     |     1.4      |     0.2     |
|       3       |   setosa   |     4.7      |     3.2     |     1.3      |     0.2     |
|       4       |   setosa   |     4.6      |     3.1     |     1.5      |     0.2     |
|       5       |   setosa   |     5.0      |     3.6     |     1.4      |     0.2     |
|       6       |   setosa   |     5.4      |     3.9     |     1.7      |     0.4     |
|       7       |   setosa   |     4.6      |     3.4     |     1.4      |     0.3     |
|       8       |   setosa   |     5.0      |     3.4     |     1.5      |     0.2     |
|       9       |   setosa   |     4.4      |     2.9     |     1.4      |     0.2     |
|      10       |   setosa   |     4.9      |     3.1     |     1.5      |     0.1     |
|      11       |   setosa   |     5.4      |     3.7     |     1.5      |     0.2     |
|      12       |   setosa   |     4.8      |     3.4     |     1.6      |     0.2     |
|      13       |   setosa   |     4.8      |     3.0     |     1.4      |     0.1     |
|      14       |   setosa   |     4.3      |     3.0     |     1.1      |     0.1     |
|      15       |   setosa   |     5.8      |     4.0     |     1.2      |     0.2     |
|      16       |   setosa   |     5.7      |     4.4     |     1.5      |     0.4     |
|      17       |   setosa   |     5.4      |     3.9     |     1.3      |     0.4     |
|      18       |   setosa   |     5.1      |     3.5     |     1.4      |     0.3     |
|      19       |   setosa   |     5.7      |     3.8     |     1.7      |     0.3     |
|      20       |   setosa   |     5.1      |     3.8     |     1.5      |     0.3     |
|      21       |   setosa   |     5.4      |     3.4     |     1.7      |     0.2     |
|      22       |   setosa   |     5.1      |     3.7     |     1.5      |     0.4     |
|      23       |   setosa   |     4.6      |     3.6     |     1.0      |     0.2     |
|      24       |   setosa   |     5.1      |     3.3     |     1.7      |     0.5     |
|      25       |   setosa   |     4.8      |     3.4     |     1.9      |     0.2     |
|      26       |   setosa   |     5.0      |     3.0     |     1.6      |     0.2     |
|      27       |   setosa   |     5.0      |     3.4     |     1.6      |     0.4     |
|      28       |   setosa   |     5.2      |     3.5     |     1.5      |     0.2     |
|      29       |   setosa   |     5.2      |     3.4     |     1.4      |     0.2     |
|      30       |   setosa   |     4.7      |     3.2     |     1.6      |     0.2     |
|      31       |   setosa   |     4.8      |     3.1     |     1.6      |     0.2     |
|      32       |   setosa   |     5.4      |     3.4     |     1.5      |     0.4     |
|      33       |   setosa   |     5.2      |     4.1     |     1.5      |     0.1     |
|      34       |   setosa   |     5.5      |     4.2     |     1.4      |     0.2     |
|      35       |   setosa   |     4.9      |     3.1     |     1.5      |     0.2     |
|      36       |   setosa   |     5.0      |     3.2     |     1.2      |     0.2     |
|      37       |   setosa   |     5.5      |     3.5     |     1.3      |     0.2     |
|      38       |   setosa   |     4.9      |     3.6     |     1.4      |     0.1     |
|      39       |   setosa   |     4.4      |     3.0     |     1.3      |     0.2     |
|      40       |   setosa   |     5.1      |     3.4     |     1.5      |     0.2     |
|      41       |   setosa   |     5.0      |     3.5     |     1.3      |     0.3     |
|      42       |   setosa   |     4.5      |     2.3     |     1.3      |     0.3     |
|      43       |   setosa   |     4.4      |     3.2     |     1.3      |     0.2     |
|      44       |   setosa   |     5.0      |     3.5     |     1.6      |     0.6     |
|      45       |   setosa   |     5.1      |     3.8     |     1.9      |     0.4     |
|      46       |   setosa   |     4.8      |     3.0     |     1.4      |     0.3     |
|      47       |   setosa   |     5.1      |     3.8     |     1.6      |     0.2     |
|      48       |   setosa   |     4.6      |     3.2     |     1.4      |     0.2     |
|      49       |   setosa   |     5.3      |     3.7     |     1.5      |     0.2     |
|      50       |   setosa   |     5.0      |     3.3     |     1.4      |     0.2     |
|      51       | versicolor |     7.0      |     3.2     |     4.7      |     1.4     |
|      52       | versicolor |     6.4      |     3.2     |     4.5      |     1.5     |
|      53       | versicolor |     6.9      |     3.1     |     4.9      |     1.5     |
|      54       | versicolor |     5.5      |     2.3     |     4.0      |     1.3     |
|      55       | versicolor |     6.5      |     2.8     |     4.6      |     1.5     |
|      56       | versicolor |     5.7      |     2.8     |     4.5      |     1.3     |
|      57       | versicolor |     6.3      |     3.3     |     4.7      |     1.6     |
|      58       | versicolor |     4.9      |     2.4     |     3.3      |     1.0     |
|      59       | versicolor |     6.6      |     2.9     |     4.6      |     1.3     |
|      60       | versicolor |     5.2      |     2.7     |     3.9      |     1.4     |
|      61       | versicolor |     5.0      |     2.0     |     3.5      |     1.0     |
|      62       | versicolor |     5.9      |     3.0     |     4.2      |     1.5     |
|      63       | versicolor |     6.0      |     2.2     |     4.0      |     1.0     |
|      64       | versicolor |     6.1      |     2.9     |     4.7      |     1.4     |
|      65       | versicolor |     5.6      |     2.9     |     3.6      |     1.3     |
|      66       | versicolor |     6.7      |     3.1     |     4.4      |     1.4     |
|      67       | versicolor |     5.6      |     3.0     |     4.5      |     1.5     |
|      68       | versicolor |     5.8      |     2.7     |     4.1      |     1.0     |
|      69       | versicolor |     6.2      |     2.2     |     4.5      |     1.5     |
|      70       | versicolor |     5.6      |     2.5     |     3.9      |     1.1     |
|      71       | versicolor |     5.9      |     3.2     |     4.8      |     1.8     |
|      72       | versicolor |     6.1      |     2.8     |     4.0      |     1.3     |
|      73       | versicolor |     6.3      |     2.5     |     4.9      |     1.5     |
|      74       | versicolor |     6.1      |     2.8     |     4.7      |     1.2     |
|      75       | versicolor |     6.4      |     2.9     |     4.3      |     1.3     |
|      76       | versicolor |     6.6      |     3.0     |     4.4      |     1.4     |
|      77       | versicolor |     6.8      |     2.8     |     4.8      |     1.4     |
|      78       | versicolor |     6.7      |     3.0     |     5.0      |     1.7     |
|      79       | versicolor |     6.0      |     2.9     |     4.5      |     1.5     |
|      80       | versicolor |     5.7      |     2.6     |     3.5      |     1.0     |
|      81       | versicolor |     5.5      |     2.4     |     3.8      |     1.1     |
|      82       | versicolor |     5.5      |     2.4     |     3.7      |     1.0     |
|      83       | versicolor |     5.8      |     2.7     |     3.9      |     1.2     |
|      84       | versicolor |     6.0      |     2.7     |     5.1      |     1.6     |
|      85       | versicolor |     5.4      |     3.0     |     4.5      |     1.5     |
|      86       | versicolor |     6.0      |     3.4     |     4.5      |     1.6     |
|      87       | versicolor |     6.7      |     3.1     |     4.7      |     1.5     |
|      88       | versicolor |     6.3      |     2.3     |     4.4      |     1.3     |
|      89       | versicolor |     5.6      |     3.0     |     4.1      |     1.3     |
|      90       | versicolor |     5.5      |     2.5     |     4.0      |     1.3     |
|      91       | versicolor |     5.5      |     2.6     |     4.4      |     1.2     |
|      92       | versicolor |     6.1      |     3.0     |     4.6      |     1.4     |
|      93       | versicolor |     5.8      |     2.6     |     4.0      |     1.2     |
|      94       | versicolor |     5.0      |     2.3     |     3.3      |     1.0     |
|      95       | versicolor |     5.6      |     2.7     |     4.2      |     1.3     |
|      96       | versicolor |     5.7      |     3.0     |     4.2      |     1.2     |
|      97       | versicolor |     5.7      |     2.9     |     4.2      |     1.3     |
|      98       | versicolor |     6.2      |     2.9     |     4.3      |     1.3     |
|      99       | versicolor |     5.1      |     2.5     |     3.0      |     1.1     |
|      100      | versicolor |     5.7      |     2.8     |     4.1      |     1.3     |
|      101      | virginica  |     6.3      |     3.3     |     6.0      |     2.5     |
|      102      | virginica  |     5.8      |     2.7     |     5.1      |     1.9     |
|      103      | virginica  |     7.1      |     3.0     |     5.9      |     2.1     |
|      104      | virginica  |     6.3      |     2.9     |     5.6      |     1.8     |
|      105      | virginica  |     6.5      |     3.0     |     5.8      |     2.2     |
|      106      | virginica  |     7.6      |     3.0     |     6.6      |     2.1     |
|      107      | virginica  |     4.9      |     2.5     |     4.5      |     1.7     |
|      108      | virginica  |     7.3      |     2.9     |     6.3      |     1.8     |
|      109      | virginica  |     6.7      |     2.5     |     5.8      |     1.8     |
|      110      | virginica  |     7.2      |     3.6     |     6.1      |     2.5     |
|      111      | virginica  |     6.5      |     3.2     |     5.1      |     2.0     |
|      112      | virginica  |     6.4      |     2.7     |     5.3      |     1.9     |
|      113      | virginica  |     6.8      |     3.0     |     5.5      |     2.1     |
|      114      | virginica  |     5.7      |     2.5     |     5.0      |     2.0     |
|      115      | virginica  |     5.8      |     2.8     |     5.1      |     2.4     |
|      116      | virginica  |     6.4      |     3.2     |     5.3      |     2.3     |
|      117      | virginica  |     6.5      |     3.0     |     5.5      |     1.8     |
|      118      | virginica  |     7.7      |     3.8     |     6.7      |     2.2     |
|      119      | virginica  |     7.7      |     2.6     |     6.9      |     2.3     |
|      120      | virginica  |     6.0      |     2.2     |     5.0      |     1.5     |
|      121      | virginica  |     6.9      |     3.2     |     5.7      |     2.3     |
|      122      | virginica  |     5.6      |     2.8     |     4.9      |     2.0     |
|      123      | virginica  |     7.7      |     2.8     |     6.7      |     2.0     |
|      124      | virginica  |     6.3      |     2.7     |     4.9      |     1.8     |
|      125      | virginica  |     6.7      |     3.3     |     5.7      |     2.1     |
|      126      | virginica  |     7.2      |     3.2     |     6.0      |     1.8     |
|      127      | virginica  |     6.2      |     2.8     |     4.8      |     1.8     |
|      128      | virginica  |     6.1      |     3.0     |     4.9      |     1.8     |
|      129      | virginica  |     6.4      |     2.8     |     5.6      |     2.1     |
|      130      | virginica  |     7.2      |     3.0     |     5.8      |     1.6     |
|      131      | virginica  |     7.4      |     2.8     |     6.1      |     1.9     |
|      132      | virginica  |     7.9      |     3.8     |     6.4      |     2.0     |
|      133      | virginica  |     6.4      |     2.8     |     5.6      |     2.2     |
|      134      | virginica  |     6.3      |     2.8     |     5.1      |     1.5     |
|      135      | virginica  |     6.1      |     2.6     |     5.6      |     1.4     |
|      136      | virginica  |     7.7      |     3.0     |     6.1      |     2.3     |
|      137      | virginica  |     6.3      |     3.4     |     5.6      |     2.4     |
|      138      | virginica  |     6.4      |     3.1     |     5.5      |     1.8     |
|      139      | virginica  |     6.0      |     3.0     |     4.8      |     1.8     |
|      140      | virginica  |     6.9      |     3.1     |     5.4      |     2.1     |
|      141      | virginica  |     6.7      |     3.1     |     5.6      |     2.4     |
|      142      | virginica  |     6.9      |     3.1     |     5.1      |     2.3     |
|      143      | virginica  |     5.8      |     2.7     |     5.1      |     1.9     |
|      144      | virginica  |     6.8      |     3.2     |     5.9      |     2.3     |
|      145      | virginica  |     6.7      |     3.3     |     5.7      |     2.5     |
|      146      | virginica  |     6.7      |     3.0     |     5.2      |     2.3     |
|      147      | virginica  |     6.3      |     2.5     |     5.0      |     1.9     |
|      148      | virginica  |     6.5      |     3.0     |     5.2      |     2.0     |
|      149      | virginica  |     6.2      |     3.4     |     5.4      |     2.3     |
|      150      | virginica  |     5.9      |     3.0     |     5.1      |     1.8     |

As you can see, the first column offers a number codification for the
iris samples; more in general, the elements in the first column will
appear as point annotations in the biplot when using the `Biplot 3D` and
`Biplot 2D` functions. The second column is dedicated to a-priori
information about your samples; in this particular case, iris species
are reported. When using the `Biplot 3D` and `Biplot 2D` functions,
points referred to samples that have the same value in the second column
of the dataset (the name of the species in this case) will be displayed
with the same color in the biplot. This might help you to interpret the
PCA output in light to your a-priori information. As previously
mentioned, features values are listed from the third column onwards.

## The functions in the BiPlotteR package: Biplot3D

`Biplot 3D` performs PCA on your input dataset and generates an
interactive three-dimensional biplot referred to the first three
principal components (PC). This function will automatically center your
input data matrix. However, data can be scaled to have unit variance
before performing the Principal Component Analysis (PCA). If you want to
scale your data, you have to specify it in the input as follows:

``` r
Biplot3D(Iris_4BPLTR,scaling="YES")
```

You can also use a loading filter to limit the number of the loading
vectors which will be displayed in the biplot. If you want to, you have
to define a threshold value so that only vectors having modules greater
than such value will be shown in the biplot. For example, only vectors
having modules greater than 0.2 will be displayed when the following
code line is used.

``` r
Biplot3D(Iris_4BPLTR,load.filter=0.2)
```

By definition, the modules of loading vectors do not exceed 1. However,
their lenght appear be too small if compared to scatter point
coordinates on the principal component axis. You can than decide to
introduce an artificial magnification of loading vectors. More properly,
you can do it either by specifying a definite magnification factor,
e.g. 2 as in the example below:

``` r
Biplot3D(Iris_4BPLTR,mag.fact=2)
```

or asking for an automatic magnification as follows:

``` r
Biplot3D(Iris_4BPLTR,mag.fact="AUTO")
```

Here you can explore the interactive output of the `Biplot 3D`. As shown
by the following code line, the ouput refers to the Principal Component
Analysis performed on the Iris\_4BPLTR input dataset.

``` r
data("Iris_4BPLTR")
Biplot3D(Iris_4BPLTR,scaling="NO",load.filter=0,mag.fact="NO")
```

## The functions in the BiPlotteR package: Biplot2D

`Biplot 2D` generates an interactive three-dimensional biplot referred
to the two principal components (PC) indicated by the user. Similarly to
`Biplot 3D`, the `Biplot 2D` function automatically centers the input
data matrix. Analogously to `Biplot 3D`, you can decide to scale your
data, to limit the number of the loading vectors in the biplot and to
ask for loading vector modules amplification to increase the biplot
intelligibility. (see above or the `Biplot 2D` help file for further
details). Furthermore, the `Biplot 2D` allows you to decide which
principal components will be displayed on the x and y axis. For example,
if you want to put the PC2 on the x axis and the PC3 on the y axis, you
have to specify the corresponding PCx and PCy values in the `Biplot 2D`,
as shown in the example below:

``` r
data("Iris_4BPLTR")
Biplot2D(Iris_4BPLTR,scaling="NO",PCx=2,PCy=3,load.filter=0,mag.fact="NO")
```

## The functions in the BiPlotteR package: ScreePlot

`ScreePlot` generates an interactive two-dimensional bar chart. The
height of each bar shows the variance explained by the corresponding
principal component. The screeplot returned by the `ScreePlot` function
refers to the Principal Component Analysis performed on centered data.
If scaling is needed, you have to specify it by setting `scaling="YES"`
in the function input. Here you can see an example of an interactive
screeplot generated by the `ScreePlot` function.

``` r
data("Iris_4BPLTR")
ScreePlot(Iris_4BPLTR,scaling="NO")
```
