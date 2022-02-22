# Data Quality And Validation


## 0. Data quality introduction

Data quality describes the state of data that can be either “good” or “bad”. And we have the following dimensions to 
measure it:
- Accuracy
- Auditability
- Completeness
- Consistency
- Credibility
- Orderliness
- Timeliness
- Uniqueness
- Relevance
- Interpretability 

Data quality evaluation is a topic much more complex than the data validation.  In this Project, we will only focus on
data validation. For more information about data quality management, please check [data quality management](docs/data_quality_management.md)


## 1. What is data validation?

**Data Validation is an activity verifying whether a combination of values is a member of a set of acceptable combinations.**


The purpose of data validation is to ensure a certain level of quality of the final data. 


## 2 Data validation process
Let's start by understanding different steps in data validation process.

I did not find good literatures that define the different steps of how to do the data validation process. You can read
these two document [OECD_data_quality](docs/OECD_data_quality.pdf) and 
[Data validation by Essnet Validat Foundation](docs/methodology_for_data_validation_v1.0_rev-2016-06_final.pdf)

Below, I just illustrate how I do it in general.

1. Understand the raw data: collect documentation, metadata, run data profiling tools
2. Setup validation rules: Based on your understanding of the data, you can set up validation rules.
3. Detect anomalies:  Applying validation rules on the data to detect all rows that violate the validation rules.
4. Correct/Clean data: Imputation, drop rows, change values, etc.
5. Repeat 3,4 till no anomaly 

### 2.1 Understand your data

Before you code any data pipeline, just try to understand the input raw data as much as you can, find **documents, metadata**
that describes your data. 

For example, for a structure/semi-structure data set, you need to know :
- the number of columns, rows, the name of each column, the meaning of each column. 
- for numeric columns, you need to know the basic stats such as min, max, median, mean, standard deviation, etc. 
- for categorical columns, you need to know all the possible values, the value that has most count, etc.

If you don't have documents or metadata that provides you these information, you need to generate them by yourself. We call this data profiling.

#### Data Profiling

Data Profiling is the process of running analysis on source data to understand its structure and content. You can get 
following insights by doing data profiling on a new dataset:

- Structure Discovery: Number of columns and their names in the source data
- Content Discovery: Data types of the columns, Identify Nullable columns
- Cardinality of Data: Number of Distinct Values in each column
- Statistical Analysis: Min / Max / Mean / Std Dev of numerical columns
- Value Histograms: Frequency of values in low-cardinality columns

#### Why Data Profiling?
Data profiling is typically needed to address following points:
- Use data profiling before beginning to ingest data from a new source to discover if data is in suitable form — and 
   make a “go / no go” decision on the dataset.
- Identify and correct data quality issues in source data, even before starting to move it into target database.
- Reconcile vendor specification with real data
- Identify data quality issues that can be corrected by Extract-Transform-Load (ETL), while data is moved from source 
   to target. Data profiling can uncover if additional processing is needed before feeding data to pipeline.
- Help you to define validation rules

For data profiling, we advise you a tool called [pandas-profiling](https://pandas-profiling.github.io/pandas-profiling/docs/master/rtd/pages/introduction.html)
You can find an example in this [notebook](01.pandas_profiling/01_Census_income_profilling.ipynb)

### 2.2 Define data validation rules

The validation rule defines which properties a row must respect. During the validation process, we apply validation 
rules on the target data. If a rule fails, it implies that the data contains anomalies that we don't expect.

The detected anomalies can be legit data shifting, or an error. In case of data shifting, you need to adjust your 
data validation rule. If it's an error, you need to correct it or contact data provider to correct it.



#### 2.2.1 Types of data Validation rules

There are different ways to categorize data validation rules. In this project I used the following categorization:
- Generic validation rules: It does not require any domain knowledge to set up.
    1. Presence check(not null check): Check if a column (e.g. user_id) contains null value or not.
    2. Uniqueness Check(no duplicat check) : Check if a row value is unique in a dataset. Because, some data like 
                                 IDs or e-mail addresses are unique by nature. Duplicates are not allowed
    3. Type Check : A data type check confirms that the data entered has the correct data type. Numeric column 
                        can't have string value.
    4. Format Check : Many data types follow a certain predefined format. For example, date columns
                    must have a format like “YYYY-MM-DD”. Username must start with Capital letter followed by min
- domain specific validation rules:
  1. Range Check: A range check will verify whether input data falls within a predefined range. For example, 
                     A latitude value should be between -90 and 90,
  2. Consistency Check: It checks if values are logically consistent. For example, the delivery date is always after 
                      the shipping date. if age under 15, then marital status must be not married.
  3. Code list check: It checks if a field is selected from a valid list of values or follows certain 
                       formatting rules. For example, country column can only contain values from valid ISO country 
                       codes list.
  
### 2.3 Detect anomalies: Apply validation rules on data.

Once, you have defined the validation rules, you need to apply them on data. To do that you can 
- implement the validation rule by hand
- use a validation tool 

#### 2.3.1 Implement validation rule by hand 

This could work, if the project does not contain complexe data set. And it's a very time-consuming process and hard to
maintain.

### 2.3.2 Validation Tool evaluation metric:

- Declarative validation rule
- Rich built-in validation rule
- Easy to implement new validation rules
- Able to reuse existing validation rule set
- Provide a profiler to generate possible validation rules for a given dataset.
- Detailed validation report that indicates which validation rule failed and which row failed the validation rule


## Open source projects

- pandas profiling
- TDDA, pydqc, Bulwark, Engarde, Voluptous, Opulent Pandas, aws dedupe, and Great Expectations
- soda sql (https://github.com/sodadata/soda-sql)
- google's tensorflow datavalidation

## Commerciales solutions


## Common problems in semi-structure data

- unescaped commas in unquoted (comma-separated) values: e.g. some word, some word in a text column. the commas are not escaped 
    and will cause column parsing error. (Orderliness)
- an unspecified non-UTF-8 encoding: e.g. using iso-8859-1 ("latin-1" to its friends), or iso-8859-15 ("latin-9") 
- different null markers in different fields(columns), and some cases, different null markers in a single field(columns) (Orderliness)
- field names (column headers) that included spaces, apostrophes, dashes and a non-ASCII 
   non-alphanumeric character (Orderliness)
- multiple date formats, even within a single field. For example year with 4 digit, and 2 digit. (Orderliness)
