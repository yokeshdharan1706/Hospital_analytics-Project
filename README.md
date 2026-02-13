# 🏥 Hospital Operations Analytics Dashboard

An end-to-end **Hospital Analytics project** designed to monitor, analyze, and optimize hospital operations using **Python, MySQL, and Power BI**.  
This project simulates real-world healthcare data workflows — from data generation to executive-level dashboards.

---

## 📌 Project Objective

To provide hospital management with actionable insights on:
- Patient admissions & discharges
- Bed occupancy and utilization
- Doctor workload
- Procedure volumes
- Billing & insurance coverage
- Operational KPIs and trends


##  🧩Project Architecture

```text
Fake Data Generation (Python)
        ↓
CSV Files
        ↓
ETL & Data Modeling (MySQL)
        ↓
Fact & Dimension Tables
        ↓
SQL Views (KPIs Layer)
```


# Tools & Technologies Layer Tools
Data Generation	Python (Pandas, Faker)
Storage	MySQL 8.0
Data Modeling	Star Schema
Analytics	SQL (Views, Aggregations)
Visualization	Power BI
Refresh	Power BI Gateway (On-Prem MySQL)

## 🗂️Data Model (Star Schema)
Dimension Tables

dim_date

dim_patient

dim_doctor

dim_department

dim_branch

Fact Tables

fact_admissions

fact_bed_utilization

fact_procedures

fact_billing

## 📊 Key KPIs Implemented

Average Length of Stay (ALOS)

Bed Occupancy Rate

Admission vs Discharge Count

Emergency vs Scheduled Cases

Readmission Rate (30-Day)

Procedure Volume

Doctor Utilization %

Cost per Patient

Insurance vs Out-of-Pocket Billing

Patient Outcome Distribution

YoY Revenue Growth %

## 📈 Power BI Dashboard Pages
**1️⃣ Executive Summary**
Total Patients

Total Revenue

Average Length of Stay

YoY Growth %

**2️⃣ Admissions & Operations**

Admission trends

Emergency vs Elective cases

Department-wise admissions

**3️⃣ Doctor & Bed Utilization**
Doctor workload %

Bed occupancy rate

Department efficiency

**🔄 Automated Refresh**

On-prem MySQL connected via Power BI Gateway

Scheduled refresh:

Daily / Weekly

SQL Views used for optimized refresh performance


```text
**📁 Repository Structure**
hospital-analytics/
│
├── data/
│   ├── dim_patient.csv
│   ├── dim_doctor.csv
│   ├── fact_admissions.csv
│   └── ...
│
├── sql/
│   ├── table_creation.sql
│   ├── views.sql
│
├── powerbi/
│   └── hospital_dashboard.pbix
│
├── python/
│   └── data_generator.py
│
└── README.md
```

**🚀 How to Run the Project**

Generate fake data using Python

Load CSVs into MySQL

Create tables & views

Connect Power BI to MySQL

Build visuals using views

Configure Gateway for auto refresh


**Business Value**
Helps hospital leadership identify bottlenecks

Improves bed & doctor utilization

Enables financial transparency

Supports data-driven decision making



Yokesh Dharan
Data Analytics Professional
Skills: SQL | Python | Power BI | ETL | Data Modeling
        ↓
Power BI Dashboard
