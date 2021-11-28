---------------------- JOIN ���� �ǽ����� ----------------------
-- 1. ������ �븮�̸鼭 ASIA ������ �ٹ��ϴ� ��������
-- ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
SELECT EMP_ID ���, EMP_NAME �����, JOB_NAME ���޸�, DEPT_TITLE �μ���, LOCAL_NAME �ٹ�������, SALARY �޿�
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE J.JOB_NAME = '�븮' AND L.LOCAL_NAME LIKE 'ASIA%';

-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
-- �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
SELECT EMP_NAME �����, EMP_NO �ֹι�ȣ, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE (SUBSTR(EMP_NO,1,1)='7' AND SUBSTR(EMP_NO,8,1)='2')
 AND SUBSTR(EMP_NAME,1,1)='��';

-- 3. �̸��� '��'�ڰ� ����ִ� �������� 
-- ���, �����, ���޸��� ��ȸ�Ͻÿ�
SELECT EMP_ID ���, EMP_NAME �����, JOB_NAME ���޸�
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE  EMP_NAME LIKE '%��%';

-- 4. �ؿܿ������� �ٹ��ϴ� ��������
-- �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
SELECT EMP_NAME �����, JOB_NAME ���޸�, DEPT_CODE �μ��ڵ�, DEPT_TITLE �μ���
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE E.DEPT_CODE IN ('D5','D6','D7');

-- 5. ���ʽ��� �޴� ��������
-- �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_NAME �����, BONUS ���ʽ�, SALARY*12 ����, DEPT_TITLE �μ���, LOCAL_NAME �ٹ�������
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 6. �μ��� �ִ� ��������
-- �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_NAME �����, JOB_NAME ���޸�, DEPT_TITLE �μ���, LOCAL_NAME �ٹ�������
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE E.DEPT_CODE IS NOT NULL;

-- 7. '�ѱ�' �� '�Ϻ�' �� �ٹ��ϴ� ��������
-- �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_NAME �����, DEPT_TITLE �μ���, LOCAL_NAME �ٹ�������, NATIONAL_NAME �ٹ�������
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE L.NATIONAL_CODE IN ('KO', 'JP');


-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7 �� ��������
-- �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
SELECT EMP_NAME �����, JOB_NAME ���޸�, SALARY �޿�
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE E.JOB_CODE IN ('J4','J7') AND BONUS IS NULL;

-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
-- �� ��, ���п� �ش��ϴ� ����
-- �޿������ S1, S2 �� ��� '���'
-- �޿������ S3, S4 �� ��� '�߱�'
-- �޿������ S5, S6 �� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�
SELECT EMP_ID ���, EMP_NAME �����, JOB_NAME ���޸�
        , CASE WHEN SAL_LEVEL IN ('S1','S2') THEN '���'
        WHEN SAL_LEVEL IN ('S3','S4') THEN '�߱�'
        ELSE '�ʱ�'
    END AS �޿����
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);


