-- 1.
-- MEMBER ���̺��� �����Ͽ�
-- ����� ������ ���� �� �ִ� ���̺� ��ü�� �����,
-- ȸ�� ��ȣ�� NUMBER���·� �⺻Ű �����ϰ�,
-- ȸ�� ���̵�� �ߺ� �Ұ��� �ʼ� �Է� ��������,
-- ȸ�� ��й�ȣ�� �ʼ� �Է� ����,
-- ȸ�� �̸�, ����('M', 'F'),
-- ȸ�� ����ó, ȸ�� ������� ������
-- ���� �� �ִ� �÷��� ���� ���̺��� �����Ͻÿ�.
-- ��, �� �÷��� ���̴� ���� �Ǵ��ϰ�,
-- ���� ������ ���̺� ��������
-- ȸ�� ������ �ּ� 5�� �̻� �����Ͽ� Ȯ���Ͻÿ�.
DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(30) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(30) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE NUMBER,
    BIRTH DATE
);
INSERT INTO MEMBER
VALUES(1,'user01','pass01','��','0102323244',SYSDATE);

INSERT INTO MEMBER
VALUES(2,'user02','pass02','��','0102323245',SYSDATE);

INSERT INTO MEMBER
VALUES(3,'user03','pass03','��','0102323246',SYSDATE);

INSERT INTO MEMBER
VALUES(4,'user04','pass04','��','0102323247',SYSDATE);

INSERT INTO MEMBER
VALUES(5,'user05','pass05','��','0102323248',SYSDATE);

SELECT * FROM MEMBER;

-- 2.
-- ���� ����� �޿� �λ� �ҽ��� ���ص���
-- '���ö', '������', '������', '�ϵ���' �������
-- �ڽŵ鵵 �޿��� ���ʽ��� �λ��� �޶�� �ľ��� �ϰ� �ִ�.
-- ���ö, ������, ������, �ϵ��� ����� �޿���
-- ����� ����� ���� �޿�, ���ʽ��� �����ϴ� UPDATE ������
-- �ۼ��Ͻÿ�.
-- ��, ���� �� ���������� �����Ͽ� �ۼ��� ���ÿ�.
UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY, BONUS
                        FROM EMP_SALARY
                        WHERE EMP_NAME = '�����')
WHERE EMP_NAME IN ('���ö','������','������','�ϵ���');

SELECT * FROM EMP_SALARY;


-- 3
-- ���� ���� �������� �޿� �λ� �ҽ��� �޽������� ����
-- �������� �ƽþ� ������ �ٹ��ϴ� �� �������� �޿��� �λ��� �޶��
-- ������ ����ǰ� �ִ�.
-- �̿� ������ � ���� �޿��� �λ��� �Ұ� ������, ���ʽ��� 0.25 �� �λ���
-- ���ְڴٰ� ���� ��ǥ���� ������ ����� ���Ǹ� ���� �Ǿ���.
-- EMP_SALARY ���̺��� �ƽþ� ������ �ٹ��ϴ� ��� ��������
-- ���ʽ��� 0.25 �� �λ��ϴ� UPDATE ������ �ۼ��Ͻÿ�.

UPDATE EMP_SALARY
SET BONUS = 0.25
WHERE EMP_ID IN (SELECT EMP_ID
                 FROM EMPLOYEE E
                 LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
                 LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
                 WHERE L.LOCAL_NAME LIKE 'ASIA%');

SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
SELECT * FROM EMP_SALARY;
