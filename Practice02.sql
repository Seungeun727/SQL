-- 집계 연습 문제 다시 풀기
-- 문제 1번
SELECT count(manager_id) havaeMngCnt 
FROM employees
WHERE manager_id IS NOT NULL;

-- 문제 2번
SELECT MAX(salary) 최고임금, MIN(salary) 최저임금, MAX(salary)-MIN(salary) "최고임금 -최저임금"
FROM employees;

-- 문제 3번 
SELECT  TO_CHAR(MAX(hire_date), 'yyyy"년" MM"월" DD"일"')
FROM employees;

-- 문제 4번
SELECT department_id, avg(salary), max(salary),min(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id DESC;

-- 문제 5번
SELECT job_id, ROUND(AVG(salary)), max(salary), min(salary)
FROM employees 
GROUP BY job_id
ORDER BY min(salary) DESC, avg(salary) ASC;

-- 문제 6번
-- 틀린 이유: DATE_FORMAT으로 풀려함
SELECT TO_CHAR(MIN(hire_date), 'yyyy"년" MM"월" DD"일"')
FROM employees;

-- 문제 7번
-- 틀린 이유: HAVING을 안씀
SELECT department_id, AVG(salary), MIN(salary), AVG(salary)- MIN(salary)
FROM employees
GROUP BY department_id
   HAVING AVG(salary)- MIN(salary) < 2000
ORDER BY AVG(salary) - MIN(salary) DESC;

-- 문제 8번
SELECT job_id, max(salary) - min(salary) as diff
FROM employees
GROUP BY job_id
ORDER BY diff DESC;

-- 문제 9
-- 틀린 이유: WHERE 조건을 만족하지 못했음
SELECT manager_id, ROUND(avg(salary)), max(salary), min(salary)
FROM employees
    WHERE hire_date > = '05/01/01'
GROUP BY manager_id
    HAVING avg(salary) > = 5000
ORDER BY avg(salary) desc;

-- 문제 10 
-- 다시 풀기
SELECT employee_id, salary,     
    CASE WHEN hire_date <= '02/12/31' THEN '창립멤버'
    WHEN hire_date <= '03/12/31' THEN '03년 입사'
    WHEN hire_date <= '04/12/31' THEN '04년 입사'
    ELSE '상장이후 입사'
  END optDate,
  hire_date
FROM employees
ORDER BY hire_date ASC;