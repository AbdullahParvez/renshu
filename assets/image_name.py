import os
import re

folder_name = [
    "images/2011_am",
    "images/2011_pm",
    "images/2012_am",
    "images/2012_pm",
    "images/2013_am",
    "images/2013_pm",
    "images/2014_am",
    "images/2014_pm",
    "images/2015_am",
    "images/2015_pm",
    "images/2016_am",
    "images/2016_pm",
    "images/2017_am",
    "images/2017_pm",
    "images/2018_am",
    "images/2018_pm",
    "images/2019_am",
    "images/2019_pm",
    "images/2020_am",
    "images/2020_pm",
    "images/2021_am",
    "images/2021_pm",
]
for name in folder_name:
#     path = "images/2011_am"
    files = os.listdir(name)

    for index, file in enumerate(files):
        # print(transform_text(file))
        print( '    - '+'assets/'+name+'/'+file)