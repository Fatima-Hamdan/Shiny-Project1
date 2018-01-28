
library(shiny)
library(shinydashboard)
library(googleVis)
library(ggvis)
library(DT)
library(dplyr)

# import the data as csv file 
ManhattanSales <- read.csv("rollingsales_Manhattan2017.csv",stringsAsFactors = FALSE)

# lowercase column names
names(ManhattanSales)<- tolower(names(ManhattanSales))

#impute the missing values in Sale_Price
impute = function(x){ 
  if ((x =="") | (x==" $-   "))
    return(NA)
  else
    return(x)
}
ManhattanSales$sale_price = sapply(ManhattanSales$sale_price,impute)

#sale_price type from char to numeric 
ManhattanSales$sale_price = sapply(ManhattanSales$sale_price, as.numeric, na.pass)

#change date column format from char to date format
ManhattanSales <- ManhattanSales %>% mutate(sale_date = as.Date(sale_date, "%m/%d/%Y"))

#add a column for the month
ManhattanSales<- ManhattanSales %>% mutate(month=as.numeric(format(sale_date, "%m")))

# Location Names(distinct)
LocationName_Choices = unique(ManhattanSales$location_name)
LocationName_Choices = c("ANY LOCATION",LocationName_Choices)

#Building Class Category (distinct)
BuildingClassCategory_Choices = unique(ManhattanSales$building_class_category)
BuildingClassCategory_Choices = c("ANY TYPE OF BUILDING",BuildingClassCategory_Choices)

#min of Prices
minPrice = min((ManhattanSales$sale_price),na.rm= TRUE)
# max of Prices
maxPrice= max((ManhattanSales$sale_price),na.rm= TRUE)


# Changed zeros to NA's in Year built 
imputeZero = function(x){ 
  if (x ==0) 
    return(NA)
  else
    return(x)
}
ManhattanSales$year_built = sapply(ManhattanSales$year_built,imputeZero)
