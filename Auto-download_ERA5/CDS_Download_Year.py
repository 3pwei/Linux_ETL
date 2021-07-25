import cdsapi
import sys

file_position = "PATH/YYYY/ABCDEFGH00.nc"

year = file_position[-13:-9]
month = file_position[-9:-7]
days = file_position[-7:-5]

x_10=[str(i) for i in range(1,11)]
x_20=[str(i) for i in range(11,21)]
x_30=[str(i) for i in range(21,31)]
x_31=[str(i) for i in range(21,32)]
x_28=[str(i) for i in range(21,29)]
x_29=[str(i) for i in range(21,30)]

if days==str(10):
    day = x_10
elif days==str(20):
    day = x_20
elif days==str(28):
    day = x_28
elif days==str(29):
    day = x_29
elif days==str(30):
    day = x_30
else:
    day = x_31


c = cdsapi.Client()

print(" ")
print("file_position:",file_position)
print("Year:",year)
print("Month:",month)
print("Day:",day)
print(" ")

c.retrieve(
    'reanalysis-era5-land',
    {
        'format':'netcdf',
        'year':year,
        'month':month,
        'time':[
            '00:00','01:00','02:00',
            '03:00','04:00','05:00',
            '06:00','07:00','08:00',
            '09:00','10:00','11:00',
            '12:00','13:00','14:00',
            '15:00','16:00','17:00',
            '18:00','19:00','20:00',
            '21:00','22:00','23:00'
        ],
        'day': day,
        'variable':[
            'volumetric_soil_water_layer_1', 'volumetric_soil_water_layer_2',
        ],
    },
    file_position)
