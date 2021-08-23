-- ORACLE Database 답안지
-- 수강생 이름: 노승은

-- A11.
SELECT e.last_name, e.salary, d.department_name
FROM employees e, departments d
WHERE d.department_id= e.department_id
AND commission_pct IS NOT NULL;


SELECT last_name, salary, NVL(commission_pct,0)
FROM employees
WHERE commission_pct IS NOT NULL;


-- A12.
-- last_name이 ‘King’인 사람을 
-- 매니저로 둔  직원들의 last_name, salary, job_id를 출력해 주십시오.

SELECT last_name, salary, job_id
FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees
        WHERE last_name ='King');
        

SELECT last_name, salary, job_id
FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees
        WHERE last_name LIKE '%King%');
        
-- A13. 
--방식 1.
SELECT e.last_name, salary
FROM employees e
WHERE e.salary > 
    (SELECT m.salary FROM employees m
        WHERE e.manager_id = m.employee_id);
        
-- 방식 2. 방법 1을 간결하게 작성해보기
SELECT e.last_name, e.salary
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
AND e.salary > m.salary;

-- A14. 
SELECT MIN(salary) MIN ,MAX(salary) MAX ,SUM(salary) SUM ,ROUND(AVG(salary)) AVG
FROM employees;

-- A15.
--방식 1 -> 해결 X
SELECT e.last_name, e.salary
FROM employees e
WHERE salary < (SELECT AVG(salary) 
                FROM employees 
                WHERE department_id = e.department_id); 
                
-- 방식 2 -> 해결 X
SELECT last_name, salary FROM employees 
WHERE salary < (SELECT AVG(salary) FROM employees); 