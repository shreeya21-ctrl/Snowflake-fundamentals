USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

USE SCHEMA MYDB.MYSCHEMA;


CREATE OR REPLACE TABLE source_table (
    ID INT,
    NAME VARCHAR,
    CREATED_DATE DATE
);

INSERT INTO source_table VALUES
    (1,'Chaos', '2023-11-02'),
    (2,'Genius', '2023-11-02');


--standard stream
CREATE OR REPLACE STREAM STAND_STREAM ON TABLE source_table;

SELECT * FROM source_table;

SELECT * FROM STAND_STREAM;

INSERT INTO SOURCE_TABLE VALUES 
    (3, 'Johny', '2023-11-02');

DELETE FROM SOURCE_TABLE 
WHERE ID = 2;

UPDATE SOURCE_TABLE SET NAME = 'Elon' WHERE ID = 1;


--append only stream
CREATE OR REPLACE TABLE source_table2 (
    ID INT,
    NAME VARCHAR,
    CREATED_DATE DATE
);

INSERT INTO source_table2 VALUES
    (1,'Chaos', '2023-11-02'),
    (2,'Genius', '2023-11-02');
    
CREATE OR REPLACE STREAM append_only_stream ON TABLE source_table2 APPEND_ONLY = TRUE;

SELECT * FROM append_only_stream;

INSERT INTO source_table2 VALUES (3, 'Johny', '2023-11-02');

SELECT * FROM source_table2;

UPDATE SOURCE_TABLE2 SET NAME = 'Elon' WHERE ID = 1;

--- how do we use this in ETL process
CREATE OR REPLACE TABLE Target_table(
    ID INT,
    Name VARCHAR,
    Created_Date DATE
);

INSERT INTO TARGET_TABLE 
SELECT ID, Name, Created_Date FROM APPEND_ONLY_STREAM;

SELECT * FROM TARGET_TABLE;


INSERT INTO source_table2 VALUES
    (4, 'Rock', '2023-11-02');

--insert only stream
CREATE EXTERNAL TABLE ext_table
LOCATION = @MY_AWS_STAGE
FILE_FORMAT = my_format;

CREATE STREAM my_ext_stream 
ON EXTERNAL Table ext_table
INSERT_ONLY = TRUE;