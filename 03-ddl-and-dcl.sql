-----------
-- DCL
-----------
-- CREATE : 데이터베이스 객체 생성
-- ALTER : 데이터 베이스 객체 수정
-- DROP : 데이터 베이스 객체 삭제

-- System 계정으로 수행

-- 사용자 계정으로 수행: CREATE USER
CREATE USER C##bituser IDENTIFIED BY bituser;

-- SQLPLUS에서 사용자로 접속
-- 사용자 삭제: DROP USER
DROP USER C##bituser CASCADE; -- CASCADE 연결된 모든 것을 함께 삭제

-- 다시 생성 
CREATE USER C##bituser IDENTIFIED BY bituser;

-- 사용자 정보 확인
-- USER : 현재 사용자 관련
-- ALL_: WJSCPDML RORCP
-- DBA_ : DBA 전용, 객체의 모든 정보
SELECT * FROM USER_USERS;
-- DEFAULT_TABLESPACE : 저장공간 ( SYSTEM, USERS)
-- TEMPORARY_TABLESPACE: 입지


SELECT * FROM USER_USERS;
SELECT * FROM ALL_USERS;
SELECT * FROM DBA_USERS; 
-- DB내의 모든 USER


-- 새로 만든 사용자 확인
SELECT * FROM DBA_USERS WHERE username = 'C##BITUSER';

-- 권한(Privilege)과 역할(ROL)
-- 특정 작업 수행을 위해 적절한 권한을 가져야 한다.
-- CREATE SESSION

-- 시스템 권한의 부여: GRANT 권한 TO 사용자
-- C##BITUSER에게 create session 권한을 부여
GRANT create session TO C##BITUSER;

-- 일반적으로 CONNECT, RESOURCE 롤을 부여하면 일반 사용자의 역할 수행 가능
GRANT connect, resource TO C##BITUSER;

--Oracle 12 이후로 임의로 TABLESPACE를 할당 해줘야 한다.
ALTER USER C##BITUSER  -- 사용자 정보 수정
    DEFAULT TABLESPACE USERS  -- 기본 테이블 스페이스를 USERS에 지정
    QUOTA UNLIMITED ON USERS;  -- 사용 용량 지정


-- 객체 권한 부여
-- C## BITUSER 사용자에게 HR.EMPLOYEES를 SELECT를 할 수 있는 권한 부여
GRANT select ON HR.EMPLOYEES TO C##BITUSER;

-- 객체 권한 회수
REVOKE select ON HR.EMPLOYEES FROM C##BITUSER;
GRANT select ON HR.EMPLOYEES  TO C##BITUSER;


-- 전체 권한 부여시 
-- GRANT all privilegs...

