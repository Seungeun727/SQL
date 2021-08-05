-- 문제 1번
SELECT employee_id as 사번, first_name 이름, 
    last_name 성,
    department_name 부서명
FROM employees e, department dept
WHERE e.department_id = dept.department_id
ORDER BY department_name, employee_id DESC;

-- 문제 2번
-- department dept 빼먹음
SELECT employee_id 사번,
        first_name 이름,
        salary 급여,
        department_name 부서명,
        job_title "현재 업무"
FROM employees e , department dept, jobs j
WHERE e.employee_id = dept.department_id AND
      e.job_id = j.job_id
ORDER BY employee_id;


-- 문제 2번 -1

SELECT employee_id 사번,
        first_name 이름,
        salary 급여,
        department_name 부서명,
        job_title "현재 업무"
FROM employees e , department dept, jobs j
WHERE e.department_id = dept.department_id (+) AND
      e.job_id = j.job_id
ORDER BY employee_id;


-- ANSI
SELECT employee_id 사번,
        first_name 이름,
        salary 급여,
        department_name 부서명,
        job_title "현재 업무"
FROM employees e LEFT OUTER JOIN departments dept 
            ON e.department_id = dept.department_id,
            jobs j
WHERE e.job_id = j.job_id;




-- 문제 3번

-- 1> 방법 : 1
SELECT loc.location_id 도시아이디, loc.city 도시명, 
    dept.department_name 부서명, dept.department_id "부서명 이름"
FROM departments dept
RIGHT OUTER JOIN locations loc ON dept.location_id = loc.location_id
ORDER BY  loc.location_id;


--2> 방법 : 2
SELECT loc.location_id, city,
    department_name, department_id
FROM departments dept JOIN locations loc 
ON dept.location_id = loc.location_id
ORDER BY loc.location_id;


-- 문제 3번-1
-- 다시 풀기
SELECT loc.location_id, city,
    department_name, department_id
FROM locations loc LEFT OUTER JOIN departments dept  
ON loc.location_id = dept.location_id
ORDER BY loc.location_id;

-- 문제 4번
SELECT region_name 지역이름, country_name 나라이름
FROM regions r, country c
WHERE r.region_id = c.region_id
ORDER BY r.region_name, country_name DESC;

SELECT r.region_name, c.country_name
FROM regions r
JOIN c.countries 
ON r.region_id = c.region_id
ORDER BY region_name, c.country_name DESC;

-- 문제 5번 --> 다시 풀기
SELECT e.employee_id, e. first_name,
    e.hire_date, m.first_name,
    m.hire_date
FROM employees e, employees m
WHERE e.manager_id = m.manager_id AND
    e.hire_date < m.hire_date;
    
-- 문제 6
SELECT c.country_name, city, 
    l.location_id, department_name, 
    department_id
FROM countries c, locations l, departments dept
WHERE c.country_id = l.country_id AND
    l.location_id = dept.location_id
ORDER BY c.country_name;

-- 문제 7
SELECT employee_id 사번, first_name || ' ' || last_name 이름,
       j.job_id 업무아이디, start_date 시작일, end_date 종료일
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id AND
    j.job_id = 'AC_CCOUNT';
    
-- 문제 8  -- > 다시 풀기
-- 부서가 없는 직원도 표시할 것
SELECT d.department_id,
    department_name,
    first_name 매니저이름,
    city 도시명,
    country_name 나라명,
    region_name 지역명
FROM departments d, employees e, locations l,
    countries c, regions r
WHERE d.manager_id = e.employee_id AND
    d.location_id = l.location_id AND
    l.country_id = c.country_id AND
    c.region_id = r.region_id
ORDER BY d.department_id; 

-- 문제 9번 --> 조인 방법 다양하게 다시 풀어보기!
SELECT e.employee_id, e.first_name,
    department_name, m.first_name
FROM employees e LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id,
    employees m
WHERE e.manager_id = m.employee_id;


---------
-- Subquery
-----------
-- 하나의 질의문 안에 다른 질의문을 포함하는 형태
-- 전체 사원 중, 급여의 중앙값보다 많이 받는 사원

-- 1. 급여의 중앙값?
SELECT MEDiAN(salary) FROM employees; --6200
-- 2. 6200보다 많이 받는사원 쿼리
SELECT first_name, salary FROM employees WHERE salary > 6200;

-- 3. 두 쿼리를 합친다.
SELECT first_name, salary FROM employees 
WHERE salary > (SELECT MEDIAN(salary) FROM employees);

-- Den보다 늦게 입사한 사원들
-- 1. Den 입사일 쿼리
SELECT hire_date FROM employees WHERE first_name = 'Den';  -- 02/12/07
-- 2. 특정 날짜 이후 입사한 사원 쿼리
SELECT first_name, hire_date FROM employees WHERE hire_date >= '2002/12/07';
-- 3. 두 쿼리를 합친다.
SELECT first_name, hire_date 
FROM employees 
WHERE hire_date >= (SELECT hire_date FROM employees WHERE first_name = 'Den');

-- 다중행 서브쿼리
-- 서브쿼리의 결과 레코드가 둘 이상이 나올 때는 단일행 연산자를 사용할 수 없다.
-- IN, ANY, ALL, EXISTS 등 집합 연산자를 활용
SELECT salary FROM employees WHERE department_id = 110; -- 2 ROW

SELECT first_name, salary FROM employees
WHERE salary = (SELECT salary FROM employees WHERE department_id = 110); 
-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었음을 출력됨 error  
-- = 연산자 ===> 집합연산자로 수정할 것.

-- 결과가 다중행이면 집합 연산자를 활용 
-- salary = 120008 OR salary = 8300
SELECT first_name, salary FROM employees
WHERE salary IN (SELECT salary FROM employees WHERE department_id = 110);

-- ALL(AND)
-- salary > 12008 AND salary > 8300
SELECT first_name, salary FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE department_id = 110);

-- ANY(OR)
-- salary > 12008 OR salary > 8300
SELECT first_name, salary FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 110);

-- !!연습문제!!
-- 문제 : 각 부서별로 최고 급여를 받는 사원을 출력

-- 방법 1> : 서브쿼리만 이용
-- 1. 각 부서의 최고 급여를 확인하는 쿼리
SELECT department_id, max(salary) FROM employees
GROUP BY department_id;

-- 2.서브 쿼리의 결과 (department_id, max(salary)
SELECT department_id, employee_id, first_name, salary
FROM employees
WHERE (department_id, salary)
IN (SELECT department_id, max(salary) FROM employees
GROUP BY department_id)
ORDER BY department_id;   
-- IN ( ) 설명 :  (10 , 4400)를 가짐.

-- 방법 2> : 서브쿼리와 조인
SELECT e.department_id, e.employee_id, e.first_name, e.salary
FROM employees e, (SELECT department_id, MAX(salary) salary FROM employees
                   GROUP BY department_id) sal
-- 205 줄: employees e가 임시로 만든 테이블을 해당 테이블을 조인함.
WHERE e.department_id = sal.department_id AND 
    e.salary = sal.salary
ORDER BY e.department_id;
