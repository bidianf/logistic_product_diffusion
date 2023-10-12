# Forecasting technology adoption and market penetration using a logistic S-curve model
# Florin Bidian
# October 10, 2023


The market penetration over time of a new product or service follows,
typically, an S-shape pattern. The diffusion of a technology/product in the population is slow initially, then it accelerates, and finally, as the market saturates, the growth slows down again. S-curve dynamics can be explained by a simple adoption model driven by imitation and innovation (Bass 1969), which is a particular case of the deterministic population models of Volterra and D’Ancona (1935). Kulperger and Guttorp (1981) introduce a stochastic version of such
processes described by stochastic differential equations.

This Shiny App  predicts the percent of population
using the internet (the *market penetration* ) in various countries.
Internet penetration up to 2021 is sourced from the [World Bank
(IT.NET.USER.ZS)](https://databank.worldbank.org/metadataglossary/world-development-indicators/series/IT.NET.USER.ZS).
The app allows for the selection of countries, training data window,
forecast horizon and model to fit (currently only one model is included). If you do not want to use the graphical interface, you can run "script.R" after modifying the inputs section of the code as desired. The code can be applied with minor modifications to other products or services. The app is modular and the model fit to the made can be changed, without altering anything else. For example, as explained below, we can modify the model the estimate the fraction of the population that will adopt the product/technology in the limit, in case we don't believe that the ultimate adoption will be 100%.

![screenshot](screenshot.png)

I describe the methodology. Consider the time series of the internet
penetration in a given country, $(F(t))_{t=0}^T$. We assume that the 
evolution of the internet penetration in a given country is well approximated by the logistic cumulative distribution
function having an S-shape,
$$
F(t)=  \frac{1}{1+\exp(-k(t-m))} =\frac{1}{1+(1/F(0)-1) \exp(-k t)}.
$$ 
The parameter $k$ captures the growth rate in internet users and $m$
is an offset parameter (the median of the distribution). Alternatively, the technology diffusion in the population is described by the “logistic equation” 
$$
F'(t) = k F(t) (1-F(t)),
$$ 
which has as solution the above $F$ if we impose the initial condition $F(0) := (1+\exp(k m))^{-1}$. The transition probability $F'(t)/(1-F(t))$ from the pool of
non-customers to customers is linear in the market penetration with a
slope $k$. If more than one country is selected, the parameter $k$ is
assumed identical across countries and estimated via a pool regression
of changes in market penetration $F'(t) \approx F(t+1)/F(t)-1$ on
$1-F(t)$, without an intercept, 

$$
\frac{F'(t)}{F(t)} \approx \frac{\Delta F(t)}{F(t)} = k F(t).
$$

Notice that $F(t)$ approaches $1$ as $t \rightarrow \infty$,
and therefore we implicitly assume that eventually the entire population
will use internet (this has already happened in some countries). With a
slight modification, we can adapt the model to estimate the *market
capacity* ( *saturation point* ), that is, the fraction of population at
which the growth stops, in case we don’t believe that the asymptotic
market penetration is 100%.  Denote by $s$ the (unknown) share of
population where saturation is reached. The penetration relative to the
relevant smaller population is 

$$
\tilde F(t) := F(t)/s \Rightarrow  F'(t)/s =  \frac{k}{s} F(t)(1-F(t)/s) \Rightarrow \frac{F'(t)}{F(t)} = k -\frac ks F(t). 
$$

By regressing the change in market penetration $\Delta F(t)/F(t)$ on
the market penetration $F(t)$, the intercept is an estimate for $k$ and
the slope estimates $-k/s$ from which the fraction of the population $s$
can be calculated.

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Bass" class="csl-entry">

Bass, Frank M. 1969. “A New Product Growth for Model Consumer Durables.”
*Management Science* 15 (5): 215–27.

</div>

<div id="ref-Guttorp1981" class="csl-entry">

Kulperger, R., and P. Guttorp. 1981. “Criticality Conditions for Some
Random Environment Population Processes.” *Stoch. Proc. Appl* 11:
207–12.

</div>

<div id="ref-Volterra" class="csl-entry">

Volterra, V., and U. D’Ancona. 1935. “Les Associations Biologiques.” *Au
Point De Vue Mathematiques*.

</div>

</div>
