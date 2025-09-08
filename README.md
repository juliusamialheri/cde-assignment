## CDE Linux Git Assignment
This repository contains my solutions for the CoreDataEngineers assignment focusing on Linux, Git workflows.

# What I Built
1. ETL Pipeline Script
Built a bash script that downloads CSV data, cleans it up, and moves it through three folders: raw → Transformed → Gold. The script will:
	- Sets environment variables for file paths and the CSV data source URL.
	- Downloads a CSV file from a remote source and saves it to a raw data folder.
	- Uses awk to rename columns and filter the CSV, saving the result to a transformed folder.
	- Moves the transformed file to a gold folder for final storage.
	- Orchestrates the ETL process by running extract, transform, and load scripts in sequence.

2. Automated Scheduling
Set up the ETL script to run automatically at midnight every day using cron jobs. Used Task Scheduler to implement in Windows

3. File Management Tool
Created a script that finds all CSV and JSON files and moves them into one json_and_CSV folder.

4. Parch & Posey Database Loading and Analysis
The main challenge - analyzing competitor data by loading CSV files into PostgreSQL and writing SQL queries to answer business questions.


Database Setup
I'm using PostgreSQL with Visual Studio Code. The database is called posey and contains tables for accounts, orders, sales reps, and regions.

Connection details in .env:

DB_HOST=localhost
DB_PORT=5432
DB_NAME=posey
DB_USER=postgres

The Four Business Questions I Solved
The queries to answer business questions about orders, accounts, and sales reps, such as filtering orders by quantity, searching for company names, and joining tables for region/account analysis.
Question 1: Find order IDs where gloss or poster quantities exceed 4000 units

	* Simple OR condition filtering high-volume orders

Question 2: Find orders with zero standard quantity but high gloss/poster quantities

	* Identifies unusual ordering patterns that might indicate specific customer needs

Question 3: Find companies starting with C/W with contacts containing 'ana' but not 'eana'

	* Complex string matching for targeted marketing campaigns

Question 4: Show regions, sales reps, and their accounts sorted alphabetically

	* Multi-table join to understand territorial organization


Git Workflow Used
	* Created feature branch: feature/dev
	* Made commits for each major component
	* Used pull request to merge into master
	* No direct pushes to master branch

Key Technical Decisions
	1. Used .env file for database credentials instead of hardcoding
	2. Added checks to confirm files are saved in correct folders
	3. Separated ETL, database loading, and file management into different scripts

This assignment has taught me how data engineering teams actually work - combining Linux commands, database management, and version control into real workflows that businesses depend on.

# ETL process diagram
<img width="641" height="326" alt="etl drawio" src="https://github.com/user-attachments/assets/53f17285-47d8-4210-9ee4-29913cada6b8" />
