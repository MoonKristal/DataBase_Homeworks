/*
�������� �Ǽ��� ������� ����ó�� ����Ǿ����ϴ�.
      ��� ������� ����ó �� 4�ڸ��� '*'�� ä���
      (����ó�� ���� ������� ������� ����)
      ���, ����̸�, ����ó, �μ����� ��ȸ�ϴ� �������� �ۼ��Ͻÿ�.
*/
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(PHONE,1,7), 11,'*') ����ȣ, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
/*
����ó�� �����ϴ� ����, 011, 017 ��ȣ�� ���� �������� ����
�ֽ� ������ ��Ʈ 10+�� ȸ�� ���� �������� �����ϱ�� �ߴ�.
����ó�� '011', '017'�� �����ϴ� �������� ���, �����, ����ó, �μ���, ���޸���
��ȸ�ϰ� ����ó�� '010'���� �����ϴ� ��ȣ�� �����ϴ� �������� �ۼ��Ͻÿ�.
*/
SELECT EMP_ID, EMP_NAME, PHONE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SUBSTR(PHONE, 1, 3) IN ('011','017');

UPDATE EMPLOYEE
SET PHONE = '0103654485'
WHERE SUBSTR(PHONE, 1, 3) = '011';

UPDATE EMPLOYEE
SET PHONE = '0109964233'
WHERE SUBSTR(PHONE, 1, 3) = '017';

/*
�ټӿ��� �� ������� ������踦 ������ �Ѵ�.
EMP_COPY_TEST���� �ټӿ����� �������
�ټӿ����� 10�� �̻��� �������
�ټӿ����� ��ձ޿��� �ְ�޿��� ���Ͽ�, �ټӿ����� ������������ �����Ͻÿ�.
*/
CREATE TABLE EMP_COPY_TEST
AS SELECT * FROM EMPLOYEE;

SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE),
        AVG(SALARY),
        MAX(SALARY)
FROM EMPLOYEE
GROUP BY EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
HAVING EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >= 10
ORDER BY 1 DESC;


/*
����������� �ο��� �����Ͽ� �μ��� ���� �������� ��������η� ��������� �����Ͽ���.
�μ��� ���� �������� ��������η� �̵��� ��
����������� ��� ����� �޿� ���޸� �μ����� ��ȸ�Ͻÿ�.
*/

SELECT * FROM DEPARTMENT;

UPDATE EMPLOYEE SET DEPT_CODE = 'D8'
WHERE DEPT_CODE IS NULL;

SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '���������';