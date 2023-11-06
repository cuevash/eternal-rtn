# LOG

## 2023-07-11

* With the data from NOA of the thousnadts of measure stations we will built a PowerBI project to easyly handle those data.
* The idea is to add country and city information to the positional points.
* Initially we will do it only for Spain to be learn properly how to handle incremental refresh in PowerBI

* Other initiative is to squeeze chatGPT and other tools to understand how to handle both technologies on our advantage.

* Lets create a PowerBI project.
  * Climate_II_Dataset_Report_v1.0.pbix
  * Reading <https://www.ncei.noaa.gov/pub/data/ghcn/daily/readme.txt>
  * Add stations from the from ghcnd-stations.txt to PowerBI

## 2023-07-15

* In order to get cities closest to places we will use BigQuery
  * Database of stations -> bigquery-public-data.ghcn_d.ghcnd_stations
  * Databse of cities -> Uploaded csv from - > <https://simplemaps.com/data/world-cities>
  * Done! Created the results in the file -> NearbyCitiesTable2_3000.csv
  * Uploading such file to Dataflow
  
## 2023-07-18

* BigQuery has been great! They have a copy of all the ghncd data and so it is easy to make transformations there.
* I have added several sql queries to filter, combine and transform the data to our needs. It is almost ready to just load it to Powerbi.
  * Now , it would be a good idea to think whether to use incremental dataset and load the data directly to the dataset or to use a dataflow.
  Somethinh that need to be thought about.

## 2023-08-02

* At the moment we have a few dataflows. One of them load most of the historical data and another one loads the current year(2023). On this way we only need to update the second one. And then we merge these two dataflows into another big one.
That means that the merged dataflow has to handle with gigabytes of data every time we updated the current year dataflow. That is not very efficient.
So the idea is to convert this architecture into one that uses incremental loading. But that would be the second phase, on this first one we just want some data into PowerBI asap.
So we can keep crunching up stories about this warm summer.

## 2023-08-05

* Learning fabric to try to automate the extraction of all the aemet historical and current data.

* This instrucction below is the typical API rest call that is needed to extract all the climatology data in junks of 30 days at a time.
*
  curl --request GET \
  --url '<https://opendata.aemet.es/opendata/api/valores/climatologicos/diarios/datos/fechaini/2022-09-01T00:00:00UTC/fechafin/2022-09-03T00:00:00UTC/todasestaciones/?api_key=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjdWV2YXNoLnNwQGdtYWlsLmNvbSIsImp0aSI6ImJhMGZiZGIyLTA5MjEtNGRmYi05M2UwLTYxNTQ3NjdkOTQ2NiIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNjg5NjgwMDI0LCJ1c2VySWQiOiJiYTBmYmRiMi0wOTIxLTRkZmItOTNlMC02MTU0NzY3ZDk0NjYiLCJyb2xlIjoiIn0.shVzYiWWmiKXTSPhpDq2gKfsYe8nbTKYMgvN7CTI9_w>' \
  --header 'cache-control: no-cache'

"<https://opendata.aemet.es/opendata/api/valores/climatologicos/diarios/datos/fechaini/>" + variables('yearVar') + "/fechafin/" + variables('yearVar') + "/todasestaciones/"

"<https://api.example.com/data/year=>" + variables('yearVar') + "&month=" + variables('monthVar')

@"/opendata/api/valores/climatologicos/diarios/datos/fechaini/" + variables('Current_Date_Begin') + "/fechafin/" + variables('Current_Date_End') + "/todasestaciones/"variables('Current_Date_End')

SPE00119711

  --url '<https://opendata.aemet.es/opendata/api/valores/climatologicos/diarios/datos/fechaini/2022-09-01T00:00:00UTC>

  abfss://3fd7b9ef-0b10-4d05-ae7c-eaa42abfe109@onelake.dfs.fabric.microsoft.com/93d40a0d-294b-459f-b5de-70428184773f/Tables/Cities_DIM

"output": [
  {
    "descripcion": "exito",
    "estado": 200,
    "datos": "https://opendata.aemet.es/opendata/sh/18e94e42",
    "metadatos": "https://opendata.aemet.es/opendata/sh/b3aa9d28"
  }
]

The parameters and expression cannot be resolved for schema operations. Error Message: {
  "message": "ErrorCode=InvalidTemplate, ErrorMessage=The expression 'replace(activity('Get_URL_Data').output[0].datos, '<https://opendata.aemet.es/>', '')\n' cannot be evaluated because property 'output' doesn't exist, available properties are 'output[0]'.."
}

curl -X 'GET' \
  '<https://opendata.aemet.es/opendata/api/valores/climatologicos/inventarioestaciones/todasestaciones?api_key=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjdWV2YXNoLnNwQGdtYWlsLmNvbSIsImp0aSI6ImJhMGZiZGIyLTA5MjEtNGRmYi05M2UwLTYxNTQ3NjdkOTQ2NiIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNjg5NjgwMDI0LCJ1c2VySWQiOiJiYTBmYmRiMi0wOTIxLTRkZmItOTNlMC02MTU0NzY3ZDk0NjYiLCJyb2xlIjoiIn0.shVzYiWWmiKXTSPhpDq2gKfsYe8nbTKYMgvN7CTI9_w>' \
  -H 'accept: application/json'

## 2023-08-23

* Phases to achieve all data of Aemet into a Datawarehouse and finally into PowerBI
  * Pipeline to collect stations and assign a city to each station.
    * Pipeline to collect stations
    * Clean data and create a table. Delta file. Is that good enough to later on run a SQL to assign a city to each station calculating the shortest distance to all cities? Is it effcient enough? Or is it necessary to have a proper DB to make those calculations?
    * Pipeline to get all major worldwide cities. Use the same ones that is used for "Climate II"

## 2023-08-24

* Working on Aemet pipeline
  * If cities already got data do nothing otherwise run the pipeline to get and clean the cities table.
  * Exploring how to handle geography operations.
    * I have added a WKF column to both, cities and stations table.
    * Exploring where can i use Geography operations such as closest.
      * T-SQL has some geography operations, but it is not clear how to use them with a Lakehouse sql endpoint..
      * Another option is to use Sedona or something like that library..

## 2023-08-25

* Working on Aemet pipeline
  * The Sedona library is not so easy to integrate in the spark notebooks of Fabric. It seems to be easier to integrate with Azure Databrics spark notebooks. I guess it will become easier to integrate in the nearby future.
  Definitely something to keep an eye on.
  * How to create the delta table with all the stations readings?
    * I consider to have a big delta table with all the readings and then upload the differentials. And maybe using some partitioning strategy (it seems that it is not so great idea to partition under 1 Terabyte.)
    * The optimal strategy needs to be researched.
    * At the moment lets start with something simple. Just merge all the csv files into a delta table and overwrite the previous one. As the size is around 1GB it should not be a problem for Spark. Hierarchically
    *

## 2023-08-28

* Cleaning the pipelines and names of columns.
  * Done!
* [TODO]
  * Add a hierarchy on Calendar table. That allows to drill through whenever we use dates as one of the axes in a chart.
    * Done!

## 2023-08-29

* Added dates from 1920. That's the limit of data from AEMET rest api. Checked empirically.
* Changed calendar to get dates from 1900, just in case we get more antique data! :-)
* Changed Region for AzuredDevOps, so it is the same that the region of Fabric (North-Europe-Ireland)
