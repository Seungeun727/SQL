-- 서브 쿼리 관한 연습 문제
-- 문제 1 : 성공!
-- 설명
SELECT COUNT(salary) FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 내가 풀은 답안
SELECT COUNT(salary) FROM employees 
WHERE salary < (SELECT AVG(salary) FROM employees);


-- 문제 2
-- 다시 풀기!
-- 사용할 서브쿼리 
SELECT AVG(salary) avgSalary,
                        MAX(salary) maxSalary
                    FROM employees;
-- 답
SELECT e.employee_id, e.first_name, e.salary, 
    t.avgSalary, t.maxSalary
FROM employees e, ( SELECT AVG(salary) avgSalary,
                        MAX(salary) maxSalary
                    FROM employees ) t
WHERE e.salary BETWEEN t.avgSalary AND t.maxSalary
ORDER BY salary;


-- 문제 3번

-- 쿼리1. Steven King이 소속된 부서
SELECT department_id FROM employees
WHERE first_ame = 'Steven' AND last_name= 'King';

-- 쿼리2. Steven King이 소속된 부서가 위치한 location 정보
SELECT location_id FROM departments 
WHERE department_id = (SELECT department_id FROM employees
WHERE first_ame = 'Steven' AND last_name= 'King');

--최종 쿼리
SELECT location_id, 
    street_address, 
    postal_code,
    city,
    state_province,
    country_id
FROM locations
WHERE location_id = ( SELECT location_id  FROM departments 
                      WHERE department_id = (SELECT department_id FROM employees
                      WHERE first_name = 'Steven' AND last_name= 'King'));


-- 문제 4번
SELECT employee_id, first_name, salary FROM employees
WHERE salary < ANY (SELECT salary FROM employees WHERE job_id = 'ST_MAN');


-- 문제 5번
-- 방법1>: 조건절 비교
SELECT employee_id, first_name, salary, department_id From employees 
WHERE (department_id, salary) IN ( SELECT department_id, MAX(salary) 
FROM employees GROUP BY department_id) ORDER BY salary DESC;

-- 방법 2>: 테이블 조인 -- 다시 풀기 
SELECT e.employee_id, e.first_name, e.salary, e.department_id
FROM employees e,(SELECT department_id, MAX(salary) salary
FROM employees GROUP BY department_id) t
WHERE e. department_id = t.department_id AND e. salary = t.slary
ORDER BY e.salary DESC;

-- 문제 6번
SELECT j.job_title, t.sumSalary FROM jobs j,
(SELECT job_id, SUM(salary) sumSalary
FROM employees GROUP BY job_id) t
WHERE j.job_id = t.job_id
ORDER BY t.sumSalary DESC;

-- 문제 7번
-- 조회하는 테이블의 위치가 틀렸음!
SELECT e.employee_id, e.first_name, e.salary
FROM employees e, (SELECT department_id, avg(salary) salary FROM employees
GROUP BY department_id) t
WHERE e.department_id = t.department_id AND
    e.salary > t.salary;


-- 문제 8번 ---> 다른 방법 찾아보기!
-- 풀지 못함
-- 쿼리 1
SELECT ROWNUM
    employee_id,
    first_name,
    salary,
    hire_date
FROM employees
ORDER BY hire_date ASC;

--쿼리 2
SELECT ROWNUM rn,
    employee_id,
    first_name,
    salary,
    hire_date
FROM (SELECT 
            employee_id,
            first_name,
            salary,
            hire_date
            FROM employees
            ORDER BY hire_date ASC);
-- 최종쿼리
SELECT rn,
    employee_id,
    first_name,
    salary,
    hire_date
    FROM ( SELECT ROWNUM rn,
            employee_id,
            first_name,
            salary,
            hire_date
    FROM (SELECT 
                    employee_id,
                    first_name,
                    salary,
                    hire_date
            FROM employees
            ORDER BY hire_date ASC))
WHERE rn BETWEEN 11 AND 15;





