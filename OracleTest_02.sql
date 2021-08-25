-- ORACLE Database 답안지
-- 수강생 이름: 노승은

-- A11.
SELECT e.last_name, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id (+)
AND commission_pct IS NOT NULL;


SELECT last_name, salary, NVL(commission_pct,0)
FROM employees
WHERE commission_pct IS NOT NULL;


-- A12.
-- last_name이 ‘King’인 사람을 
-- 매니저로 둔  직원들의 last_name, salary, job_id를 출력해 주십시오.
SELECT emp.last_name, emp.salary, emp.job_id
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id AND
    man.last_name = 'King';
SELECT last_name, salary, job_id
FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees
        WHERE last_name ='King');
        

SELECT last_name, salary, job_id
FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees
        WHERE last_name LIKE '%King%');
        
-- A13. 
SELECT emp.last_name, emp.salary FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id AND emp.salary > man.salary;
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
SELECT department_id, AVG(salary) FROM employees GROUP BY department_id; -- 서브 쿼리로 사용

SELECT last_name, e.salary 
FROM employees e, (SELECT department_id, AVG(salary) salary FROM employees GROUP BY department_id) sal
WHERE e.department_id = sal.department_id AND e.salary < sal.salary;

--방식 1 -> 해결 X
SELECT e.last_name, e.salary
FROM employees e
WHERE salary < (SELECT AVG(salary) 
                FROM employees 
                WHERE department_id = e.department_id); 
                
-- 방식 2 -> 해결 X
SELECT last_name, salary FROM employees 
WHERE salary < (SELECT AVG(salary) FROM employees); 