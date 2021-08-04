----------
-- JOIN
----------

-- ���� employees�� departments Ȯ��
DESC employees;
DESC departments;

-- �� ���̺�κ��� ��� ���ڵ带 ���� : Cartision Product or Cross Join
SELECT first_name, emp.department_id, dept.department_id, department_name
FROM employees emp, departments dept
ORDER BY first_name;

-- ���̺� ������ ���� ������ �ο��� �� �ִ�.
SELECT first_name, emp.department_id, dept.department_id, department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;
