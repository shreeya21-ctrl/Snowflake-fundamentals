USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

USE SCHEMA MYDB.MYSCHEMA;

CREATE OR REPLACE TABLE USER(
    ID INTEGER,
    NAME VARCHAR(50),
    LOCATION VARCHAR(50),
    EMAIL VARCHAR(50)
);

--create an storage intergration with s3 buckets and IAM role
CREATE OR REPLACE STORAGE INTEGRATION s3_int
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = 'S3'
    ENABLED = TRUE
    -- this is the IAM role (identity and access management)
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::249173798438:role/snowflakerole'
    STORAGE_ALLOWED_LOCATIONS = ('s3://first-snowflake1-bucket/');

DESCRIBE INTEGRATION s3_int;

--CREATE A FILE FORMAT
CREATE OR REPLACE FILE FORMAT MY_CSV_FORMAT
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    RECORD_DELIMITER = '\n'
    SKIP_HEADER = 1 ;


--CREATE AN EXTERNAL STAGE
CREATE OR REPLACE STAGE my_s3_stage
    STORAGE_INTEGRATION = s3_int
    URL = 's3://first-snowflake1-bucket/'
    FILE_FORMAT = my_csv_format;

LIST @my_s3_stage;

COPY INTO USER
FROM @my_s3_stage
FILE_FORMAT = my_csv_format;

SELECT * FROM USER;