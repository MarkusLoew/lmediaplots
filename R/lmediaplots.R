#' Function to create diagnostic plots for each random effect element of a lme object with a nesting ("within") component.
#' @description Function to create diagnostic plots for each random effect and for each group of a nested model.
#' @param lme.obj A "lme" object created using package "nlme". Must have a nesting / within component.
#' @param plottype Type of the diagnostic plot to create. Either "within" for box/scatter - plots of within-group residuals, or "resvfit" for a plot of the standardized residuals versus fitted values per group, or "qq" for diagnostic plots for assessing the normality of residuals and random effects in the linear mixed-effects fit per group. Default is "within".
#' @return List of plots. One plot for each random factor.
#' @examples
#' # based on example from Pinheiro, Bates (2000) Mixed-Effect Models in S and S-PLUS. Springer.
#' library(nlme)
#' fm1Machine <- lme(score ~ Machine, data = Machines, random = ~ 1 | Worker/Machine)
#' lmediaplots(fm1Machine)
#' lmediaplots(fm1Machine, plottype = "resvfit")
#' lmediaplots(fm1Machine, plottype = "qq")
#' lmediaplots(fm1Machine, plottype = "qq")[1]
#' @export


lmediaplots <- function(lme.obj, plottype = "within") {
   
   stopifnot(plottype %in% c("within", "resvfit", "qq"))
   
   # get the names of the random effect elements.
   the.names <- names(nlme::ranef(lme.obj))
   
   if("(Intercept)" %in% the.names) {
       stop("Model not nested")}
   
   #stopifnot(("(Intercept)" %in% the.names) == FALSE)
   
   if (plottype == "within") {
	   form.end <- "~ resid(.)"
	   form <- plyr::llply(the.names,
		         function(x) formula(paste(x, form.end, sep = " ")))
	   plotlist <- plyr::llply(form,
		             function(x) {
		             nlme::plot.lme(lme.obj, x, abline = 0)
		             })
	   return(plotlist)
   } 
   if (plottype == "resvfit") {
           # formula is the default for plot.lme
	   form.start <- "resid(., type = 'p') ~ fitted(.) |"
	   form <- plyr::llply(the.names,
		         function(x) stats::formula(paste(form.start, x, sep = " ")))
	   plotlist <- plyr::llply(form,
		             function(x) {
		             # using 0.05 for the significance level 
		             # for a two-sided outlier test 
		             nlme::plot.lme(lme.obj, x, id = 0.05)})
	   return(plotlist)
   }
   if (plottype == "qq") {
           # formula is the default for plot.lme
	   form.start <- "~ resid(., type = 'p') |"
	   form <- plyr::llply(the.names,
		         function(x) formula(paste(form.start, x, sep = " ")))
	   plotlist <- plyr::llply(form,
		             function(x) {
		             # using 0.05 for the significance level 
		             # for a two-sided outlier test 
		             stats::qqnorm(lme.obj, x, id = 0.05, abline = c(0, 1))})
	   return(plotlist)
   }
}
