-- DML: SELECT 


----------
-- SELECT ~ FROM
----------

-- 전체 데이터의 모든 컬럼 조회
-- 컬럼의 출력 순서는 정의에 따른다.
SELECT * FROM employees;
SELECT * FROM departments;

-- 특정 컬럼만 선별 Projection
-- 사원의 이름, 입사일, 급여
SELECT first_name,
    hire_date,
    salary
FROM employees;

-- 산술연산: 기본적인 산술연산 가능
-- dual: oracle의 가상 테이블
-- 특정 테이블에 속한 데이터가 아닌
-- 오라클 시스템에서 값을 구한다.
SELECT 10 * 10 * 3.14159 FROM dual; -- 결과 1개
SELECT 10 * 10 * 3.14159 FROM employees; -- 결과 테이블의 레코드 수만큼


SELECT first_name, job_id * 12 From employees; -- ERROR: 수치데이터 아니면 산술연산 오류
DESC employees;

SELECT fist_name + ' ' + last_name FROM employees; -- ERROR: first_name, last_name은 문자열

-- 문자열 연결은 ||로 연결
SELECT first_name || ' ' || last_name FROM employees;


-- NULL
SELECT first_name, salary, salary * 12 FROM employees;

SELECT first_name, salary, commission_pct FROM employees; 

-- NULL이 포함된 산술식은 NULL
SELECT first_name, salary, commission_pct, salary + salary * commission_pct FROM employees; 

-- NVL: 중요
-- comission_pct가 null이면 0으로 치환
SELECT first_name, salary, commission_pct, salary + salary * NVL(commission_pct, 0) FROM employees;


-- ALIAS: 별칭 --> 컬럼의 출력 제목을 변경하는 것.
-- 공백, 특수문자가 포함된 별칭은 ""으로 묶는다. --> "급 여"
SELECT first_name || ' ' || last_name 이름, phone_number as 전화번호,
       salary "급 여" FROM employees;


SELECT first_name || ' ' || last_name 이름, hire_date as 입사일, phone_number "전화번호",
       salary 급여, salary * 12 연봉 FROM employees;



