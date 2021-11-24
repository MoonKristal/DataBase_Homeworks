--EMPLOYEE ���̺�κ��� �μ��ڵ尡 D9�� �ƴ� ������� �����, �μ��ڵ� �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';

--EMPLOYEE ���̺��� ���� �������� ������� ���, �̸�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

--EMPLOYEE ���̺��� ���� (�޿� * 12) �� 5000���� �̻��� ������� �̸�, �޿�, ����, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, (SALARY*12)"����", HIRE_DATE
FROM EMPLOYEE
WHERE SALARY * 12 >= 50000000;

-- �޿��� 350���� �̸��̰� 600���� �ʰ��� ������� �̸�, ���, �޿� �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- �Ի����� '90/01/01 ~ 03/01/01'�� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '03/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

-- ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- ��ȭ��ȣ ó�� 3���ڰ� 010�� �ƴ� ������� �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- ����� ���� �μ���ġ�� ���� ���� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- �μ��ڵ尡 D6�̰ų� �Ǵ� D8�̰ų� �Ǵ� D5�� ������� �̸�, �μ��ڵ� �޿�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN('D6', 'D8', 'D5');

-- ������ 'J7'�̰ų� 'J2'�̸鼭 �޿��� 200���� �̻� �޴� ������ 
-- ���, �����, �����ڵ�, �޿�, ���� ��ȸ�ϱ�
SELECT EMP_NO, EMP_NAME, JOB_CODE, SALARY, SALARY*12
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >=2000000;


