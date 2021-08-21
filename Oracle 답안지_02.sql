-- ORACLE Database 답안지
-- 수강생 이름: 노승은

-- A11.
SELECT last_name, salary, NVL(commission_pct,0)
FROM employees
WHERE commission_pct IS NOT NULL;



-- A12.
-- last_name이 ‘King’인 사람을 
-- 매니저로 둔  직원들의 last_name, salary, job_id를 출력해 주십시오

SELECT last_name, salary, job_id
FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees
        WHERE last_name ='King');


-- A13. 
-- 방식 1. 해결 O
SELECT e.last_name, e.salary
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
AND e.salary > m.salary;


--방식 2. 해결 x
select  e.last_name, e.salary, m.salary
from employees e inner join employees m on e.manager_id = m.employee_id
where e.salary > m.salary;



-- A14. --> 공백 제거 해결방법 찾기

SELECT MIN(salary),MAX(salary),SUM(salary),ROUND(AVG(salary))
FROM employees; 


-- A15.

--방식1. --> 결과처럼 나오지 못함 (해결x)
SELECT e.last_name, e.salary
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
AND e.salary < m.salary;

--방식2.
SELECT last_name, salary
FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees);
