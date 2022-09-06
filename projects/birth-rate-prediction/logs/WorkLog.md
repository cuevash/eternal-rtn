# LOG

## 2022/07/19

- Creating project birth-rate-prediction
- Creating new conda env base-3.8 with python 3.8
- Setting this conda env as the default one.

## 2022/07/20

- Looking for data to run a linear regression:

  - Interesting exploration of facts in Australia.. does it apply to other countries as well?
  - <https://www.humanfertility.org/Docs/Symposium/McDonald_Kippen.pdf>
  - <https://bmcpregnancychildbirth.biomedcentral.com/articles/10.1186/s12884-021-04373-5>
  - <https://www.researchgate.net/publication/299436950_Using_Machine_Learning_to_predict_fertility_rates_based_on_economic_indicators>
  - <https://medium.com/@martinvanpetersburg/curious-about-birth-counts-796701ccf48a>
  - <https://unece.org/fileadmin/DAM/stats/documents/ece/ces/ge.11/2019/mtg1/D3_1150_S6_WP10_Hilton2.pdf>
  - <https://medium.com/towards-data-science/koreas-tanking-fertility-rate-what-does-it-mean-380a2477b4d6>
  - <https://medium.com/towards-data-science/animated-charts-visualizing-changes-in-r-fee659fbabe5>
  - <https://www.projectpro.io/article/mlops-projects-ideas/486>

- I am going to use the <https://www.researchgate.net/publication/299436950_Using_Machine_Learning_to_predict_fertility_rates_based_on_economic_indicators> as a reference for this project.

- First step is to understand DVC to handle the lifecycle of a ML project.
- Installing DVC in the default conda-3.8 env
  - <https://dvc.org/doc/install/macos#install-with-conda>
  - Installing DVC shell Zsh completion -> <https://dvc.org/doc/install/completion>
- Installing plugin for Visual Studio Code

-

## 2022/07/22

- Yesterday i have a good overview of what DVC is and what bring to the table from POV of managing a reproducible ML project.
- Today my goals are:
  - [ ] How to reference external dependencies in a stage pipeline step
  - [ ] Understand better what a pipeline is and create a step to download the files needed
  - [ ] Test what happens with the dependencies files when creating a new project
  - [ ] Learn the role of Hydra (<https://hydra.cc/>) into the MlOps framework..
  - [ ] How to handle conda and poetry..

## 2022/07/23

- Customizing the visualization of dataframes in jupyter
  - <https://towardsdatascience.com/6-tips-to-customize-the-display-of-your-pandas-data-frame-ce5a8caa7783>

## 2022/07/24

- Choosing the right tool to explore the csv files.

  - TableCruncher seems to be able to open big files and there is a handy free version that os probably enough for now.
  - Excell
  - Colab google
  - Others ??
  - Some libs to improve dataframe visualization in Jupyter:
    - <https://pbpython.com/dataframe-gui-overview.html>
    - <https://notebooks.githubusercontent.com/view/ipynb?browser=chrome&color_mode=auto&commit=20de2670c65c2b68a208b34513517e0fc47a4fc2&device=unknown&enc_url=68747470733a2f2f7261772e67697468756275736572636f6e74656e742e636f6d2f7175616e746f7069616e2f71677269642d6e6f7465626f6f6b732f323064653236373063363563326236386132303862333435313335313765306663343761346663322f696e6465782e6970796e62&logged_in=false&nwo=quantopian%2Fqgrid-notebooks&path=index.ipynb&platform=android&repository_id=102975753&repository_type=Repository&version=99>

- Using the personal one-drive/eternalRtn/birth-rate-prediction online folder as temporary place to explore Excel files on Excel online.
- Using powerbi to analyze big csv files. I think is the best tool for the job.. At least if you have Premium licence... Either that or loading the csv to some big data lake.

## 2022/07/31

- Checking status.
- Observing the csv files. Choosing a method for big files.
- As I have some problems opening the files I loaded them temporarily into BigQuey and do a Select * FROM ..
to have a good look to the csv files and understand better their structure.
- In the end , waiting a bit it can be opened in Excel.

- Selecting the attributes to be used as predictors for birth rate. Initially we would like some indicators that are related to:
- Level of education of females
- Rate of employment females
- Fertility rate
- GDP
- GDP Per capita
- Consumer prince index
- GNI

## 2022/08/02

- Installing black for notebooks use. To be able to format notebooks
  <https://hackernoon.com/using-black-to-auto-format-your-python-8cu338f>

## 2022/08/04

- Manipulating data frames to create a single data frame with all the predictors and ..
- Pandas doc has nice formatting... just saying -> https://pandas.pydata.org/docs/user_guide/10min.html 

- Adding dask library to pearlize the reading of huge CSV files.
- Installing jupyterlab for a more modern development enviroment.
- Installing formatter for Jupyter lab
  - https://coiled.io/blog/code-formatting-jupyter-notebooks-with-black/

## 2022/08/05

- Merged all dataframes into one with only countries with values for all features.
- Traverse the data to get a wide row data per each country, so each country is an observation with different features.

- Installing bokeh and bokeh for jupyter lab -> <https://docs.bokeh.org/en/latest/docs/user_guide/jupyter.html>

## 2022/08/16

- Installing scikit-learn >= 1.1.2
  - There is a problem with the dependency scipy lib. 
  - Solved:
    - Installed the scipy in the toml file like -> scipy = "^1.9.0"
    - And restrict the python version to -> python = ">=3.10,<3.12" in order no to get errors of compatibility due to versions.

## 2022/08/16

- Reviewing other posts , mine seems to be a bit short on some areas.. Either focus on the data science area.. or focus  on the data processing are plus set in production.
as I may not yet be well versed on all the data science areas, it may be better to focused on the whole lifecycle thingy.
- What os missing? 
  - To add/organize the python code to set the code to be run automatically, and maybe deploy automatically somewhere..
- Definitely set it up more like a good example of DVC whole pipeline.