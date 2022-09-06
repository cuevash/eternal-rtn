"""
this is an example os how to use the get_era5() function
"""
import cdsapi
import xarray as xr
from urllib.request import urlopen
import urllib3
import proplot as plot
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import get_era5

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


# get the data using the get_era5() function
# available here: https://gist.github.com/lgloege/f461f8d192e99fe7c36760a7a856b007
ds_out = get_era5(
    dataset_name="reanalysis-era5-single-levels-monthly-means",
    var="2m_temperature",
    dates=["2021-02-01"],
    grid=[0.25, 0.25],
)

# create figure and axes
fig, ax = plot.subplots(
    axwidth=6,
    tight=True,
    proj="robin",
    proj_kw={"lon_0": -0},
)

# format options
ax.format(
    land=False,
    coast=True,
    innerborders=True,
    borders=True,
    labels=False,
    latlines=None,
    lonlines=None,
)

# plot data
map1 = ax.contourf(
    ds_out["longitude"],
    ds_out["latitude"],
    ds_out["t2m"].squeeze() - 273.15,
    vmin=-30,
    vmax=30,
    cmap="IceFire",
    extend="both",
    levels=20,
)

# set the title
ax.set_title("ERA5 monthly mean 2m temperature - February 2021", fontsize=14)

# set the colorbar
col = ax.colorbar(map1, loc="b", shrink=0.5, values=np.arange(-30, 30))
col.set_label("$\circ$C", labelpad=0, size=12)
col.ax.tick_params(labelsize=12)
