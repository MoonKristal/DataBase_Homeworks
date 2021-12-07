/*
���� 1)
����ó�� �����ϴ� ����, 011, 017 ��ȣ�� ���� �������� ����
�ֽ� ������ ��Ʈ 10+�� ȸ�� ���� �������� �����ϱ�� �ߴ�.
����ó�� '011', '017'�� �����ϴ� �������� ���, �����, ����ó, �μ���, ���޸���
��ȸ�ϰ� ����ó�� '010'���� �����ϴ� ��ȣ�� �����ϴ� �������� �ۼ��Ͻÿ�.
*/
SELECT EMP_ID, EMP_NAME, PHONE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE SUBSTR(PHONE,1,3) IN (011,017);

UPDATE EMPLOYEE
SET PHONE = '0103654485'
WHERE SUBSTR(PHONE,1,3) = '011';

UPDATE EMPLOYEE
SET PHONE = '0109964233'
WHERE SUBSTR(PHONE,1,3) = '017';


/*
���� 2)
�ټӿ��� �� ������� ������踦 ������ �Ѵ�.
EMP_COPY_TEST���� �ټӿ����� �������
�ټӿ����� 10�� �̻��� �������
�ټӿ����� ��ձ޿��� �ְ�޿��� ���Ͽ�, �ټӿ����� ������������ �����Ͻÿ�.
*/

CREATE TABLE EMP_COPY_TEST
AS (SELECT * 
    FROM EMPLOYEE);

SELECT AVG(SALARY), MAX(SALARY)
    , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
FROM EMP_COPY_TEST
GROUP BY EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
HAVING EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >= 10
ORDER BY 1 DESC;

/*
���� 3)
����������� �ο��� �����Ͽ� �μ��� ���� �������� ��������η� ��������� �����Ͽ���.
�μ��� ���� �������� ��������η� �̵��� ��
����������� ��� ����� �޿� ���޸� �μ����� ��ȸ�Ͻÿ�.
*/

SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

UPDATE EMPLOYEE
SET DEPT_CODE = 'D8'
WHERE DEPT_CODE IS NULL;

SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE ='���������';


--���� 4)
-- �Ŵ��� ��ȣ ���� �׷�ȭ�Ͽ� �ش� �Ŵ����� ���, �����, ���� ������� �޿��հ踦 ��ȸ�Ͻÿ�.
SELECT ������, ����̸�, SUM(����޿�) ����޿��հ�
FROM (SELECT E.EMP_ID ������, E.EMP_NAME ����̸�, EM.EMP_ID ������, EM.EMP_NAME ����̸�, EM.SALARY ����޿�
      FROM EMPLOYEE E
      JOIN EMPLOYEE EM ON (E.EMP_ID = EM.MANAGER_ID))
GROUP BY ������, ����̸�
ORDER BY ������;



--���� 5)
-- �μ��� �ټӳ���� ���� ������ ����� ã�� �ش� ����� ���, �����, �μ���, ���޸�, �Ի����� ��ȸ�Ͻÿ�.
SELECT DEPT_CODE, EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE
FROM EMPLOYEE E
LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE HIRE_DATE IN (SELECT MIN(HIRE_DATE)
                           FROM EMPLOYE
                           GROUP BY DEPT_CODE);


--���� 5)
-- �系 ������Ƽ�� �̺�Ʈ! �̹� ������Ƽ�� 3,4,5�����鸸 �����Ѵ�.
-- �̹� ������Ƽ ���ΰ����� ���, �����, �ֹι�ȣ, �μ���, ���޸�, �ٹ������� ��ȸ�Ͻÿ�.
-- ��, �ֹι�ȣ�� ���ڸ��� �����Ѵ�. ���ڸ��� ��� *ó��.
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO,1,7),14,'*') �ֹι�ȣ, DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM EMPLOYEE E 
LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE SUBSTR(EMP_NO,3,2) IN (03,04,05);


-- ���� 6)
-- ȸ�翡�� �������� ��������� ���� ���� �̺�Ʈ!
-- �� ���� ȸ��â�� 30�ֳ��� ����Ͽ� �ֹε�Ϲ�ȣ�� 3�� 0�� ���� �������� ������ ������ �����ϱ���ߴ�.
-- �ֹε�Ϲ�ȣ�� 3�� 0�� ���� ������ ������ ��ȸ�Ͻÿ�.
SELECT *
FROM EMPLOYEE
WHERE EMP_NO LIKE '%0%' AND EMP_NO LIKE '%3%';

-- ���� 7)
-- �� ����� �ñ��� ����Ͽ� �����ȣ, ����̸�, �ñ��� ��ȸ�ÿ�.
-- ���� 1. �� �� �ٹ��� ���� 25��, �Ϸ� �ٹ��ð��� 9�ð��̴�.
-- ���� 2. �Ҽ��� �ڸ��� ���ְ� �� �� �ڸ����� 0���� ��Ÿ���Բ�!
-- ���� 3. �ñ��� ���� ������ ����
SELECT EMP_ID, EMP_NAME, TRUNC/*/ROUND*/(SALARY/25/9,-1) �ñ�
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- SALARY / 25 / 9

-- �μ��� �޿� ���� ���� ū �μ� �ϳ����� ��ȸ �μ��ڵ�, �μ���, �޿��� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);