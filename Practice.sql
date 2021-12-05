/* 
    ���� 1) �����ڵ带 �������� ��� �̻� ���� �̸��� �������� ã�� 
      ���, �����, ���޸��� ��ȸ�϶�
*/
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON(JOB_CODE = JOB_CODE)
WHERE JOB_CODE > 'J5' AND JOB_CODE <= 'J7';
/*
      ���� 2) ȸ�翡�� OFFICE ���α׷��� �ҹ����� ����ϴ� ������ �ΰ��Ǿ���.
      �� ��� ȸ�� ���� �� �����鿡�Ե� å���� �ִٸ� �޿��� 0.1% �� ������ ��ιްڴٰ� �Ѵ�.
      �׷��ٸ� EMPLOYEE ���̺��� Ȱ���Ͽ� ����� ����� ���� �� ���� �ݾ��� 
      ����ϰԵǴ��� ��ȸ�Ͻÿ�.
      ����)   ���        �� ��α�   
            ���ڻ��  (��ȭǥ��)99,760��
            ���ڻ��  (��ȭǥ��)20,336�� 
*/
        
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '���ڻ��', '2', '���ڻ��') ���, 
       TO_CHAR(SUM(SALARY) * 0.001, 'L999,999')||'��' "�� ��α�"  
FROM EMPLOYEE        
GROUP BY SUBSTR(EMP_NO, 8, 1);
        


/*
    ���� 3) EMPLOYEE ���̺���
     �Ŵ��� ���� �����ϴ� ������� ��ȸ�Ͽ� �� �Ŵ����� �����ϴ� ������� �� �ο����� ���Ͽ�, 
     �Ŵ�����, ������� ���� ��ȸ�Ͻÿ�.
     ����)  �Ŵ����� ������� ��
            ������    1��
            �����    2��
*/
SELECT MANAGER_ID
FROM EMPLOYEE
GROUP BY MANAGER_ID;




SELECT �Ŵ��� "�Ŵ�����", COUNT(�������)||'��' "������� ��"
FROM (SELECT E2.EMP_NAME �Ŵ���, E1.EMP_NAME �������
      FROM EMPLOYEE E1
      JOIN EMPLOYEE E2 ON(E1.MANAGER_ID = E2.EMP_ID))
GROUP BY �Ŵ���;

