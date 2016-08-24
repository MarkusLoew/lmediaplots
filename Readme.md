[![Build Status](https://travis-ci.org/MarkusLoew/lmediaplots.svg?branch=master)](https://travis-ci.org/MarkusLoew/lmediaplots)

Lmediaplots
==============

R-package to create diagnostic plots of nested lme models

See 

	help(package = lmediaplots) 

for details on the functions provided by this package.

### Installation

Installation straight from github (if package "devtools" is already installed) via

```{r}
devtools::install_github("MarkusLoew/lmediaplots")
```

Installation under Windows might require the installation of Rtools.

### Example usage
Based on a model from Pinheiro, Bates (2000) Mixed-Effect Models in S and S-PLUS. Springer.

```{r}
library(nlme)
library(Lmediaplots)
fm1Machine <- lme(score ~ Machine, data = Machines, random = ~ 1 | Worker/Machine)
lmediaplots(fm1Machine)
lmediaplots(fm1Machine, plottype = "resvfit")
lmediaplots(fm1Machine, plottype = "qq")
lmediaplots(fm1Machine, plottype = "qq")[1]

```
