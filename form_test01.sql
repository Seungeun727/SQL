CREATE TABLE Phoneook(
    name varchar2(20) NOT NULL,
    hp varchar2(128) NOT NULL,
    tel varchar2(128) NOT NULL;
    
CREATE SEQUENCE seq_AddressBook_pk
    START WITH 1
    INCREMENT BY 1;
INSERT INTO PhoneBook(name, hp,tel)
VALUES(seq_Phone.nextval, 이름, 휴대전화, 전화번호);
commit;

SELECT * FROM PhoneBook;