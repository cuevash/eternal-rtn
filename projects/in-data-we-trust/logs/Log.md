# LOG

## 2022/05/19

* Establish steps to reach data proficiency in 9 months!
  
There are multiple heads to this problem that need to be tackled simultaneously. I need to become proficiency in:

* As data analyst
  * Data warehouse design
  * Powerbi
  * ETL/ELT

* As data scientist
  * Python and libs (numpy etc)
  * Math
    * Statistics
    * Linear algebra
    * ML
    * Python ML libs and others

* It could be a good idea to create a small dictionary of typical attribute names in a BI application in English and its Spanish counterpart.

* Screens with some validation over the data.

## 2022/05/23

* Reading and in-depth learnig of a Retail Sales model in Dimensional Modelling from the book "The Datawarehouse Toolkit- 3rd Edition"

## 2022/05/24

* Find a retail data and build a model from a database.

## 2022/05/31

* Make a data analyst project related to birth ratio in the world. Use python ?

## 2022/06/08

* Check whether the meltano app helps to do some ETL.

## 2022/06/23

* Understanding a P&L dashboard. See log in financials project.

## 2022/06/27

* Starting the specialization -> <https://www.coursera.org/specializations/machine-learning-introductio>

## 2022/07/01

* Semi supervised learning (is it important)

## 2022/07/02

* Schedule time to improve intuition for counting methods is probability.
* Revise a bit of calulus, derivatives , integrals..

## 2022/07/04

* Review some multivarariate calculus.

## 2022/07/04

* Consider jobs of data science/data analysis in the agro sector.. Seems to be a lack of people dedicated to it.

## 2022/07/06

* Increase intuition over the definitions of continuous random variables, marginal
distributions, conditional distributions etc.

## 2022/07/07

* When making project of data, consider make it more amazing adding concepts such as , explanatory variables, covariate variables, unexplained variation in the response variable.. etc!

* Remove file "instacart-market-basket-analysis.zip" because it was too large. But just to know that you can use that file to make data analysis in market basket

* Datos dgt .. Can we infere something? ..Maybe for the data given only an exploratory exercise can be done.
* The madrid 'ayuntamiento' may have data about traficc accidents. look for them.
* Congreso de Cordoba. Have 'cojones' and prepare a paper.

## 2022/07/12

* Review a bit more deep, covariance and correlation

## 2022/07/16

* Think about how to back up the decisions taken when selecting a model. Some confidence interval..
Some hypotheses, some variable selection in a linear model etc.

* Need to find a coffee alternative as stimulant..

* If you were an architect of solutions and you want to demonstrate to somebody that that is the case
it will be cool to have a set of use cases where all the major problems with their solutions are tackled and some explanation about why that solutions is good. And also explain some other ralternative solutions.. And when and why to choose them..

* So once that the math/statistics is automated and so is a bit out of the picture of the skills nedded to act as a data scientist what is probably left is:
* To choose the right method/family of methods automated by some software
* Choose which data is needed and get it from internal databases and public databases
* Clean the data, verify that the data can be used, verify that the data comes from the right
 type of experiment.. at least theoretically.

## 2022/07/17

* Whats the best way to organize an R project?
  * <https://style.tidyverse.org/>
  * Find a good R project template for small/medium projects
  * Define a R project workflow .. Find out that makes sense
  * Best practices for a data science project. See below.
  * See:
    * ONS duck book
    * The turing way
    * The GDS way

* Creating the project bus-number-101 based on project <https://github.com/hackalog/bus_number> to familiarize myself with cookiecutter and a basic example of reproducible data science project.
  * Running:
    * conda install -c conda-forge cookiecutter
    * Using a Data Science Template: cookiecutter

## 2022/07/19

* Running and learning the cookiecutter from <https://github.com/hackalog/bus_number>. It is a nice example of a template for data science projects with some reproducible features.
* Interesting quote from fashion-MNIST

  ```
  The original MNIST dataset contains a lot of handwritten digits. Members of the AI/ML/Data Science community love this dataset and use it as a benchmark to validate their algorithms. In fact, MNIST is often the first dataset researchers try. "If it doesn't work on MNIST, it won't work at all", they said. "Well, if it does work on MNIST, it may still fail on others."
  ```

  * Okay, initially I'll be following this blog -> <https://www.kdnuggets.com/2022/05/structure-data-science-project-stepbystep-guide.html>

## 2022/07/23

* Reading about the best data visualization libs to use. The best candidates seem to be:
  * Bokeh
  * Plotly
  * Altair
  * Plotnine (like ggplot2 in r), main problem is that it relies on matplotlib to render so, the graphics are not very impresed to say the least.
* For the time being Bokeh seems to be a good compromise on all fronts.
* In other order of things, which formatter to use in python code? -> <https://deepsource.io/blog/python-code-formatters/>
  * Seems black is the most used one.. so that settles the thing.
* There is a problem with "nbstripout" lib being used in a precommit action. Dont know what is the problem, but as it does not seem to be straightforward I have just comment out the lines in the pre-commit action. Should be investigated further.

## 2022/07/28

* WeCode - Elia webpage
  * Blogs
  * Forms
  * How to move the ones already on the web? Manually? Is it possible to create script?
    * Access to the raw data? DB?
  * Can a user add a:
    * Blog Entry
    * House entry
    * Other entries..
    * Backup // Versions?

## 2022/08/02

* Webflow - Demo with
  * CMS
  * forms
  * filter for cms entries.

* Architecture
* Submit action -> (something) -> google sheets -> response (show success//error)
  * The something could be retool -> <https://retool.com/>
  * Most of the apps sass in themarket similar to Zapier are a bit expensive for what we want.
  * To call directly the google sheets API could become a bit complicated to mantain.. Is there something easier? Maybe Retool.
  * Retool is great to create internal tools.. no so great to create APIs, and thats what we need to connect to submit of a Webflow form to google sheets.
  * There two integration tools that have a reasonable pricing:
    * <https://automate.io/pricing> (600 actions per month enough ? )
    * [Pabbly](https://www.pabbly.com/connect/)
    * Pipedream seems even better and cheaper..
  * Yes pipedream is the chosen one to connect to google sheets man. 

## 2022/08/03

* Architecture so far.
  * FrontEnd (Webflow)
  * Forms 
    * Initially the ones for the site Plan cover 1000 forms per month, should be enough.
    * If the 1000/month are not enough forms then use pipedream that provides up to 10.000 actions/month
    * Use recaptcha (from google) it is integrated someway with webflow.
      * How to use it if we have to integrate without the limit of 1000 ? 
  * Filters
    * This seems to be a profesional free solution -> https://www.finsweet.com/attributes/cms-filter 
      * All explained in -> https://www.youtube.com/watch?v=FFvIb1gQYa8
  * Performance
    * Consider having a look to this -> https://www.littlebigthings.dev/webflow-cms-image-optimizer
    for images performance
    * It seems that cms images are already improved because they wont be sent till they are used on the page. 

## 2022/08/05

* Add some course of microservices and node.js and then invent some microservices to go with it. And some architecture, test etc.. Everybody is asking for those!

## 2022/09/07

* The microservices thing could be done with an stock app . The main architecture would go something like this:

Client (next.js) -> microservices (next.js) -> ORM (prisma.io) -> Database Postgresql

If you want to use a full rest api server such as nest.js check how to do it serverless -> maybe in google cloud functions // Netlify functions // Vercel function

This can be deployed in a vercel enviroment.

Now:

* Can we use prisma.io in vercel? Yes!
* Does it make sense to use graphql? Maybe not yet
  
* So after researching a bit I settle on the next architecture to build a DB base APP.
  * Client (Next.js)
  * Rest backend (Next.js)
  * Prisma client for the DB
  * DB (PlanetScale) connection through the Prisma interface.
  * This at least for simple apps. If it gets more complex, it will be reevaluated.
  * Three environments, dev, staging, prod with GitHub actions for deployment.
    * This is actually the most difficult part of the project. The plumbing!! 

* So now we create the different elements.
  * Planetscale login

## 2022/09/30

* Bilayer Meeting:
  * Decide to publish a climate graph
  * Think about two others for next week
* WeCode
  * Make 1 example
    * Dashboard with echarts
      * Climatology by city? Spain // Europe ?
      * Climatology by Coordinate ?


## 2022/10/07

* Bilayer Meeting:
  * Two graphs more for monday
  * Publish?
  * RChart gallery
  * Blog of how to explore data from the CDS with R (Small one!)
* WeCode
  * Make 1 example
    * Dashboard wi

## 2022/10/19

* Bilayer Meeting:
  * Publish Graph (Mondays)
  * WeCode
    * Example (small)
  * Bilayer
  * Data analysis jobs? (freebies)
    * Josu
    * Abu