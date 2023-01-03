import numpy as np
import pandas as pd

#main Dataset
dataset=pd.read_csv("BANES Energy Data Electricity.csv")
dataset.head()



#extracting the totalUnits from the main dataset
totaUnitsPower_data=dataset["totalunits"]
totaUnitsPower_data


outliers=[]
def detectOutliers(data):
    threshold=4
    mean=np.mean(data)
    std=np.std(data)

    for i in data:
        zScore=(i-mean)/std
        if np.abs(zScore)> threshold:
            outliers.append(i)
    return outliers

outliers_Points=detectOutliers(totaUnitsPower_data)
outliers_Points


#using InterQuantile Range method to detect Outliers
#first arrange the data in increasing order
sorted(totaUnitsPower_data)

#calculating the first and 3rd quantile
quantile_1, quantile_2=np.percentile(totaUnitsPower_data,[5,99])
print(quantile_1,quantile_2)


# find the InterQuantile Range 
iqr_value=quantile_2-quantile_1
print(iqr_value


# lower and upper bound values
lowerBound_value=quantile_1-(1.5*iqr_value)
upperBound_value=quantile_2+(1.5*iqr_value)
print(lowerBound_value,upperBound_value)




# any data point that is lower than the lowerBound and greater than the 
UpperBound will be considered as outlier
outLiers_detection=[]
for i in totaUnitsPower_data:
    if i < lowerBound_value or i > upperBound_value:
        outLiers_detection.append(i)

# outliers are:::
outLiers_detection
