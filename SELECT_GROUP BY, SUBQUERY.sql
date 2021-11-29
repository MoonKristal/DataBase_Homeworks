-- 1�� ����
--�μ����� �׷��Ͽ� �μ���ȣ, �ο���, �޿��� ���, �޿��� ���� ��ȸ�ϼ���.
SELECT DEPT_CODE, COUNT(EMP_ID), ROUND(AVG(SALARY)), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

-- 2�� ����
-- �ڽ��� ���� ������ ��� �޿����� ���� �޴� ����� �̸�, ���޸�, �޿� ���� ��ȸ�ϼ���.
SELECT EMP_NAME, J.JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND E.SALARY > (SELECT ROUND(AVG(SALARY))
                     FROM EMPLOYEE EM
                     WHERE E.JOB_CODE = EM.JOB_CODE
                     GROUP BY JOB_CODE);
                    

-- 3�� ����
-- ȸ�翡�� �ް�ö�� �¾� �� ������� �ؿܿ����� �����ַ��� �մϴ�.
-- ������� �޿��� ���� �����ַ��� �Ͽ�
-- S1,S2 �� ������� �̱�, S3, S4�� ������� �߱�, S5, S6�� ������� �Ϻ��� ���������ؿ�.
-- ��, ���� �ٹ��ϰ� �ִ� ������ ������ �ؿܿ����� �����ַ��� ������ ���� ���, ���������� �����ָ�
-- ��ǥ�� �ް����� ����ؼ� �ٹ��� �ϱ�� �մϴ�.
-- EMPLOYEE ���̺��� �̿� ���� ���ǿ� �´�
-- ���, �����, �μ���, ���α�����(NATIONAL_NAME), �޿����, �ް������� �� ��� ������������ ��ȸ�ϼ���.
SELECT EMP_ID ���, EMP_NAME �����, DEPT_CODE �μ���, NATIONAL_NAME ���α�����, SAL_LEVEL �޿����
    , CASE WHEN JOB_CODE='J1'THEN'�ٹ�' 
    WHEN SAL_LEVEL IN ('S1','S2') THEN 'US'
    WHEN SAL_LEVEL IN ('S3','S4') THEN 'CH'
    WHEN SAL_LEVEL IN ('S4','S5') THEN 'JP'
    ELSE '����'
    END "�ް�������"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
ORDER BY EMP_ID ASC;


-- 4�� ����
--��� ����� �޿��� ������ '��00,000,000'�������� ���ϼ���
SELECT TO_CHAR(SUM(SALARY),'L999,999,999')
FROM EMPLOYEE;

-- 5�� ����
--�μ� �ڵ尡 D9�� ������� �޿� �� ���� �޿����� ���� �޿��� �޴� ����� �̸��� �޿��� ����ϼ���
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT MIN(SALARY)
                FROM EMPLOYEE)
 AND DEPT_CODE IN ('D9');

-- 6�� ����
--'D6'�� �μ��� ��� �߿��� �޿��� ���� ���� �޴� ������� �� ���� �޿��� �޴� ����� �̸��� �޿��� ����غ�����.
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT MAX(SALARY)
                FROM EMPLOYEE
                WHERE DEPT_CODE IN ('D6')) ;

-- 7�� ����
-- ȸ���� ���������� ���Ͽ� ���������� �Ұ����������ϴ�.
-- �켱 ���� ����� �ľ��ϱ� ���� (EMPLOYEE ���̺���) ��� ������ ���, �����, ����, �μ���, �ٹ�������
-- �����ڵ�� ����� ������������ ��ȸ�ϼ���.
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
LEFT JOIN JOB B ON (E.JOB_CODE = B.JOB_CODE)
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
ORDER BY DEPT_CODE, EMP_ID DESC; 

-- 8�� ����
-- ��� ������ �ǹ̷� �Ѵ޿� �ѹ� �系 �̺�Ʈ�� ����˴ϴ�.
-- ���� ��÷�� ���� �̺�Ʈ ��÷�� ��ǥ�� ���� ������ ��ȸ�ϼ���. (��� ������ �ּ��Ѹ� ����ǰ� �ϱ� ���� ���� ������ �����ؾ� �մϴ�)
-- ��÷���� ���, �����(��� ���ڴ� '*'���� ǥ��), ���̵�(�̸��Ͽ��� ���̵� ����), ����ó(��� 4�ڸ��� '****'���� ǥ��)
-- �̹� �� ��÷�ڴ� �ֹι�ȣ ������ �ڸ��� '1'�� ������Դϴ�.
SELECT EMP_ID ���, RPAD(SUBSTR(EMP_NAME,1,1),3,'*')||SUBSTR(EMP_NAME,3,1) �����
       ,SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) ���̵�,RPAD(SUBSTR(PHONE,1,3),7,'*')||SUBSTR(PHONE,8,4) ����ó
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,13,1)='1';

-- 9�� ����
-- ������, �μ���, �ο���, �޿��հ�, �޿������ ��ȸ�ϵ�,
-- ������� �μ��� ���� ��� ��ȸ�ϰ�,
-- ������ ������ ��������, �μ��� �������� ������ �����ϼ���.
SELECT NATIONAL_NAME, DEPT_TITLE, COUNT(EMP_NAME), SUM(SALARY), ROUND(AVG(SALARY))
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN NATIONAL N ON(D.LOCATION_ID = N.NATIONAL_CODE)
GROUP BY NATIONAL_NAME, DEPT_TITLE
ORDER BY NATIONAL_NAME DESC, DEPT_TITLE DESC;

-- 10�� ����
-- ��ǥ '������'�� �ֱ� �系���� �������� �ǽɵǴ� ��Ȳ�� ����� �Ǿ���.
-- ������ ã�Ƴ��� ���� �������� ���翡�� ��и��� ������� ������ �����ؿ���� ����ߴ�.
-- ���, �����, �μ���, ���޸�, �޿�, ���ʽ�, ����, ������� ��ȸ�ϰ�
-- ������ ����� ��������, �޿� �������� ������ �����Ѵ�.
-- ������� �ֹι�ȣ ���ڸ� 2��°���� 2�ڸ��� �������� ������ ����.
--���� 00~08 / �λ� 09~12 / ��õ 13~15 / ��� 16~25 / ���� 26~34 / ��� 35~39 / ���� 40 /
--�泲 41~47 / ���� 48~54 / ���� 55~64 / ���� 65~66 / �뱸 67~69, 76 /
--��� 70~75, 77~81 / �泲 82~84, 86~92 / ��� 85 / ���� 93~95 / �� �ܿ��� 'Ȯ�ο��'���� ǥ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_NAME, SALARY, BONUS
    , DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��')"����"
    , CASE WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 00 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 08 THEN '����'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 09 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 12 THEN '�λ�'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 13 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 15 THEN '��õ'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 16 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 25 THEN '���'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 26 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 34 THEN '����'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 35 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 39 THEN '���'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) = 40 THEN '����'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 41 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 47 THEN '�泲'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 48 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 54 THEN '����'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 55 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 64 THEN '����'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 66 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 66 THEN '����'
    WHEN (TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 67 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 69 )
     OR TO_NUMBER(SUBSTR(EMP_NO,9,2)) = 76 THEN '�뱸'
    WHEN (TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 70 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 75)
     OR (TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 77 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 81) THEN '���'
    WHEN (TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 82 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 84 )
     OR (TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 86 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 92) THEN '�泲'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) = 85 THEN '���'
    WHEN TO_NUMBER(SUBSTR(EMP_NO,9,2)) >= 93 AND TO_NUMBER(SUBSTR(EMP_NO,9,2)) <= 95 THEN '����'
    ELSE 'Ȯ�ο��'
    END AS"�����"
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
ORDER BY "�����" ASC, SALARY DESC;


