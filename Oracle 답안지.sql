-- ORACLE Database 답안지
-- 수강생 이름: 노승은

-- A11.
SELECT last_name(commission_pct), salary, department_name  
FROM employees;

-- A12.

SELECT last_name, salary, job_id FROM departments
WHERE last_name = 'king';


-- A13. 

SELECT manager_id, last_name, salary FROM employees
WHERE salary <= 11500;
    

-- A14. -->ok

SELECT MIN(salary),MAX(salary),SUM(salary),ROUND(AVG(salary))
FROM employees;


-- A15.

SELECT last_name, AVG(salary) salary
FROM employees
WHERE salary < AVG(salary);

