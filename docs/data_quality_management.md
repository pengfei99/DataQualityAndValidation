# Data quality

In this document, I will explain how to define data quality: attributes, measures, and metrics?

## 1 What is data quality? 

Data quality is the state of data, which is tightly connected with its ability (or inability) to solve business tasks.
The state of data can be either “good” or “bad”, depending on to what extent data corresponds to the following attributes:
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

### 1.1 Accuracy
- Definition: Accuracy refers to the correctness of data, that is, whether the recorded value is in conformity with the 
actual value in reality, with respect to its intended use.
- Good example: You have a user named “John Doe”, and in the CRM database record is also “John Doe”.
- Bad example: You have a user named “John Doe”, and in the CRM database record is also “Jane Doe”.
- Measurement Metric: The ratio/percentage of the error data.

### 1.2  Auditability
- Definition: Auditability indicates that whether the user can trace all modifications of a dataset (from creation, 
 through modification/transformation, till deletion).
- Good example: Someone changes the birthdate of user “John Doe”, we know who did the change, when the change has been made, and what lines are changed.
- Bad example: Someone changes the birthdate of user “John Doe”, it’s impossible to know who change it.
- Measurement Metric: The ratio/percentage of the missing metadata that describes the data modification process (include creation and deletion).

### 1.3  Completeness
- Definition: Completeness indicates that whether the record has all required values. Note in some cases the null 
  value makes sense and should not consider as incomplete data. For example, some weather station does not have snow 
  depth measurement equipment, so they use null in the “snow_depth” column to indicate that. Because put “value 0” is miss leading.  
- Good example: All rows of the column birthdate of user table have value.
- Bad example: The birthdate of user “John Doe” is unknown, because the cell is null.
- Measurement Metric: The number of missing data.


### 1.4  Consistency
- Definition: Consistency indicates that whether there are contradictions inside your data set.  
- Good example: All user age values of user “John Doe” from all tables are the same.
- Bad example: The age of user “John Doe” in the marketing table is different from the table of CRM.
- Measurement Metric: The number of inconsistencies.

### 1.5  Credibility
- Definition: Credibility indicates the trustworthiness of the source as well as its content
- Good example: We know who is the data provider, and how the data is constructed.
- Bad example: We have no idea who produced the data, and how the data is constructed.
- Measurement Metric: The ratio/percentage of the missing metadata that describes the data provider and how data is constructed.

### 1.6 Orderliness/Validity
- Definition: Orderliness indicates whether the ingested data set respected the required format, structure, and schema.
- Good example: Data governance defines that date must respect ISO 8601. All the date values inside ingested data respect ISO 8601
- Bad example: The date values of the CRM database do not respect ISO 8601.
- Measurement Metric: The ratio/percentage of the data that does not respect the defined format, structure, and schema.

### 1.7 Timeliness
- Definition: Timeliness indicates that the recorded value is up-to-date for the task at hand.
- Good example: The marketing team wants to send a mail to users on their registered address. All users’ address is 
  up-to-date at the time of sending emails. All users receive the mail.
- Bad example: Some addresses of users are out-of-date at the time of sending emails. Some users did not receive the mail.
- Measurement Metric: Number of records that are out-of-date.

### 1.8 Uniqueness
- Definition: Uniqueness indicates that one record with specific details only appears once in the database.
- Good example: We only have one record for the user’s name, address, and birthdate.
- Bad example: We have multiple duplicated records for the user’s name, address, and birthdate.
- Measurement Metric: Number of duplicated data and how many times the data has been duplicated.

### 1.9 Relevance
- Definition: Relevance measures if data satisfait the purpose of the data collection that can help data scientist to solve the problem.
- Good example: Data can answer all the requirement of the data scientist
- Bad example: Data can not answer the requirement of the data scientist
- Measurement Metric: The number of user complaints divides all users. This can be objective, but still a good indicator

### 1.10 Interpretability 
- Definition: Interpretability reflects the ease with which users may understand and properly use and analyse
the data. The adequacy of the definitions of concepts, target populations, variables and terminology
underlying the data, and information describing the limitations of the data, if any, largely determines
the degree of interpretability
- Good example: Self-explanatory column name, categorical values, details description of each column (e.g. null value, terminology of distinct values)
- Bad example: Incomprehensible column name, categorical value, no description on columns.
- Measurement Metric: The number of user complaints divides all users. This can be objective, but still a good indicator


## 2 Common data quality metric
- The ratio of data to errors: monitors the number of known data errors compared to the entire data set. 
  
- The number of empty values: counts the times you have an empty field within a data set.
   
- Data time-to-value: evaluates how long it takes you to gain insights from a data set. There are other factors 
  influencing it, yet the quality is one of the main reasons this time can increase.
   
- Data transformation error rate: this metric tracks how often a data transformation operation fails.
   
- Data storage costs: when your storage costs go up while the amount of data you use remains the same, or worse, 
  decreases, it might mean that a significant part of the data stored has a quality to low to be used.

## 3. Data quality management: process stages described
   
### 3.1 Define data quality thresholds
The goal of ensuring data quality for an enterprise is to use these data to make good decisions. And these decisions 
will help the enterprise to reduce expanse or make more money on certain products or service. So we can consider data 
quality controls as an investment, and the money we make via these data as an income. If income is greater than 
investment then it's a good business. 

More often a company does not need 100% perfect data quality (e.g. 100% consistent, 100 complete, etc.), because 
it will cost too much to achieve that, and the gain is not that significant. As a result, the job of a data quality 
manager is to identify the perfect data quality thresholds that make data good enough to make decisions and cost less. 
And the quality thresholds may be different for different apartment due to the different usage of the data.

For example, you have a table customers which contains columns such as: 
- full_name
- date_of_birth
- sex
- address
- phone_num
- email

For the marketing team the **Accuracy,Completeness,Timeliness** of full_name, address, phone, email must be up to 95%, 
because this information was essential to reach the customer. The **Orderliness,  Uniqueness** of address, phone, email 
must be up to 75%. Because even the address format is not standard or unique, the customer can still receive the mails.

For the `date_of_birth` column, which is less important, we can ignore the **Accuracy,Completeness,Timeliness**. All 
we need to ensure is that the format of date is valid (comply with the orderliness attribute)

So you can notice, the granularity of a data quality control can go down to the columns of a table, for each column 
you can have a specific thresholds. You can set up coefficient for each column to calculate the overall thresholds 
of the table, then of the whole dataset.

### 3.2  Define data quality measurement rules

Now, let's talk how to measure if the data meets these thresholds or not? For that, you should set data quality 
measurement rules. Note `data quality measurement rules is very similar to data validation rules, because data 
validation is a sub domain of data quality measurement`. 

With the above defined thresholds, we can declare following rules :

- Customer address must not be N/A (to check completeness).
- Customer address must include a zip code and country/state name (to check orderliness).
- Customer's letters have been returned (to check accuracy)
- Customer email must consist @ (to check orderliness).
- Only first letters in customer name, middle name (if any) and surname must be capitalized (to check orderliness).
- Date of birth must be a valid date that falls into the interval from 01/01/1900 to 01/01/2010.

Accuracy thresholds = confirmation/customer * 100%

### 3.3 Assess the quality of data

In this step, we test the data by using the data quality measurement rules that we defined in the previous step. 

For example, suppose we have 100 rows in the data set.
- for rule 1, we detect there is no rows that contains null value on column `address`. Note almost all data manipulation 
  framework can detect null values. for example, in spark we can create a new column to indicate it's null or 
  not (df.withColumn("type_is_null", df.type.isNull())), then we count the number of null rows. This means column **address has 100 as completeness score** 
- for rule2, we detect there are 26 rows that does not has zip code, country, or state name. This means column **address has 74 as orderliness score**
- for rule3, we detect 16 letters that the company send to customer have been returned, means 16 rows have bad address. 
  This means **address has 84 as accuracy score**. Note this may also tell us the **Timeliness** of the data if we compare 
  the result with previous letter return status. For example, if previous return letter number is 10. It means the 6 
  new return letter is due to address update of the customer.   

You can notice, to test the above rules, for some of them we can use data analytics to achieve them (e.g. check if 
email address fit certain formats, has null value or not). But for some of them, we need to contact customer to achieve 
it (such as sending letter to verify address.). That's why data validation is a subdomain of data quality control. 
Because it can not answer all the questions. 

After applying all rules, you will have scores for all the properties that we want to ensure. For example, for column 

address:
- Accuracy: 84 (below thresholds)
- Completeness: 100 (Above)
- Orderliness: 74 (below). Orderliness is worse than accuracy, because the bad address format can still be read by a 
   human, then derived successfully to the customer.
- Timeliness: 94 (Above)
- ETc.

Now we have the metric of data quality, we need to handle the data quality issues

### 3.4 Resolve data quality issues

At this stage, we need to identify the root cause of the data quality issues, and find the most efficient way to eliminate them. 

For example, for orderliness of the customer address, because the address is entered manually by different employee, 
and everyone has their own way to write an address. 

Short term solution: we need to ask data engineer to clean the column by converting all address to one single standard format.
Long term solution: we need to introduce clear standards for customer address manual data entries, as well as data 
quality-related key performance indicators for the employees responsible for keying data into the database. We can also
set a validation rule in the system that will not accept an address unless it complies with the format or range.


### 3.5 Monitor and control data quality continuously

The data and business requirements evolves every day, so the data quality management system needs to evolve to adapt 
new changes. For example, one day your company may want to do user profiling, so your custom table will have new 
columns that describe the custom demographic and hobbies. You need to add new data quality thresholds and rules to 
make sure the new columns also satisfy your data quality requirements.

As a result data quality control is not a one-time effort, rather a non-stop process. **You need to regularly review 
data quality policies and rules with the intent to continuously improve them**.


## 4. Best practices of data quality management

Below are some best practices that can help you improve the quality of your data.

### 4.1 Integrate data quality management

Integrating data quality management into data processing pipeline is hard and time consuming. It requires multiple serious steps:

- Base on enterprise data governance strategy and business requirements, design appropriate data quality strategy (what need to be done, who will do it, etc.).
- Define roles (e.g. rights, accountability, kpi, rewards, etc) for everyone who works with data .
- Setting up a data quality management Standard operation procedure (check section 3).
- Make data quality visible (e.g. report, dashboard, etc.)

### 4.2 Automat as much as possible

Poor data quality is often introduced by human error. For example manual data entries (by employees, by customers or 
even by multiple users) is one of the principal reason. 
Managing thousands of data quality control (validation) rules is quite hard too. If a process can be automated, implement it.

### 4.3 Preventing issues, not just fixing them

We often say "Garbage in, Garbage out". So instead of taking time to clean data, you can set up rules to prevent 
low quality data enters your data platform. For example, you can create null value detection or duplicate detection 
rules. This rule can help you detect anomalies inside a dataset before it enters your data platform.

### 4.4 Taking care of both master and metadata

Master data can help you to build a common reference (e.g. standard currency code, product catalog, etc) that every 
can rely on. This can reduce term or format mismatch, thus improves orderliness of data. 

Metadata can help you identify and find data and its properties easily. For example, data time stamp can help you 
establish data versions, thus improves timeliness of data. Data lineage can help you identify the upstream and 
downstream of a dataset. It can help you to improve integrity and consistency.  
