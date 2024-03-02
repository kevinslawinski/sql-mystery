/*
=============================
SQL Murder Mystery
Derived from: https://github.com/NUKnightLab/sql-mysteries / https://mystery.knightlab.com
Credit goes to those noted on the KnightLab links above.
I just rebuilt the project in SQL Server so it can be utilized by someone learning T-SQL.
=============================

The SQL Murder Mystery is designed to be both a self-directed lesson to learn SQL concepts and commands and a fun game for experienced SQL users to solve an intriguing crime. 

Instructions:
1. Run the included init_SQLMurderMystery_schema.sql to build the database (you should not need to modify the script)
2. Run the included seed_SQLMurderMystery_Tables.sql file to insert data
		* Be patient, there is quite a bit of data - it should take ~3 minutes to complete in a decently spec'd environment
		* Tip: Look in the bottom right corner for a query execution timer
3. (optional) Build a Database Diagram for a view into how the tables relate to each other
4. Use your knowledge with SQL to determine whodunnit!

---------------
---- BEGIN ----
---------------

There's been a murder in SQL City!

A crime has taken place and the detective needs your help. 
The detective gave you the crime scene report, but you somehow lost it. 
You vaguely remember that the crime was a murder that occurred sometime on January 15, 2018 and that it took place in SQL City. 
Start by retrieving the corresponding crime scene report from the police department's database. 

*/
----------------------------------------------------------------
-- You can use the space below to write queries if you'd like --
----------------------------------------------------------------
USE SQLMurderMystery;







--------------------------------------------------------------------------
-- Think you know the answer? Run the below queries to check your work! --
--------------------------------------------------------------------------

USE SQLMurderMystery;
INSERT INTO Solution VALUES (1, 'suspect_name_here');
SELECT Value FROM Solution;
