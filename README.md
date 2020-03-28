https://www.kaggle.com/c/bike-sharing-demand/data
# LinearRegressionWithR
Linear Regression On Bike Sharing Demand Kaggle Dataset.

For this project you will be doing the Bike Sharing Demand Kaggle challenge!

Instructions
Just complete the tasks outlined below.

Get the Data
You can download the data or just use the supplied csv in the repository. The data has the following features:

datetime - hourly date + timestamp
season - 1 = spring, 2 = summer, 3 = fall, 4 = winter
holiday - whether the day is considered a holiday
workingday - whether the day is neither a weekend nor holiday
weather -
1: Clear, Few clouds, Partly cloudy, Partly cloudy
2: Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist
3: Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds
4: Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog
temp - temperature in Celsius
atemp - "feels like" temperature in Celsius
humidity - relative humidity
windspeed - wind speed
casual - number of non-registered user rentals initiated
registered - number of registered user rentals initiated
count - number of total rentals
Read in bikeshare.csv file and set it to a dataframe called bike.

Check the head of df

datetime	season	holiday	workingday	weather	temp	atemp	humidity	windspeed	casual	registered	count
1	2011-01-01 00:00:00	1	0	0	1	9.84	14.395	81	0	3	13	16
2	2011-01-01 01:00:00	1	0	0	1	9.02	13.635	80	0	8	32	40
3	2011-01-01 02:00:00	1	0	0	1	9.02	13.635	80	0	5	27	32
4	2011-01-01 03:00:00	1	0	0	1	9.84	14.395	75	0	3	10	13
5	2011-01-01 04:00:00	1	0	0	1	9.84	14.395	75	0	0	1	1
6	2011-01-01 05:00:00	1	0	0	2	9.84	12.88	75	6.0032	0	1	1
Can you figure out what is the target we are trying to predict? Check the Kaggle Link above if you are confused on this.

Exploratory Data Analysis
Create a scatter plot of count vs temp. Set a good alpha value.


Plot count versus datetime as a scatterplot with a color gradient based on temperature. You'll need to convert the datetime column into POSIXct before plotting.


Hopefully you noticed two things: A seasonality to the data, for winter and summer. Also that bike rental counts are increasing in general. This may present a problem with using a linear regression model if the data is non-linear. Let's have a quick overview of pros and cons right now of Linear Regression:

Pros:

Simple to explain
Highly interpretable
Model training and prediction are fast
No tuning is required (excluding regularization)
Features don't need scaling
Can perform well with a small number of observations
Well-understood
Cons:

Assumes a linear relationship between the features and the response
Performance is (generally) not competitive with the best supervised learning methods due to high bias
Can't automatically learn feature interactions
We'll keep this in mind as we continue on. Maybe when we learn more algorithms we can come back to this with some new tools, for now we'll stick to Linear Regression.

What is the correlation between temp and count?

temp	count
temp	1.0000000	0.3944536
count	0.3944536	1.0000000
Let's explore the season data. Create a boxplot, with the y axis indicating count and the x axis begin a box for each season.


Notice what this says:

A line can't capture a non-linear relationship.
There are more rentals in winter than in spring
We know of these issues because of the growth of rental count, this isn't due to the actual season!

Feature Engineering
A lot of times you'll need to use domain knowledge and experience to engineer and create new features. Let's go ahead and engineer some new features from the datetime column.

Create an "hour" column that takes the hour from the datetime column. You'll probably need to apply some function to the entire datetime column and reassign it. Hint:

time.stamp <- bike$datetime[4]
format(time.stamp, "%H")
datetime	season	holiday	workingday	weather	temp	atemp	humidity	windspeed	casual	registered	count	hour
1	2011-01-01	1	0	0	1	9.84	14.395	81	0	3	13	16	00
2	2011-01-01 01:00:00	1	0	0	1	9.02	13.635	80	0	8	32	40	01
3	2011-01-01 02:00:00	1	0	0	1	9.02	13.635	80	0	5	27	32	02
4	2011-01-01 03:00:00	1	0	0	1	9.84	14.395	75	0	3	10	13	03
5	2011-01-01 04:00:00	1	0	0	1	9.84	14.395	75	0	0	1	1	04
6	2011-01-01 05:00:00	1	0	0	2	9.84	12.88	75	6.0032	0	1	1	05
Now create a scatterplot of count versus hour, with color scale based on temp. Only use bike data where workingday==1.

Optional Additions:

Now create the same plot for non working days:


You should have noticed that working days have peak activity during the morning (~8am) and right after work gets out (~5pm), with some lunchtime activity. While the non-work days have a steady rise and fall for the afternoon

Now let's continue by trying to build a model, we'll begin by just looking at a single feature.

Building the Model
Use lm() to build a model that predicts count based solely on the temp feature, name it temp.model

Get the summary of the temp.model

Call:
lm(formula = count ~ temp, data = bike)

Residuals:
    Min      1Q  Median      3Q     Max 
-293.32 -112.36  -33.36   78.98  741.44 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   6.0462     4.4394   1.362    0.173    
temp          9.1705     0.2048  44.783   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 166.5 on 10884 degrees of freedom
Multiple R-squared:  0.1556,	Adjusted R-squared:  0.1555 
F-statistic:  2006 on 1 and 10884 DF,  p-value: < 2.2e-16
You should have gotten 6.0462 as the intercept and 9.17 as the temp coeffecient. How can you interpret these values? Do some wikipedia research, re-read ISLR, or revisit the Linear Regression lecture notebook for more on this.

How many bike rentals would we predict if the temperature was 25 degrees Celsius? Calculate this two ways:

Using the values we just got above
Using the predict() function
You should get around 235.3 bikes.

1: 235.309724995272
Use sapply() and as.numeric to change the hour column to a column of numeric values.

Finally build a model that attempts to predict count based off of the following features. Figure out if theres a way to not have to pass/write all these variables into the lm() function. Hint: StackOverflow or Google may be quicker than the documentation.

season
holiday
workingday
weather
temp
humidity
windspeed
hour (factor)
Get the summary of the model

Call:
lm(formula = count ~ . - casual - registered - datetime - atemp, 
    data = bike)

Residuals:
    Min      1Q  Median      3Q     Max 
-324.61  -96.88  -31.01   55.27  688.83 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept)  46.91369    8.45147   5.551 2.91e-08 ***
season       21.70333    1.35409  16.028  < 2e-16 ***
holiday     -10.29914    8.79069  -1.172    0.241    
workingday   -0.71781    3.14463  -0.228    0.819    
weather      -3.20909    2.49731  -1.285    0.199    
temp          7.01953    0.19135  36.684  < 2e-16 ***
humidity     -2.21174    0.09083 -24.349  < 2e-16 ***
windspeed     0.20271    0.18639   1.088    0.277    
hour          7.61283    0.21688  35.102  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 147.8 on 10877 degrees of freedom
Multiple R-squared:  0.3344,	Adjusted R-squared:  0.3339 
F-statistic:   683 on 8 and 10877 DF,  p-value: < 2.2e-16
Did the model perform well on the training data? What do you think about using a Linear Model on this data?

You should have noticed that this sort of model doesn't work well given our seasonal and time series data. We need a model that can account for this type of trend.
