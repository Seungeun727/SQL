-- 실습용 계정 활성화: system으로 수행
-- 오라클 12 이상에서는 사용자 계정에 C##을 붙여야 한다.
-- c## 사용하지 않기

Alter session set "_ORACLE_SCRIPT" = true;  -- Ctrl + Enter

--HR 계정 스크립트 수행
@?\demo\schema\human_resources\hr_main.sql

-- 파라미터 1: HR계정 비밀번호 - hr
-- 파라미터 2: 기본 테이블 스페이스 - users
-- 파라미터 3: 임시 테이블 스페이스 - temp
-- 파라미터 4: 로그 파일 위치 - %ORACLE_HOME%\demo\schema\log

--HR 계정으로 진행
--내가 가진 테이블 목록 확인
SELECT * FROM tab;
--특성 테이블의 정보 확인
DESC employees;