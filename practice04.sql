-- 서브 쿼리 관한 연습 문제
-- 문제 1번 ---> 성공!
SELECT COUNT(salary) FROM employees 
WHERE salary < (SELECT AVG(salary) FROM employees);
 
-- 문제 2번
SELECT employee_id, first_name, salary FROM employees
WHERE salary < ( SELECT AVG(salary) FROM employees);



-- 문제 3번

SELECT first_name || ' ' || last_name 이름,
FROM departments;


-- 문제 4번
SELECT * FROM employees WHERE
ANY salary < (SELECT salary FROM employees WHERE employees_name = "ST_MAN');


-- 문제 7번
SELECT employee_id, first_name, salary
FROM employees
WHERE (employee_id, salary)
IN (SELECT department_id, max(salary) FROM employees
GROUP BY dep_id)
ORDER BY department_id desc;  







