----- �ǽ����� 3��! -----
-- 1. ������� �ֹι�ȣ�� ��ȸ��
-- ��, �ֹι�ȣ 9��° �ڸ����� ������ '*'���ڷ� ä��
-- ��: ȫ�浿 909090-9*****
SELECT EMP_NAME ������, 
    RPAD(SUBSTR(EMP_NO, 1, 8),14,'*') �ֹι�ȣ
FROM EMPLOYEE;
-- 2. ������, �����ڵ�, ����(��) ��ȸ
-- ��, ������ ��000,000,000���� ǥ�õǰ���
-- ������ ���ʽ� ����� 1��ġ �޿�
SELECT EMP_NAME ������,
    JOB_CODE �����ڵ�,
    TO_CHAR((SALARY + (SALARY * NVL(BONUS, 0))) * 12, 'L999,999,999') "����(��)"
FROM EMPLOYEE;

-- 3. �μ��ڵ尡 D5, D9�� �������߿��� 2004�⵵�� �Ի��� ������ �� ��ȸ
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(HIRE_DATE, 1, 2) = '04' 
AND DEPT_CODE IN('D5', 'D9');

---------------------1103����----------------
--1�� ����
--EMPLOYEE ���̺��� ����� �ֹ� ��ȣ�� Ȯ���Ͽ� ���� ������ ���� ��ȸ�Ͻÿ�.
--�̸� | ���� | ���� | ����
--ȫ�� | 00�� | 00�� | 00��
SELECT EMP_NAME "�̸�"
    ,CONCAT(SUBSTR(EMP_NO,1,2),'��')AS "����"
    ,SUBSTR(EMP_NO,3,2)||'��'"����"
    ,CONCAT(SUBSTR(EMP_NO,5,2),'��')"����"
FROM EMPLOYEE;


--2�� ����
--EMPLOYEE ���̺��� ���� �ٹ��ϴ� ���� ����� ���, �����, �����ڵ带 ��ȸ �Ͻÿ�.
--ENT_YN : ���� �ٹ� ���� �ľ��ϴ� �÷� (��� ����)
--WHERE �������� �Լ� ����� �����ϴ�.
SELECT EMP_ID"���",EMP_NAME"�����",JOB_CODE"�����ڵ�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN = 'N';


--3�� ����
--EMPLOYEE ���̺��� '�ؿܿ���1��'�� �ٹ��ϴ� ��� ����� ��� �޿�, ���� ���� �޿�, ���� �޿�, �޿� �հ� ��ȸ�ϱ�
SELECT ROUND(AVG(SALARY)),MAX(SALARY),MIN(SALARY),SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE ='D5' AND ENT_YN = 'N';
-- D5�� �ؿܿ���1��


--4�� ����
--�μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�. => case ���
--��, �μ��ڵ尡 D5, D6, D9 �� ������ �����, �μ��ڵ� �μ��� ��ȸ��
--�μ��ڵ� ���� �������� ������.

SELECT EMP_NAME �����, DEPT_CODE �μ��ڵ�
    , CASE WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
         WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
         ELSE '������'
     END �μ���
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY DEPT_CODE ASC;
     