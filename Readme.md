[![Build Status](https://travis-ci.org/MarkusLoew/Lmediaplots.svg?branch=master)](https://travis-ci.org/MarkusLoew/Lmediaplots)

Lmediaplots
==============

R-package to create diagnostic plots of nested lme models

See 

	help(package = Lmediaplots) 

for details on the functions provided by this package.

### Installation

Installation straight from github (if package "devtools" is already installed) via

```{r}
devtools::install_github("MarkusLoew/Lmediaplots")
```

Installation under Windows might require the installation of Rtools.

### Example usage
Based on a model from Pinheiro, Bates (2000) Mixed-Effect Models in S and S-PLUS. Springer.

```{r}
library(nlme)
library(Lmediaplots)
fm1Machine <- lme(score ~ Machine, data = Machines, random = ~ 1 | Worker/Machine)
Lmediaplots(fm1Machine)
Lmediaplots(fm1Machine, plottype = "resvfit")
Lmediaplots(fm1Machine, plottype = "qq")
Lmediaplots(fm1Machine, plottype = "qq")[1]

```
