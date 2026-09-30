##LAB 

#-------------------------------------------------------------------------------
##CORRELATION TEST BETWEEN 2 VARIABLES
#-------------------------------------------------------------------------------

#http://www.sthda.com/english/wiki/correlation-test-between-two-variables-in-r

#Correlation test is used to evaluate the association between two or more variables.

#Methods for correlation analyses
#There are different methods to perform correlation analysis:
#-Pearson correlation (r), which measures a linear dependence between two variables
#(x and y). It’s also known as a parametric correlation test because it depends to 
#the distribution of the data. 
#It can be used only when x and y are from normal distribution. The plot of y = f(x)
#is named the linear regression curve.
#-Kendall tau and Spearman rho, which are rank-based correlation coefficients (non-parametric)

 
##R functions:
#Correlation coefficient can be computed using the functions cor() or cor.test():
#-cor() computes the correlation coefficient
#-cor.test() test for association/correlation between paired samples. 
# It returns both the correlation coefficient and the significance level(or p-value) 
#of the correlation .

#The simplified formats are:
-cor(x, y, method = c("pearson", "kendall", "spearman"))
-cor.test(x, y, method=c("pearson", "kendall", "spearman"))
 
# x, y: numeric vectors with the same length
# method: correlation method
 
#If your data contain missing values, use the following R code to handle missing 
#values by case-wise deletion:
-cor(x, y,  method = "pearson", use = "complete.obs")

#Import your data into R
my_data <- mtcars

#http://www.sthda.com/english/wiki/r-built-in-data-sets

head(my_data, 6)

#We want to compute the correlation between mpg and wt variables.

#Visualize your data using scatter plots

#install.packages("ggpubr")
library("ggpubr")
library("ggplot2")
ggscatter(my_data, x = "mpg", y = "wt", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Miles/(US) gallon", ylab = "Weight (1000 lbs)")

#Preleminary test to check the test assumptions
#1 Is the covariation linear? Yes, fROm the plot above, the relationship is linear. 
#  In the situation where the scatter plots show curved patterns, we are dealing with 
#nonlinear association between the two variables.

#2 Are the data from each of the 2 variables (x, y) follow a normal distribution?
#  Use Shapiro-Wilk normality test –> R function: shapiro.test()
#  and look at the normality plot —> R function: ggpubr::ggqqplot()
  
  
#-Shapiro-Wilk test can be performed as follow:
# Null hypothesis: the data are normally distributed
# Alternative hypothesis: the data are not normally distributed
 
# Shapiro-Wilk normality test for mpg
shapiro.test(my_data$mpg) # => p = 0.1229
# Shapiro-Wilk normality test for wt
shapiro.test(my_data$wt) # => p = 0.09

#From the output, the two p-values are greater than the significance level 0.05 implying that 
#the distribution of the data are not significantly different from normal distribution. 
#In other words, we can assume the normality.

#-Visual inspection of the data normality using Q-Q plots (quantile-quantile plots). 
# Q-Q plot draws the correlation between a given sample and the normal distribution.

library("ggpubr")
# mpg
ggqqplot(my_data$mpg, ylab = "MPG")
# wt
ggqqplot(my_data$wt, ylab = "WT")

#From the normality plots, we conclude that both populations may come from normal distributions.
#Note that, if the data are not normally distributed, it’s recommended to use the non-parametric 
#correlation, including Spearman and Kendall rank-based correlation tests.

#Pearson correlation test
#Correlation test between mpg and wt variables:
  
res =  cor.test(my_data$wt, my_data$mpg, 
                  method = "pearson")
res

#In the result above:
#t is the t-test statistic value (t = -9.559),
#df is the degrees of freedom (df= 30),
#p-value is the significance level of the t-test (p-value = 1.29410^{-10}).
#conf.int is the confidence interval of the correlation coefficient at 95% 
#(conf.int = [-0.9338, -0.7441]);
#sample estimates is the correlation coefficient (Cor.coeff = -0.87).

#The p-value of the test is 1.29410^{-10}, which is less than the significance level 
#alpha = 0.05. We can conclude that wt and mpg are significantly correlated with a 
#correlation coefficient of -0.87 and p-value of 1.29410^{-10} .

#The function cor.test() returns a list containing the following components:
#p.value: the p-value of the test
#estimate: the correlation coefficient

# Extract the p.value
res$p.value
# Extract the correlation coefficient
res$estimate

#Kendall rank correlation test
#The Kendall rank correlation coefficient or Kendall’s tau statistic is used to estimate 
#a rank-based measure of association. 
#This test may be used if the data do not necessarily come from a bivariate normal distribution.

res2 <- cor.test(my_data$wt, my_data$mpg,  method="kendall")
res2

#tau is the Kendall correlation coefficient.

#The correlation coefficient between x and y are -0.7278 and the p-value is 6.70610^{-9}.

#Spearman rank correlation coefficient
#Spearman’s rho statistic is also used to estimate a rank-based measure of association. 
#This test may be used if the data do not come from a bivariate normal distribution.

res2 <-cor.test(my_data$wt, my_data$mpg,  method = "spearman")
res2

#rho is the Spearman’s correlation coefficient.

#The correlation coefficient between x and y are -0.8864 and the p-value is 1.48810^{-11}.

#Interpret correlation coefficient
#Correlation coefficient is comprised between -1 and 1:
#-1 indicates a strong negative correlation : this means that every time x increases, 
#y decreases 
#0 means that there is no association between the two variables (x and y)
#1 indicates a strong positive correlation : this means that y increases with x 

#-------------------------------------------------------------------------------
##CORRELATION MATRIX
#-------------------------------------------------------------------------------

#http://www.sthda.com/english/wiki/correlation-matrix-a-quick-start-guide-to-analyze-format-and-visualize-a-correlation-matrix-using-r-software

#The correlation matrix is used to investigate the dependence between multiple variables at 
#the same time. 
#The result is a table containing the correlation coefficients between each variable and the
#others.

#There are different methods for correlation analysis : 
#Pearson parametric correlation test, Spearman and Kendall rank-based correlation analysis. 

##R functions
#As you may know, The R function cor() can be used to compute a correlation matrix. 
#A simplified format of the function is :
  
cor(x, method = c("pearson", "kendall", "spearman"))

#x: numeric matrix or a data frame.
#method: indicates the correlation coefficient to be computed. 
#The default is pearson correlation coefficient which measures the linear dependence between 
#two variables. 
#kendall and spearman correlation methods are non-parametric rank-based correlation test.

# Load data
data("mtcars")
my_data <- mtcars[, c(1,3,4,5,6,7)] 
#we remove the second variable because it is an ordinal variable
# print the first 6 rows
head(my_data, 6)

res <- cor(my_data)
round(res, 2)

#In the table above correlations coefficients between the possible pairs of variables are shown.

##Visualize correlation matrix

#-Use corrplot() function: Draw a correlogram
#The function corrplot(), in the package of the same name, creates a graphical display of a correlation matrix, 
#highlighting the most correlated variables in a data table.

#In this plot, correlation coefficients are colored according to the value. 
#Correlation matrix can be also reordered according to the degree of association between variables.

#Install corrplot:
install.packages("corrplot")
#https://www.rdocumentation.org/packages/corrplot/versions/0.92/topics/corrplot
#Use corrplot() to create a correlogram:
#The function corrplot() takes the correlation matrix as the first argument. 
#The second argument (type=“upper”) is used to display only the upper triangular of the correlation matrix.

library(corrplot)
corrplot(res, type = "full", order = "hclust", 
         tl.col = "black", tl.srt = 45)

#Positive correlations are displayed in blue and negative correlations in red color. 
#Color intensity and the size of the circle are proportional to the correlation coefficients. 
#In the right side of the correlogram, the legend color shows the correlation coefficients and 
#the corresponding colors.


#The correlation matrix is reordered according to the correlation coefficient using “hclust” method.
#tl.col (for text label color) and tl.srt (for text label string rotation) are used to change text colors and rotations.
#Possible values for the argument type are : “upper”, “lower”, “full”

#-Use chart.Correlation(): Draw scatter plots
#The function chart.Correlation()[ in the package PerformanceAnalytics], can be used to display a chart of a correlation matrix.

library("PerformanceAnalytics")
my_data <- mtcars[, c(1,3,4,5,6,7)]
chart.Correlation(my_data, histogram=TRUE, pch=19)

#In the above plot:
  
#The distribution of each variable is shown on the diagonal.
#On the bottom of the diagonal : the bivariate scatter plots with a fitted line are displayed
#On the top of the diagonal : the value of the correlation plus the significance level as stars
#Each significance level is associated to a symbol :
#p-values(0, 0.001, 0.01, 0.05, 0.1, 1) <=> symbols(“***”, “**”, “*”, “.”, " ")

#-Use heatmap()
# Get some colors
col<- colorRampPalette(c("blue", "white", "red"))(20)
heatmap(x = res, col = col, symm = TRUE)

#x : the correlation matrix to be plotted
#col : color palettes
#symm : logical indicating if x should be treated symmetrically; 
#can only be true when x is a square matrix.

#-------------------------------------------------------------------------------
## ggpubr: ‘ggplot2’ Based Publication Ready Plots
#-------------------------------------------------------------------------------

#https://rpkgs.datanovia.com/ggpubr/index.html
#http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/

install.packages("ggpubr")
library(ggpubr)

##DISTRIBUTION
# Create some data format
# :::::::::::::::::::::::::::::::::::::::::::::::::::
set.seed(1234)
wdata = data.frame(
  sex = factor(rep(c("F", "M"), each=200)),
  weight = c(rnorm(200, 55), rnorm(200, 58)))
head(wdata, 4)

#The set.seed() function in R is used to create reproducible results when writing 
#code that involves creating variables that take on random values.
#By using the set.seed() function, you guarantee that the same random values are 
#produced each time you run the code.
#seed: Any number you would like.

# Density plot with mean lines and marginal rug
# :::::::::::::::::::::::::::::::::::::::::::::::::::
# Change outline and fill colors by groups ("sex")
# Use custom palette
ggdensity(wdata, x = "weight",
          add = "mean", rug = TRUE,
          color = "sex", fill = "sex",
          palette = c("#00AFBB", "#E7B800"))


# Histogram plot with mean lines and marginal rug
# :::::::::::::::::::::::::::::::::::::::::::::::::::
# Change outline and fill colors by groups ("sex")
# Use custom color palette
gghistogram(wdata, x = "weight",
            add = "mean", rug = TRUE,
            color = "sex", fill = "sex", bins=10,
            palette = c("#00AFBB", "#E7B800"))

##BOXPLOTS & VIOLIN PLOTS
# Load data
data("ToothGrowth")
df <- ToothGrowth
head(df, 4)
#>    len supp dose
#> 1  4.2   VC  0.5
#> 2 11.5   VC  0.5
#> 3  7.3   VC  0.5
#> 4  5.8   VC  0.5

# Box plots with jittered points
# :::::::::::::::::::::::::::::::::::::::::::::::::::
# Change outline colors by groups: dose
# Use custom color palette
# Add jitter points and change the shape by groups
p <- ggboxplot(df, x = "dose", y = "len",
               color = "dose", palette =c("#00AFBB", "#E7B800", "#FC4E07"),
               add = "jitter", shape = "dose")
p

# Add p-values comparing groups
# Specify the comparisons you want
my_comparisons <- list( c("0.5", "1"), c("1", "2"), c("0.5", "2") )
p + stat_compare_means(comparisons = my_comparisons, method="wilcox.test")+ # Add pairwise comparisons p-value
  stat_compare_means(label.y = 50)       

# Violin plots with box plots inside
# :::::::::::::::::::::::::::::::::::::::::::::::::::
# Change fill color by groups: dose
# add boxplot with white fill color
ggviolin(df, x = "dose", y = "len", fill = "dose",
         palette = c("#00AFBB", "#E7B800", "#FC4E07"),
         add = "boxplot", add.params = list(fill = "white"))+
  stat_compare_means(comparisons = my_comparisons, label = "p.signif")+ # Add significance levels
  stat_compare_means(label.y = 50)     

##BAR PLOTS
# Load data
data("mtcars")
dfm <- mtcars
# Convert the cyl variable to a factor
dfm$cyl <- as.factor(dfm$cyl)
# Add the name colums
dfm$name <- rownames(dfm)
# Inspect the data
head(dfm[, c("name", "wt", "mpg", "cyl")])
#>                                name    wt  mpg cyl
#> Mazda RX4                 Mazda RX4 2.620 21.0   6
#> Mazda RX4 Wag         Mazda RX4 Wag 2.875 21.0   6
#> Datsun 710               Datsun 710 2.320 22.8   4
#> Hornet 4 Drive       Hornet 4 Drive 3.215 21.4   6
#> Hornet Sportabout Hornet Sportabout 3.440 18.7   8
#> Valiant   

#Ordered bar plots
#Change the fill color by the grouping variable “cyl”. Sorting will be done globally, but not by groups.

ggbarplot(dfm, x = "name", y = "mpg",
          fill = "cyl",               # change fill color by cyl
          color = "black",            # Set bar border colors to white
          palette = "jco",            # jco journal color palett. see ?ggpar
          sort.val = "desc",          # Sort the value in dscending order
          sort.by.groups = TRUE,     # Don't sort inside each group
          x.text.angle = 90          # Rotate vertically x axis texts
)

#Sort bars inside each group. Use the argument sort.by.groups = TRUE.

##LOLLIPOP CHART

#Lollipop chart is an alternative to bar plots, when you have a large set of values to visualize.

#Lollipop chart colored by the grouping variable “cyl”:

ggdotchart(dfm, x = "name", y = "mpg",
           color = "cyl",                                # Color by groups
           palette = c("#00AFBB", "#E7B800", "#FC4E07"), # Custom color palette
           sorting = "ascending",                        # Sort value in descending order
           add = "segments",                             # Add segments from y = 0 to dots
           ggtheme = theme_pubr()                        # ggplot2 theme
)


ggdotchart(dfm, x = "name", y = "mpg",
           color = "cyl",                                # Color by groups
           palette = c("#00AFBB", "#E7B800", "#FC4E07"), # Custom color palette
           sorting = "descending",                       # Sort value in descending order
           add = "segments",                             # Add segments from y = 0 to dots
           rotate = TRUE,                                # Rotate vertically
           group = "cyl",                                # Order by groups
           dot.size = 6,                                 # Large dot size
           label = round(dfm$mpg),                        # Add mpg values as dot labels
           font.label = list(color = "white", size = 9, 
                             vjust = 0.5),               # Adjust label parameters
           ggtheme = theme_pubr()                        # ggplot2 theme
)

#-------------------------------------------------------------------------------
##PERFECT SCATTER PLOTS
#-------------------------------------------------------------------------------

# Load data
data("mtcars")
df <- mtcars
# Convert cyl as a grouping variable
df$cyl <- as.factor(df$cyl)
# Inspect the data
head(df[, c("wt", "mpg", "cyl", "qsec")])

#Basic plots
ggscatter(df, x = "wt", y = "mpg",
          add = "reg.line",                                 # Add regression line
          conf.int = TRUE,                                  # Add confidence interval
          add.params = list(color = "blue",
                            fill = "lightgray")
)+
  stat_cor(method = "pearson", label.x = 3, label.y = 30)  # Add correlation coefficient

#-You can change the point shape, by specifying the argument shape, for example:
  
  ggscatter(df, x = "wt", y = "mpg",
            shape = 18)

#-To see the different point shapes commonly used in R, type this:
  
  show_point_shapes()

#Color by groups
#Grouping variable: cyl. To add a correlation coefficient per group, specify the grouping variable using the mapping function aes() as follow.

ggscatter(df, x = "wt", y = "mpg",
          add = "reg.line",                         # Add regression line
          conf.int = TRUE,                          # Add confidence interval
          color = "cyl", palette = "jco",           # Color by groups "cyl"
          shape = "cyl"                             # Change point shape by groups "cyl"
)+
  stat_cor(aes(color = cyl), label.x = 3)           # Add correlation coefficient

# Extending the regression line --> fullrange = TRUE
# Add marginal rug (marginal density) ---> rug = TRUE
ggscatter(df, x = "wt", y = "mpg",
          add = "reg.line",                         # Add regression line
          color = "cyl", palette = "jco",           # Color by groups "cyl"
          shape = "cyl",                            # Change point shape by groups "cyl"
          fullrange = TRUE,                         # Extending the regression line
          rug = TRUE                                # Add marginal rug
)+
  stat_cor(aes(color = cyl), label.x = 3)           # Add correlation coefficient

#Add concentration ellipses
#Main arguments:
#ellipse = TRUE: Draw ellipses around groups.
#ellipse.level: The size of the concentration ellipse in normal probability. Default is 0.95.
#ellipse.type: Ellipse types. Possible values are ‘convex’, ‘confidence’ or types supported by ggplot2::stat_ellipse including one of c(“t”, “norm”, “euclid”). Default is “norm”.

ggscatter(df, x = "wt", y = "mpg",
          color = "cyl", palette = "jco",
          shape = "cyl",
          ellipse = TRUE)

# Add group mean points and stars
ggscatter(df, x = "wt", y = "mpg",
          color = "cyl", palette = "jco",
          shape = "cyl",
          ellipse = TRUE, 
          mean.point = TRUE,
          star.plot = TRUE)

#Add point labels
#Main arguments:
  
#label: the name of the column containing point labels.
#font.label: a list which can contain the combination of the following elements: the size (e.g.: 14), the style (e.g.: “plain”, “bold”, “italic”, “bold.italic”) and the color (e.g.: “red”) of labels. For example font.label = list(size = 14, face = “bold”, color =“red”). To specify only the size and the style, use font.label = list(size = 14, face = “plain”).
#label.select: character vector specifying some labels to show.
#repel = TRUE: Avoid label overlapping.
# Use row names as point labels
df$name <- rownames(df)
ggscatter(df, x = "wt", y = "mpg",
          color = "cyl", palette = "jco",
          label = "name", repel = TRUE)

#Color by a continuous variable
#The R code below, will color points according to the values of a continuous variable, here “mpg”. By default, a blue gradient color is created. This can be changed using the helper function gradient_color() [in ggpubr].

# Color by continuous variable
p <- ggscatter(df, x = "wt", y = "mpg",
               color = "mpg")
p
# Change gradient color
p + gradient_color(c("blue", "white", "red"))


#Add marginal plots
#The function ggMarginal() [in ggExtra package], can be used to easily add a marginal histogram, density or boxplot to a scatter plot.

#First, install the ggExtra package as follow: 
#install.packages(“ggExtra”); #then type the following R code:
  
# Add density distribution as marginal plot
library("ggExtra")
p <- ggscatter(iris, x = "Sepal.Length", y = "Sepal.Width",
               color = "Species", palette = "jco",
               size = 3, alpha = 0.6)
ggMarginal(p, type = "density")
# Change marginal plot type
ggMarginal(p, type = "boxplot")

#One limitation of ggExtra is that it can’t cope with multiple groups in the scatter plot and the marginal plots. 
#In the R code below, we provide a solution using the cowplot package.

library(cowplot) 
# Main plot
pmain <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species))+
  geom_point()+
  ggpubr::color_palette("jco")
# Marginal densities along x axis
xdens <- axis_canvas(pmain, axis = "x")+
  geom_density(data = iris, aes(x = Sepal.Length, fill = Species),
               alpha = 0.7, size = 0.2)+
  ggpubr::fill_palette("jco")
# Marginal densities along y axis
# Need to set coord_flip = TRUE, if you plan to use coord_flip()
ydens <- axis_canvas(pmain, axis = "y", coord_flip = TRUE)+
  geom_density(data = iris, aes(x = Sepal.Width, fill = Species),
               alpha = 0.7, size = 0.2)+
  coord_flip()+
  ggpubr::fill_palette("jco")
p1 <- insert_xaxis_grob(pmain, xdens, grid::unit(.2, "null"), position = "top")
p2<- insert_yaxis_grob(p1, ydens, grid::unit(.2, "null"), position = "right")
ggdraw(p2)

#-------------------------------------------------------------------------------
## Scatter Plot Matrix
#-------------------------------------------------------------------------------

#http://www.sthda.com/english/wiki/scatter-plot-matrices-r-base-graphs

head(iris)

#R base scatter plot matrices: pairs()
#Basic plots:
  pairs(iris[,1:4], pch = 19)

#Show only upper panel:
  pairs(iris[,1:4], pch = 19, lower.panel = NULL)

#Note that, to keep only lower.panel, use the argument upper.panel=NULL

#Color points by groups (species)
my_cols <- c("#00AFBB", "#E7B800", "#FC4E07")  
pairs(iris[,1:4], pch = 19,  cex = 0.5,
      col = my_cols[iris$Species],
      lower.panel=NULL)

#Add correlations on the lower panels: The size of the text is proportional to the correlations.
# Correlation panel
panel.cor <- function(x, y){
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- round(cor(x, y), digits=2)
  txt <- paste0("R = ", r)
  cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}
# Customize upper panel
upper.panel<-function(x, y){
  points(x,y, pch = 19, col = my_cols[iris$Species])
}
# Create the plots
pairs(iris[,1:4], 
      lower.panel = panel.cor,
      upper.panel = upper.panel)

#Add correlations on the scatter plots:
  # Customize upper panel
  upper.panel<-function(x, y){
    points(x,y, pch=19, col=c("red", "green3", "blue")[iris$Species])
    r <- round(cor(x, y), digits=2)
    txt <- paste0("R = ", r)
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    text(0.5, 0.9, txt)
  }
pairs(iris[,1:4], lower.panel = NULL, 
      upper.panel = upper.panel)

#Use the R package psych
#The function pairs.panels [in psych package] can be also used to create a scatter plot of matrices, with bivariate scatter plots below the diagonal, histograms on the diagonal, and the Pearson correlation above the diagonal.

library(psych)
pairs.panels(iris[,-5], 
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)

#-----------------------------------------------------------------------------------------
##PCA

#http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/112-pca-principal-component-analysis-essentials/

#Principal component analysis (PCA) allows us to summarize and to visualize the 
#information in a data set containing individuals/observations described by multiple 
#inter-correlated quantitative variables. 
#Each variable could be considered as a different dimension. If you have more than 
#3 variables in your data sets, it could be very difficult to visualize a multi-dimensional
#hyperspace.

#Principal component analysis is used to extract the important information from 
#a multivariate data table and to express this information as a set of few new 
#variables called principal components. 
#These new variables correspond to a linear combination of the originals. 
#The number of principal components is less than or equal to the number of original 
#variables.

#The information in a given data set corresponds to the total variation it contains. 
#The goal of PCA is to identify directions (or principal components) along which the 
#variation in the data is maximal(data as separated as possible).

#In other words, PCA reduces the dimensionality of a multivariate data to two or three 
#principal components, that can be visualized graphically, with minimal loss of information.


#We’ll use the two packages FactoMineR (for the analysis) and factoextra 
#(for ggplot2-based visualization).

#Install the two packages:
install.packages(c("FactoMineR", "factoextra"))

#Load them:
library("FactoMineR")
#https://www.rdocumentation.org/packages/FactoMineR/versions/2.9/topics/PCA
library("factoextra")
#https://www.rdocumentation.org/packages/factoextra/versions/1.0.3

data(decathlon2)
# head(decathlon2)

#The data used here describes athletes’ performance during two sporting events
#(Desctar and OlympicG). 
#It contains 27 individuals (athletes) described by 13 variables.

#We start by subsetting active individuals and active variables for the principal 
#component analysis:
  
decathlon2.active <- decathlon2[1:23, 1:10]
head(decathlon2.active[, 1:6], 4)

#R function:
PCA(X, scale.unit = TRUE, ncp = 5, graph = TRUE)

#X: a data frame. Rows are individuals and columns are numeric variables
#scale.unit: a logical value. If TRUE, the data are scaled to unit variance before 
#the analysis. This standardization to the same scale avoids some variables to 
#become dominant just because of their large measurement units. 
#It makes variable comparable.
#ncp: number of dimensions kept in the final results.
#graph: a logical value. If TRUE a graph is displayed.

#The R code below, computes principal component analysis on the active individuals/variables:
  
#library("FactoMineR")
res.pca <- PCA(decathlon2.active, graph = FALSE)

#The output of the function PCA() is a list, including the following components :
  
print(res.pca)

##Visualization and Interpretation

#We’ll use the factoextra R package to help in the interpretation of PCA:
  
#get_eigenvalue(res.pca): Extract the eigenvalues/variances of principal components
#fviz_eig(res.pca): Visualize the eigenvalues
#get_pca_ind(res.pca), get_pca_var(res.pca): Extract the results for individuals 
#and variables, respectively.
#fviz_pca_ind(res.pca), fviz_pca_var(res.pca): Visualize the results individuals 
#and variables, respectively.
#fviz_pca_biplot(res.pca): Make a biplot of individuals and variables.

##Eigenvalues / Variances
#The eigenvalues measure the amount of variation retained by each principal component. 
#Eigenvalues are large for the first PCs and small for the subsequent PCs. 
#That is, the first PCs corresponds to the directions with the maximum amount of
#variation in the data set.

#We examine the eigenvalues to determine the number of principal components to be 
#considered. 
#The eigenvalues and the proportion of variances (i.e., information) retained by 
#the principal components (PCs) can be extracted using the function get_eigenvalue() 
#[factoextra package].

#library("factoextra")
eig.val <- get_eigenvalue(res.pca)
eig.val

#The sum of all the eigenvalues give a total variance of 10.

#The proportion of variation explained by each eigenvalue is given in the second column. 

#Eigenvalues can be used to determine the number of principal components to retain 
#after PCA (Kaiser 1961):
  
#An eigenvalue > 1 indicates that PCs account for more variance than accounted by 
#one of the original variables in standardized data. 
#This is commonly used as a cutoff point for which PCs are retained. 
#This holds true only when the data are standardized.

#You can also limit the number of component to that number that accounts for a 
#certain fraction of the total variance. 
#For example, if you are satisfied with 70% of the total variance explained then 
#use the number of components to achieve that.

#Unfortunately, there is no well-accepted objective way to decide how many principal
#components are enough. 
#This will depend on the specific field of application and the specific data set. 
#In practice, we tend to look at the first few principal components in order to find 
#interesting patterns in the data.

#In our analysis, the first three principal components explain 72% of the variation. 
#This is an acceptably large percentage.

#This means that by creating a 2D plot with the first two principal components, 
#you will visualize approximately 60% of the data's variance, while creating a 3D 
#plot with the first three components will allow you to visualize about 72%.

#Note that during the feature engineering phase, when you're preparing features 
#for your machine learning model, you can consider using the principal components 
#directly as inputs to the model instead of the original features (ind coord).

#An alternative method to determine the number of principal components is to look at 
#a Scree Plot, which is the plot of eigenvalues ordered from largest to the smallest. 
#The number of component is determined at the point, beyond which the remaining 
#eigenvalues are all relatively small and of comparable size.

#The scree plot can be produced using the function fviz_eig() or fviz_screeplot() 
#[factoextra package].

fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 50))

#fviz_screeplot(res.pca, addlabels = TRUE, ylim = c(0, 50)) 

#Graph of variables

#A simple method to extract the results, for variables, from a PCA output is to
#use the function get_pca_var() [factoextra package]. 
#This function provides a list of matrices containing all the results for the 
#active variables (coordinates, correlation between variables and axes, 
#squared cosine and contributions)

var <- get_pca_var(res.pca)
var

#The components of the get_pca_var() can be used in the plot of variables as follow:
  
#var$coord: coordinates of variables to create a scatter plot
#var$cos2: represents the quality of representation for variables on the factor map. 
#It’s calculated as the squared coordinates: var.cos2 = var.coord * var.coord.
#var$contrib: contains the contributions (in percentage) of the variables to the 
#principal components. The contribution of a variable (var) to a given principal 
#component is (in percentage) : (var.cos2 * 100) / (total cos2 of the component).

#The different components can be accessed as follow:
  
# Coordinates
head(var$coord)
# Cos2: quality on the factore map
head(var$cos2)
# Contributions to the principal components
head(var$contrib)



##Correlation circle
#The correlation between a variable and a principal component (PC) is used as the 
#coordinates of the variable on the PC. 
#The representation of variables differs from the plot of the observations: 
#The observations are represented by their projections, but the variables are represented 
#by their correlations (Abdi and Williams 2010).

# Coordinates of variables
head(var$coord, 4)

fviz_pca_var(res.pca, col.var = "black")

#The plot above is also known as variable correlation plots. It shows the relationships 
#between all variables. 
#It can be interpreted as follow:
  
#Positively correlated variables are grouped together.
#Negatively correlated variables are positioned on opposite sides of the plot origin 
#(opposed quadrants).
#The distance between variables and the origin measures the quality of the variables
#on the factor map. 
#Variables that are away from the origin are well represented on the factor map.

#Quality of representation
#The quality of representation of the variables on factor map is called cos2
#(square cosine, squared coordinates). 
#You can access to the cos2 as follow:
  
head(var$cos2, 4)
#It’s also possible to create a bar plot of variables cos2 using the function
#fviz_cos2()[in factoextra]:
  
# Total cos2 of variables on Dim.1 and Dim.2
fviz_cos2(res.pca, choice = "var", axes = 1:2)

#Note that:
#A high cos2 indicates a good representation of the variable on the principal component. 
#In this case the variable is positioned close to the circumference of the correlation circle.

#A low cos2 indicates that the variable is not perfectly represented by the PCs. 
#In this case the variable is close to the center of the circle.

#For a given variable, the sum of the cos2 on all the principal components is equal to one.

#If a variable is perfectly represented by only two principal components (Dim.1 & Dim.2), 
#the sum of the cos2 on these two PCs is equal to one. 
#In this case the variables will be positioned on the circle of correlations.

#For some of the variables, more than 2 components might be required to perfectly 
#represent the data. 
#In this case the variables are positioned inside the circle of correlations.

#In summary:
  
#The cos2 values are used to estimate the quality of the representation
#The closer a variable is to the circle of correlations, the better its representation 
#on the factor map (and the more important it is to interpret these components)
#Variables that are closed to the center of the plot are less important for the first 
#components.
#It’s possible to color variables by their cos2 values using the argument col.var = "cos2". 
#This produces a gradient colors. In this case, the argument gradient.cols can be used 
#to provide a custom color. 
#For instance, gradient.cols = c("white", "blue", "red") means that:
  
#variables with low cos2 values will be colored in “white”
#variables with mid cos2 values will be colored in “blue”
#variables with high cos2 values will be colored in red
# Color by cos2 values: quality on the factor map
fviz_pca_var(res.pca, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE # Avoid text overlapping
)

#Contributions of variables to PCs
#The contributions of variables in accounting for the variability in a given principal 
#component are expressed in percentage.

#Variables that are correlated with PC1 (i.e., Dim.1) and PC2 (i.e., Dim.2) are 
#the most important in explaining the variability in the data set.
#Variables that do not correlated with any PC or correlated with the last dimensions 
#are variables with low contribution and might be removed to simplify the overall analysis.
#The contribution of variables can be extracted as follow :
  
head(var$contrib, 4)

#The larger the value of the contribution, the more the variable contributes to
#the component.

#It’s possible to use the function corrplot() [corrplot package] to highlight the 
#most contributing variables for each dimension:
  
library("corrplot")
corrplot(var$contrib, is.corr=FALSE)  

#The function fviz_contrib() [factoextra package] can be used to draw a bar plot 
#of variable contributions. 
#If your data contains many variables, you can decide to show only the top 
#contributing variables. 
#The R code below shows the top 10 variables contributing to the principal components:
  
# Contributions of variables to PC1
fviz_contrib(res.pca, choice = "var", axes = 1, top = 10)
# Contributions of variables to PC2
fviz_contrib(res.pca, choice = "var", axes = 2, top = 10)


#Graph of individuals

#The results, for individuals can be extracted using the function get_pca_ind() [factoextra package]. 
#Similarly to the get_pca_var(), the function get_pca_ind() provides a list of matrices containing all 
#the results for the individuals (coordinates, correlation between individuals and axes, squared cosine and contributions)

ind <- get_pca_ind(res.pca)
ind
## Principal Component Analysis Results for individuals
##  ===================================================
##   Name       Description                       
## 1 "$coord"   "Coordinates for the individuals" 
## 2 "$cos2"    "Cos2 for the individuals"        
## 3 "$contrib" "contributions of the individuals"
#To get access to the different components, use this:
  
# Coordinates of individuals
head(ind$coord)
# Quality of individuals
head(ind$cos2)
# Contributions of individuals
head(ind$contrib)

fviz_pca_ind(res.pca)

#Color by groups
#Here, we describe how to color individuals by group. 
#Additionally, we show how to add concentration ellipses and confidence ellipses by groups. 
#For this, we’ll use the iris data as demo data sets.

#Iris data sets look like this:
  
head(iris, 3)

# The variable Species (index = 5) is removed
# before PCA analysis
iris.pca <- PCA(iris[,-5], graph = FALSE)
#In the R code below: the argument habillage or col.ind can be used to specify the factor variable for coloring the individuals by groups.

#To add a concentration ellipse around each group, specify the argument addEllipses = TRUE. 
#The argument palette can be used to change group colors.

fviz_pca_ind(iris.pca,
             geom.ind = "point", # show points only (nbut not "text")
             col.ind = iris$Species, # color by groups
             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
             addEllipses = TRUE, # Concentration ellipses
             legend.title = "Groups"
)

#To remove the group mean point, specify the argument mean.point = FALSE.

#If you want confidence ellipses instead of concentration ellipses, use ellipse.type = “confidence”.

###ggplot2: http://www.sthda.com/english/wiki/ggplot2-essentials