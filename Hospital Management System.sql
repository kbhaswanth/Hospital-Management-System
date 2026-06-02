--- TABLE 1 
Create Table IF NOT EXISTS Department 
(
	dept_Id Int Primary Key,
	dept_Name Varchar(100)
);

select * from Department;

--- TABLE 2
Create Table IF NOT EXISTS Room
(
    room_No Int Primary Key,
	dept_Id Int,
	room_Type Varchar(100
	)

);

SELECT * FROM Room;

--- TABLE 3

Create Table Doctor 
(
	doct_Id Int Primary Key,
	dept_Id Int,
	FName Varchar(100),
	LName Varchar(100),
	Gender CHAR,
	contact_No Varchar(100),
	surgeon_Type Varchar(100),
	office_No Int,
	Foreign Key (dept_Id) References Department(dept_Id),
	Foreign Key (office_No) References Room(room_No)
);

SELECT * FROM Doctor;

--- TABLE 4

Create Table Nurse 
(
	nurse_Id Int Primary Key,
	dept_Id Int,
	FName Varchar(100),
	LName Varchar(100),
	Gender Char,
	conatct_No Varchar(100),
	Foreign Key (dept_Id) References Department(dept_Id)
);

SELECT * FROM Nurse;

--- TABLE 5

Create Table Helpers 
(
	helper_Id Int Primary Key,
	dept_Id Int,
	FName Varchar(100),
	LName Varchar(100),
	Gender Char,
	contact_No Varchar(100),
	Foreign Key (dept_Id) References Department(dept_Id)
);

SELECT * FROM Helpers;

--- TABLE 6

Create Table Ward 
(
	ward_No Int Primary Key,
	ward_Name Varchar(100),
	dept_Id Int,
	Foreign Key (dept_Id) References Department(dept_Id)
);

SELECT * FROM Ward;


--- TABLE 7

Create Table Bed 
(
	bed_No Int Primary Key,
	ward_No Int,
	Foreign Key (ward_No) References Ward(ward_No)
);

SELECT * FROM Bed;


--- TABLE 8

Create Table Patients 
(
	patient_Id Int Primary Key,
	FName Varchar(100),
	LName Varchar(100),
	Gender Char,
	Date_Of_Birth Date,
	contact_No Varchar(100),
	pt_Address Varchar(100)
);


SELECT * FROM Patients;

--- TABLE 9

Create Table BedRecords 
(
	admission_Id Int Primary Key,
	bed_No Int,
	patient_Id Int,
	nurse_Id Int,
	helper_Id Int,
	admission_Date Date,
	discharge_Date Date,
	amount Int,
	mode_of_payment Varchar(50),
	Foreign Key (bed_No) References Bed(bed_No),
	Foreign Key (patient_Id) References Patients(patient_Id), 
	Foreign Key (nurse_Id) References Nurse(nurse_Id),
	Foreign Key (helper_Id) References Helpers(helper_Id)
);

SELECT * FROM BedRecords;

--- TABLE 10

Create Table RoomRecords 
(
	admisson_ID Int Primary Key,
	room_no Int,
	patient_Id Int,
	nurse_Id Int,
	helper_Id Int,
	admission_Date Date,
	discharge_Date Date,
	amount Int,
	mode_of_payment Varchar(50),
	Foreign Key (room_no) References Room(room_No),
	Foreign Key (patient_Id) References Patients(patient_Id),
	Foreign Key (nurse_Id) References Nurse(nurse_Id),
	Foreign Key (helper_Id) References Helpers(helper_Id)
);


SELECT * FROM RoomRecords;

--- TABLE 11

Create Table Appointment 
(
	appoIntment_Id Int Primary Key,
	patient_Id Int,
	doct_Id Int,
	reason Varchar(100),
	appointment_Date Date,
	payment_amount Int,
	mode_of_payment Varchar(100),
	mode_of_appointment Varchar(100),
	appointment_status Varchar(100),
	Foreign Key (patient_Id) References Patients(patient_Id),
	Foreign Key (doct_Id) References Doctor(doct_Id)
);

SELECT * FROM Appointme


---EDA (Exploratory Data Analysis)

--- Total Patients

SELECT * FROM Patients;
SELECT COUNT(*) AS Total_Patients
FROM Patients;
--- Total Patients are 1500.

--- Total Doctors

SELECT * FROM Doctor;

SELECT COUNT(*) AS Total_Doc
FROM Doctor;

---- Total Doctors are 400.
--- Total Appointments 
SELECT COUNT(*) AS Total_Appointments
FROM Appointment;

--- Total Beds 
SELECT COUNT(*) AS Total_Beds
FROM Bed;


--- Gender Distribution of patients.
SELECT gender,COUNT(*) AS Total_Patients
FROM patients
GROUP BY gender;
--- Male Patients is 710.
--- Female Patients is 790.


--- Total SurgeryRecord.
SELECT COUNT(*) AS Total_SurgeryRecord
FROM SurgeryRecord;

--- Gender Distribution of Doctors.
SELECT gender,COUNT(*) AS Total_Doctors
FROM Doctor
GROUP BY gender;

-- Total Male Doctors are 261.
-- Total Female Doctors are 139.

--- Most Busy Doctor.

SELECT 
      D.fname || ' ' || D.lname AS Doctor_Name,
	  Count(A.Appointment_id) AS Total_Appointments
FROM Appointment A
JOIN Doctor D
ON A.doct_id = D.doct_id
GROUP BY D.fname,D.lname
ORDER BY Total_Appointments DESC
LIMIT 1;

--- Top Most busy Doctor is Dr. Raza Hasnain.

---- Top 5 Busy Doctors.
SELECT 
      D.fname || ' ' || D.lname AS Doctor_Name,
	  Count(A.Appointment_id) AS Total_Appointments
FROM Appointment A
JOIN Doctor D
ON A.doct_id = D.doct_id
GROUP BY D.fname,D.lname
ORDER BY Total_Appointments DESC
LIMIT 5;

-- These are the Top 5 Busy Doctors
1.Dr. Raza Hasnain
2.Dr. Waqas Javed
3.Dr. Muhammad Imran
4.Dr. Najeeb Basir
5.Dr. Tahir Hamid

--- Most Common Surgery Type.

select * from SurgeryRecord;

SELECT surgery_type,
COUNT(*) AS Total_Surgeries
FROM SurgeryRecord
GROUP BY surgery_type
ORDER BY Total_Surgeries DESC;

--- Revenue Generated From Appointments.

SELECT 
     '₹' ||
	 TO_CHAR(
     SUM(payment_amount),
	 '99,99,99,999'
	 )AS Total_Revenue
	 FROM Appointment;


--- The Total Revenue Generated From Appointments is ₹16,63,354.

--- Revenue Generated From BedRecords.

SELECT 
      '₹' ||
	  TO_CHAR(
	  SUM(amount),
	  '99,99,99,999'
	  ) AS Total_Revenu_BedRecords
FROM BedRecords;

--- The Total Revenue Generated From BedRecords is ₹ 3,60,61,054.

--- Revenue Generated From RoomRecords.

SELECT 
     '₹' || 
	 TO_CHAR(
     SUM(amount),
	 '99,99,99,999'
	 ) AS Total_RoomRecords_Revenu
FROM RoomRecords;

--- The Total Revenue Generated From RoomRecords is ₹ 7,20,63,923.

--- Total Hospital Revenue.

SELECT 
     '₹' ||
	 TO_CHAR(
	 (
      (SELECT COALESCE(SUM(payment_amount),0)
	  FROM Appointment)
	  +
	  (SELECT COALESCE(SUM(amount),0)
	  FROM RoomRecords)
	  +
	  (SELECT COALESCE(SUM(amount),0)
	  FROM BedRecords)
	 ),
	 '99,99,99,999'

	 ) AS Total_Hospital_Revenue;
    
--- Total Hospital Revenue is ₹ 10,97,88,331.

--- Department With Highest Appointments.

SELECT 
     DP.dept_name,
	 COUNT(A.Appointment_id) AS Total_Appointments
FROM Appointment A
JOIN Doctor D
ON A.doct_id = D.doct_id
JOIN Department DP
ON D.dept_id = DP.dept_id
GROUP BY DP.dept_name
ORDER BY Total_Appointments DESC;

--- Department With Highest Appointments
1.General Medicine = 505
2.Cardiology = 164
3.Neurology = 114
4.Pulmonology = 110
5.Endocrinology = 107

--- Average Patient Stay.

select * from BedRecords;

SELECT
    AVG(discharge_Date - admission_Date)
    AS Avg_Stay_Days

FROM BedRecords

WHERE discharge_Date IS NOT NULL;


---- Monthly Revenue Trend.
SELECT 
     EXTRACT(MONTH FROM admission_Date) AS Month_No,
	 SUM(amount) AS Revenue ) 
FROM RoomRecords
GROUP BY EXTRACT (MONTH FROM admission_Date)
ORDER BY Month_No;


SELECT
    TO_CHAR(admission_Date, 'Month') AS Month_Name,

    '₹ ' ||
    TO_CHAR(
        SUM(amount),
        '99,99,99,999'
    ) AS Revenue_INR

FROM RoomRecords

GROUP BY
    TO_CHAR(admission_Date, 'Month'),
    EXTRACT(MONTH FROM admission_Date)

ORDER BY
    EXTRACT(MONTH FROM admission_Date);

--- Payment Method Analysis.
select * from Appointment;

select mode_of_payment,
COUNT(*) AS Usage_Count
FROM Appointment
GROUP BY mode_of_payment
ORDER BY Usage_Count DESC;

--- Patients With Most Visits.

select 
      P.fname || ' ' || P.lname AS Patient_Name,
	  COUNT(MR.patient_id) AS Total_Visits
FROM MedicalRecord MR
JOIN patients P
ON MR.patient_id = P.patient_id
GROUP BY P.fname,P.lname
ORDER BY Total_Visits DESC
LIMIT 5;

---- Doctor Surgery Performance.

select 
      D.fname || ' ' || D.lname AS Doctor_Name,
	  COUNT(SR.surgery_id) AS Total_Surgeries
FROM SurgeryRecord SR
JOIN Doctor D
ON SR.surgeon_id = D.doct_id
GROUP BY D.fname,D.lname
ORDER BY Total_Surgeries DESC;


----  Peak Appointment Day.
SELECT appointment_date,
COUNT(*) AS Total_Appointments
FROM Appointment
GROUP BY appointment_date
ORDER BY Total_Appointments DESC;


--- Peak Appointments on Weekdays.
SELECT
    TO_CHAR(appointment_Date, 'Day') AS Weekday,

    COUNT(appointment_Id) AS Total_Appointments

FROM Appointment

GROUP BY
    TO_CHAR(appointment_Date, 'Day'),
    EXTRACT(DOW FROM appointment_Date)

ORDER BY Total_Appointments DESC;

--- Peak Appointments on Month.

SELECT
    TO_CHAR(appointment_Date, 'Month') AS Month_Name,

    COUNT(appoIntment_Id) AS Total_Appointments

FROM Appointment

GROUP BY
    TO_CHAR(appointment_Date, 'Month'),
    EXTRACT(MONTH FROM appointment_Date)

ORDER BY
    EXTRACT(MONTH FROM appointment_Date);

--- Peak Appointments on Years.

SELECT
      TO_CHAR(appointment_Date,'YYYY') AS Years,
	  COUNT(appointment_id) AS Total_Appointments
FROM Appointment
GROUP BY 
        TO_CHAR(appointment_Date,'YYYY'),
		EXTRACT(Year FROM appointment_Date)
ORDER BY EXTRACT(Year FROm appointment_Date);

----  Advance SQL 

--- Q1. List patients with their appointment doctor and reason.

SELECT
     P.fname || ' ' || P.lname AS Patient_Name,
	 D.fname || ' ' || D.lname AS Doctor_Name,
	 A.reason
FROM Appointment A
JOIN patients P
ON A.patient_id = P.patient_id
JOIN Doctor D
ON A.doct_id = D.doct_id;

-- Q2.Show nurses who have assisted in bed admissions with patient names.

SELECT
      N.fname || ' ' || N.lname AS Nurse_Name,
	  P.fname || ' ' || P.lname AS Patient_Name,
	  BR.admission_date
FROM BedRecords BR
JOIN nurse N
ON BR.nurse_id = N.nurse_id
JOIN patients P
ON P.patient_id = BR.patient_id;


-- Q3.List rooms used for surgeries, the surgeon, and the surgery type.
SELECT 
      D.fname || '' || D.lname AS Surgeon_Name,
	  R.room_no,
	  S.surgery_type
FROM SurgeryRecord S
JOIN Doctor D
ON S.surgeon_id = D.doct_id
JOIN room R
ON S.room_no=R.room_no;


select * from SurgeryRecord;

Select * from room;

select * from Doctor;


--- Q4.List each department with the number of doctors assigned to it.

SELECT 
      Dept.dept_name,
	  COUNT(D.dept_id) AS Total_Count
FROM Department Dept
JOIN Doctor D
ON Dept.dept_id = D.dept_id
GROUP BY Dept.dept_name
ORDER BY Total_Count DESC;


-- Q5.Show patients who had an appointment and were admitted to a bed.

SELECT 
     P.fname || '' || P.lname AS Patient_Name,
	 A.appointment_id,
	 BR.bed_no
FROM patients P
JOIN Appointment A
ON A.patient_id = P.patient_id
JOIN BedRecords BR
ON P.patient_id = BR.patient_id
JOIN Bed B
ON BR.bed_no = B.bed_no;

select * from patients;
select * from Appointment;
select * from BedRecords;
	 
select * from Department;
select * from Doctor;

-- Q6. We have new patient for Cardiology Ward And he/she wants a bed on a specific day. We want to find that which beds are empty in that ward on that particular day.
select b.bed_no
from Bed b
join Ward w
on b.ward_no = w.ward_no
join Department D
on w.dept_id = D.dept_id
WHERE D.dept_name = 'Cardiology'
AND w.ward_no = 502
AND b.bed_no Not in(
    select br.bed_no
    from BedRecords br
    where '2025-05-09' between br.admission_date AND br.discharge_date
	);



select * from Bed;
select * from Ward;
select * from Department;
select * from BedRecords;

-- Q7.There is a new virus in city And hospital is expecting more patients then regular day. Mnagement wants to see if they can manage those with current staff or not. They want to check upcoming appointments for each department on 4 June 2025.
SELECT 
      Dep.dept_name,
	  COUNT(A.appointment_id) AS Total_Appointments
FROM Appointment A
JOIN Doctor D
ON A.doct_id = D.doct_id
JOIN Department Dep
ON D.dept_id = Dep.dept_id
WHERE A.appointment_date = '2025-06-04'
GROUP BY Dep.dept_name
ORDER BY Total_Appointments DESC;

-- Q8.A doctor is asking for a salary raise due to extra work in previous month. verify if he/she deserves a raise.
select 
      D.fname || '' || D.lname AS Doctor_Name,

	  (select COUNT(*)
	  FROM Appointment A
	  WHERE A.doct_id = D.doct_id
	  AND A.appointment_Date Between '2025-05-01' AND '2025-05-30') AS Total_Appointments,

	  (select COUNT(*)
	  FROM MedicalRecord M
	  WHERE M.doct_id = D.doct_id
	  AND M.visit_Date Between '2025-05-01' AND '2025-05-30') AS Total_Visits,

	  (select COUNT(*)
	  FROM SurgeryRecord S
	  WHERE S.surgeon_id = D.doct_id
	  AND S.surgery_Date Between '2025-05-01' AND '2025-05-30') AS Total_Surgeries,

	  (select COUNT(*)
	  FROM staffShift SS
	  WHERE SS.doct_id = D.doct_id
	  AND SS.shift_Date Between '2025-05-01' AND '2025-05-30') AS Totai_Shifts
FROM Doctor D
WHERE D.doct_id = 1002;


-- Q9.The hospital is analyzing its daily revenue and wants to calculate revenue generated on 10 May 2025.

select
      '₹' ||
	  TO_CHAR(
         COALESCE(
               (SELECT SUM(payment_amount)
			   FROM Appointment
			   WHERE appointment_Date = '2025-05-10'),
			   0
		 )
		 +
		 COALESCE(
               (SELECT SUM(amount)
			   FROM RoomRecords
			   WHERE admission_Date = '2025-05-10'),
			   0
		 )
		 +
		 COALESCE(
              (SELECT SUM(amount)
			  FROM BedRecords
			  WHERE admission_Date = '2025-05-10'),
			  0
			 
		 ),
		 '99,99,99,999'
	  ) AS Total_Revenue_INR;

-- Q10. Hospital decided to give some discount to its old customers on some services. Identify patients who have visited the hospital more than 4 times in the past 1.5 year.
SELECT
     P.patient_id,
	 P.fname || '' ||P.lname AS Patient_Name,
	 COUNT(MR.record_id) AS Total_Visits
FROM MedicalRecord MR
JOIN Patients P 
ON MR.patient_id = P.patient_id
WHERE MR.visit_Date >= CURRENT_DATE - INTERVAL '1.5 year'
GROUP BY P.patient_id,P.fname,P.lname
HAVING COUNT(MR.record_id) > 4
ORDER BY Total_Visits DESC;

select * from MedicalRecord;

--Q11.Management received that patient was given wrong amount of anesthesia during surgery. Tracking which staff was present during surgery of patient 967 on a 16 May 2024 between 11 to 12 night.

SELECT 
      P.fname|| '' ||P.lname AS Patient_Name,
	  D.fname|| '' ||D.lname AS Doctor_Name,
	  N.fname|| '' ||N.lname AS Nurse_Name,
	  H.fname|| '' ||H.lname AS Helper_Name,
	  SR.surgery_type,
	  SR.surgery_date,
	  SR.start_time,
	  SR.end_time,
	  SR.notes
FROM SurgeryRecord SR
JOIN patients P
ON SR.patient_id = P.patient_id
JOIN Doctor D
ON SR.surgeon_id = D.doct_id
JOIN nurse N
ON SR.nurse_id = N.nurse_id
JOIN helpers H
ON SR.helper_id = H.helper_id
WHERE 
     SR.patient_id = 967
	 AND SR.surgery_date = '2024-05-16'
	 AND SR.start_time ='23:15:52'
	 AND SR.end_time = '23:45:52';

select * from SurgeryRecord;
select * from patients;
select * from Doctor;
select * from nurse;
select * from helpers;


--- Q12.List all patients who have a follow-up appointment due this week, based on their last next_Visit from MedicalRecord.

SELECT
      P.patient_id,
      P.fname|| ' ' || P.lname AS Patient_Name,
	  M.next_visit
FROM MedicalRecord M
JOIN patients P
ON M.patient_id = P.patient_id
WHERE 
     M.next_visit IS NOT NULL
	 AND M.visit_date Between '2025-05-03' AND '2025-05-26';



select * from MedicalRecord;

-- Q13.

WITH monthly_revenue AS
(
    SELECT
        DATE_TRUNC('month', admission_date) AS month,
        SUM(amount) AS revenue
    FROM RoomRecords
    GROUP BY DATE_TRUNC('month', admission_date)
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_revenue,

    ROUND(
        (
            (revenue - LAG(revenue) OVER (ORDER BY month))
            /
            NULLIF(LAG(revenue) OVER (ORDER BY month), 0)
        ) * 100,
        2
    ) AS revenue_growth_percent

FROM monthly_revenue
ORDER BY month;



-- Q