----Healthcare Readmissions & Cost Analysis Project---

---------1.CREATE TABLES----------
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    county VARCHAR(50),
    diagnosis_group VARCHAR(50),
    high_risk_flag VARCHAR(5)
);
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    admit_date DATE,
    discharge_date DATE,
    readmitted_30_days VARCHAR(5),
    total_cost FLOAT,
    primary_dx VARCHAR(50)
);
CREATE TABLE follow_up (
    patient_id INT PRIMARY KEY,
    followup_7_days VARCHAR(5),
    followup_30_days VARCHAR(5),
    medication_adherence FLOAT
);

---------2.INSERT DATA---------
INSERT INTO patients VALUES
(1, 45, 'F', 'Fulton', 'SUD', 'Yes'),
(2, 62, 'M', 'DeKalb', 'SMI', 'Yes'),
(3, 29, 'F', 'Cobb', 'Maternal', 'No'),
(4, 50, 'M', 'Gwinnett', 'SUD', 'Yes'),
(5, 38, 'F', 'Fulton', 'SMI', 'No');

INSERT INTO admissions VALUES
(101, 1, '2025-01-01', '2025-01-05', 'Yes', 12000, 'Behavioral Health'),
(102, 2, '2025-01-03', '2025-01-07', 'No', 8000, 'Mental Health'),
(103, 3, '2025-01-10', '2025-01-12', 'No', 5000, 'Maternal'),
(104, 4, '2025-01-15', '2025-01-20', 'Yes', 15000, 'Substance Use'),
(105, 5, '2025-01-18', '2025-01-22', 'No', 7000, 'Mental Health');

INSERT INTO follow_up VALUES
(1, 'Yes', 'Yes', 0.80),
(2, 'No', 'Yes', 0.60),
(3, 'Yes', 'Yes', 0.90),
(4, 'No', 'No', 0.40),
(5, 'Yes', 'No', 0.70);

INSERT INTO patients VALUES
(1, 45, 'F', 'Fulton', 'SUD', 'Yes'),
(2, 62, 'M', 'DeKalb', 'SMI', 'Yes'),
(3, 29, 'F', 'Cobb', 'Maternal', 'No'),
(4, 50, 'M', 'Gwinnett', 'SUD', 'Yes'),
(5, 38, 'F', 'Fulton', 'SMI', 'No');

INSERT INTO admissions VALUES
(101, 1, '2025-01-01', '2025-01-05', 'Yes', 12000, 'Behavioral Health'),
(102, 2, '2025-01-03', '2025-01-07', 'No', 8000, 'Mental Health'),
(103, 3, '2025-01-10', '2025-01-12', 'No', 5000, 'Maternal'),
(104, 4, '2025-01-15', '2025-01-20', 'Yes', 15000, 'Substance Use'),
(105, 5, '2025-01-18', '2025-01-22', 'No', 7000, 'Mental Health');

INSERT INTO follow_up VALUES
(1, 'Yes', 'Yes', 0.80),
(2, 'No', 'Yes', 0.60),
(3, 'Yes', 'Yes', 0.90),
(4, 'No', 'No', 0.40),
(5, 'Yes', 'No', 0.70);

------------3.ANALYSIS-----------

---Readmission rate---
SELECT 
    readmitted_30_days,
    COUNT(*) AS total_patients
FROM admissions
GROUP BY readmitted_30_days;

---Follow up vs readmission---
SELECT 
    f.followup_7_days,
    AVG(
        CASE 
            WHEN a.readmitted_30_days = 'Yes' THEN 1 
            ELSE 0 
        END
    ) AS readmission_rate
FROM admissions a
JOIN follow_up f
ON a.patient_id = f.patient_id
GROUP BY f.followup_7_days;

---Cost by risk group---
SELECT 
    p.high_risk_flag,
    AVG(a.total_cost) AS avg_cost
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id
GROUP BY p.high_risk_flag;