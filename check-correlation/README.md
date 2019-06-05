# Description

The app is currently hosted [here](https://rjnunez.shinyapps.io/check-correlation/)

This app is simply to show that the sample correlation coefficient may not be the equal to the true population correlation
coefficient when the sample size is small. In fact, it may be the case that the sample correlation coefficient is very 
different from the truth. To show this, let X and Y be jointly normally distributed random variables centered at zero, 
with unit variance and correlation rho which is to be chosen by the user. The Sample Size input determines the number of 
observations to be drawn from the multivariate normal distribution. The higher this number is, the closer the sample 
correlation coefficient will be to the truth. The Simulations input determines the amount of times the experiment is to be 
repeated. The experiment is defined as randomly sampling from the random variables X and Y, computing the sample correlation 
coefficient and then comparing it to the truth. For example, let Simulations = 500 and Sample Size = 100, then the app will 
generate 100 random draws for X and Y respectively, compute the sample correlation coefficient and save it. Then it will 
repeat this 499 more times for a total of 500, each iteration with a different random sample. Finally, each data point in 
the figure below correspond to the sample correlation coefficient obtained at the corresponding simulation. The red-dash line 
correspond to the true (population) correlation coefficient.
