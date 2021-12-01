
-- 1�� ����. 
--�μ� �� GROUP BY
--�޿� �հ谡 SUM(SALAY)
--��ü �޿� �� ���� SUM(SALARY
--20%���� ���� (  * 0.2)
--�μ��� �μ� ��, �μ� �� �޿� �հ� ��ȸ DEPT_TITLE, SUM(SALARY)

SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2 FROM EMPLOYEE);

SELECT DEPT_TITLE, ����
FROM(SELECT DEPT_TITLE, SUM(SALARY) "����"
    FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        GROUP BY DEPT_TITLE)
WHERE ���� > (SELECT SUM(SALARY) * 0.2
            FROM EMPLOYEE);
    

--                                     EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, RANK() OVER(���ʽ����Կ���) ����
-- 2�� ����. ���ʽ� ������ ������ ���� 5���� ���, �̸�, �μ� ��, ����, �Ի���, ���� ��ȸ
-- EMPLOYEE, DEPARTMENT, JOB
--
--
--WHERE ���� <= 5;
-- RANK() OVER(SALARY + SALARY * NVL(BONUS, 0)) * 12

SELECT ROWNUM, EMP_ID, DEPT_TITLE, JOB_NAME, HIRE_DATE, ����
FROM(SELECT EMP_ID, DEPT_TITLE, JOB_NAME, HIRE_DATE,
    RANK() OVER(ORDER BY (SALARY + SALARY * NVL(BONUS, 0)) * 12 DESC) ����
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
    )
WHERE ���� <= 5;

-- 3������. ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ����, �޿� ��ȸ

SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE (BONUS IS NULL) AND (JOB_CODE IN ('J4', 'J7'));
--WHERE NVL(BONUS, 0) = 0; �� ����


-- 4������. �迭������ ������ ī�װ� ���̺��� �����
--���̺� �̸�
--TB_CATEGORY
--�÷�
--NAME, VARCHAR2(10)
--USE_YN, CHAR(1), �⺻�� Y�� ������

CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10), 
    USE_YN CHAR(1) DEFAULT 'Y'
    
);


-- 5�� ����. ���� ������ ������ ���̺� �����
--���̺� �̸�
--TB_CLASS_TYPE
--�÷�
--NO, VARCHAR2(5), PRIMARY KEY
--NAME, VARCHAR2(10)
--
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(20)
);
