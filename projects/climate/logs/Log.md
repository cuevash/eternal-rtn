# LOG

## 2022-08-26

* Collecting sites with climate data
  * <https://cds.climate.copernicus.eu/#!/home>
    * Here some open data can be accesed, but i think that it is too technical
      * <https://www.ecmwf.int/en/forecasts/datasets/open-data>
    * They have a toolbox that runs on their own computers and can generate data and graphs
      * <https://cds.climate.copernicus.eu/toolbox/doc/index.html>
  * <https://www.ncei.noaa.gov/cdo-web/> 
    * <https://www.climate.gov/maps-data/dataset/global-temperature-anomalies-graphing-tool>
    * https://data.noaa.gov/onestop/
  * https://openweathermap.org/
  * https://nordicapis.com/6-best-free-and-paid-weather-apis/#:~:text=1.,%2C%20forecasts%2C%20and%20weather%20maps.
  * https://www.historicalclimatology.com/databases.html 


## 2022-08-31

The objective is to find a free place with mainly current and historical data of:

* Temperature
* Rain
* Cloud
* Sun
* Wind

Reviewing the places above to find out which ones and how to get this data from them.

* <https://cds.climate.copernicus.eu>
  * Dataset -> <https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-land?tab=form> 
  * Gives quite a few variables in a grid.
  * Allows for historical reanalysis data and current
  * Can search by longitude, latitude. Region.

* Learning how to access the data from external app:
  * <https://confluence.ecmwf.int/display/CKB/How+to+install+and+use+CDS+API+on+macOS>
    * Creating virtual python env.
    * Installing conda install -c conda-forge cdsapi
* Using this as starting point:
  * <https://towardsdatascience.com/read-era5-directly-into-memory-with-python-511a2740bba0> 
* Installing ```{sh} conda install -c conda-forge jupyterlab``` 

## 2022-08-31

Summary:

* <https://cds.climate.copernicus.eu>
  * Has a reanalysis data ERA5 (last generation) that is grided and can be pretty good. It is referenced in many other sites.
  * Dataset -> <https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-land?tab=form> 
  * Historical & Current
  * <https://www.ecmwf.int/en/forecasts/datasets/open-data> 
    * Many other datasets
* <https://www.ncei.noaa.gov/cdo-web/>
  * Many datasets online.
  * Global data as well, but I think the one ERA5 has better time & space resolution  
  * <https://www.climate.gov/>
    * Good place with lots of information about the climate
  * <https://data.noaa.gov/onestop/>
    * Many datasets 
* https://public.wmo.int/en
  * Many datasets
  * World organization
* <https://www.historicalclimatology.com/databases.html>
  * Many historical datasets 
* Private ones:
  * <https://openweathermap.org/>
  * Find API's -> <https://nordicapis.com/>

## 2022-12-01

* Thinking about making a map with some climate info. This could be a cool background for the map.

````{r}
tmap_mode("view")
tm_basemap("Stamen.Watercolor") +
tm_shape(metro) + tm_bubbles(size = "pop2020", col = "red") +
tm_tiles("Stamen.TonerLabels")
````

* Finding a good base of Spain's sf provinces units for maps.
* 


## 2022-12-05

* En el gráfico de mapa poner un solo color con las capitales que hayan sido mas calientes en octubre

* Gráfico de Santander octubre,
  * reducir rango de temperaturas
  * Ponerlo como media movil.