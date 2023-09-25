Select * From Employees;


-- Spesifik mesle?e göre çal??an getiren sorgu
Select 
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
From
    Employees
Where JOB_ID = 'IT_PROG';


-- Toplam maas 20k'dan büyük isleri bulalim ve buyukten kucuge siralayalim.
Select
    j.job_title,
    sum(e.salary) as TotalSalary
From
    Employees e
Join Jobs j on e.job_id = j.job_id
Group By j.job_title
Having sum(e.salary) > 20000
Order By TotalSalary desc;


-- Hangi meslek grubunda kaç tane çal??an var getiren sorgu
Select
    j.job_title,
    count(*)
From
    Employees e
Join JOBS j on j.JOB_ID = e.JOB_ID
Group By j.job_title;


-- Departman Ad? ve Yönetici ?smini Join'ler ile Getiren Sorgu
Select 
    manager.manager_id,
    e.employee_id,
    e.First_Name,
    e.Last_Name,
    manager.First_Name as ManagerName,
    d.department_name    
From
    Employees e
Join departments d on d.department_id = e.department_id
Join Employees manager on manager.employee_id = e.manager_id
Order By manager.employee_id asc;

-- K?r?l?ml? tablolar
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    j.job_title,
    d.department_name,
    l.postal_code,
    l.city
FROM
    employees e
Join jobs j on j.job_id = e.job_id
Join departments d on e.department_id = d.department_id
Join locations l on d.location_id = l.location_id;

