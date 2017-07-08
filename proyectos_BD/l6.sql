
EXPLAIN PLAN SET STATEMENT_ID='est1' FOR 
SELECT e.employee_id, e.last_name, e.salary, d.department_name, l.city 
FROM employees e, departments d, locations l 
WHERE e.department_id = d.department_id AND d.location_id = l.location_id
 AND l.city = 'Oxford' AND e.salary > 10500 AND e.last_name LIKE '%e%';

EXPLAIN PLAN SET STATEMENT_ID='est1' FOR 
SELECT e.first_name, e.last_name, d.department_name, e.salary 
FROM employees e, departments d 
WHERE e.department_id = d.department_id 
AND e.salary = (SELECT MAX(salary) FROM employees);

EXPLAIN PLAN SET STATEMENT_ID='est1' FOR 
SELECT e.first_name EMPLEADO, 
e.salary, e.hire_date, m.first_name as JEFE, m.salary, m.hire_date 
FROM employees e, employees m 
WHERE e.manager_id = m.employee_id 
AND e.hire_date < m.hire_date AND e.salary > m.salary;



EXPLAIN PLAN SET  STATEMENT_ID='est2'  INTO MY_PLAN_TABLE FOR
SELECT d.department_id, d.department_name, COUNT(e.employee_id) CANT_EMP, SUM(e.salary) TOTAL_SALARIO 
FROM employees e, departments d 
WHERE e.department_id = d.department_id 
GROUP BY d.department_id,d.department_name;


EXPLAIN PLAN SET  STATEMENT_ID='est2'  INTO MY_PLAN_TABLE FOR
SELECT d.department_name, AVG(e.salary) 
FROM employees e, departments d 
WHERE e.department_id = d.department_id 
AND e.department_id NOT IN (50,80) 
GROUP BY d.department_id,d.department_name 
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employees);


EXPLAIN PLAN SET  STATEMENT_ID='est2'  INTO MY_PLAN_TABLE FOR
SELECT e.last_name, e.salary, t1.PROMEDIO 
FROM employees e, (SELECT e.department_id, AVG(e.salary) PROMEDIO 
	FROM employees e GROUP  BY e.department_id) t1 
WHERE e.department_id = t1.department_id 
AND e.salary < t1.PROMEDIO;

SELECT e.first_name, e.last_name, e.salary, i1.salario_promedio
FROM  (SELECT e.department_id, AVG(e.salary) salario_promedio FROM employees e GROUP  BY e.department_id) i1 
JOIN employees e ON  i1.department_id = e.department_id
WHERE  e.salary < i1.salario_promedio;

SELECT e.first_name, e.last_name, e.salary, j.job_title 
FROM   jobs j  
JOIN job_history jh ON  j.job_id = jh.job_id
JOIN employees e ON  jh.employee_id = e.employee_id
WHERE  j.job_title  != NULL GROUP BY e.employee_id;

set linesize 100
set pagesize 0
SELECT id, operation  , object_name name  , cost  ,time  FROM MY_PLAN_TABLE;