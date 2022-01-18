# DataQualityAndValidation

In this Project, we will explore tools/libraries that can help us to do data validation and data quality checks

## 1. Steps in data quality evaluation and data validation

Quality evaluation is a topic much more complex than the data validation. So we will learn how to do data validation 
first.

### 1.1 Data validation process
I did not find good literatures that define the different steps of how to do the data validation process.
Below, I just illustrate how I do it in general.

1. Understand the raw data: 
2. 

#### 1.1.1 Understand your data

Before you code any data pipeline, just try to understand the input raw data as much as you can, find **documents, metadata**
that describes your data. 

For example, for a structure/semi-structure data set, you need to know :
- the number of columns, rows, the name of each column, the meaning of each column. 
- for numeric columns, you need to know the basic stats such as min, max, median, mean, standard deviation, etc. 
- for categorical columns, you need to know all the possible values, the value that has most count, etc.

If you don't have documents or metadata that provides you these information, you need to generate them by yourself. 

Here are some tools that you can use


## Types of Data Validation

There are many types of data validation. Most data validation procedures will perform one or more of these checks 
to ensure that the data is correct before storing it in the database. Common types of data validation checks include:

 
1. Data Type Check : A data type check confirms that the data entered has the correct data type. For example, a field 
     might only accept numeric data. If this is the case, then any data containing other characters such as letters or 
     special symbols should be rejected by the system.

 

2. Code Check : A code check ensures that a field is selected from a valid list of values or follows certain 
    formatting rules. For example, it is easier to verify that a postal code is valid by checking it against a list 
    of valid codes. The same concept can be applied to other items such as country codes and NAICS industry codes.

 

3. Range Check : A range check will verify whether input data falls within a predefined range. For example, 
   latitude and longitude are commonly used in geographic data. A latitude value should be between -90 and 90, 
    while a longitude value must be between -180 and 180. Any values out of this range are invalid.

 

4. Format Check : Many data types follow a certain predefined format. A common use case is date columns that are 
   stored in a fixed format like “YYYY-MM-DD” or “DD-MM-YYYY.” A data validation procedure that ensures dates 
   are in the proper format helps maintain consistency across data and through time.

 

5. Consistency Check : A consistency check is a type of logical check that confirms the data’s been entered in a 
   logically consistent way. An example is checking if the delivery date is after the shipping date for a parcel.

 

6. Uniqueness Check : Some data like IDs or e-mail addresses are unique by nature. A database should likely have 
   unique entries on these fields. A uniqueness check ensures that an item is not entered multiple times into a database.

 
## Open source projects

- pandas profiling
- TDDA, pydqc, Bulwark, Engarde, Voluptous, Opulent Pandas, mobydq, dvc, aws dedupe, datacleaner, and Great Expectations
- google's tensorflow datavalidation

## commercial solutions