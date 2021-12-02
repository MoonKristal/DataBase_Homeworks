-- 1.
-- MEMBER 테이블을 생성하여
-- 사용자 정보를 받을 수 있는 테이블 객체를 만들되,
-- 회원 번호는 NUMBER형태로 기본키 설정하고,
-- 회원 아이디는 중복 불가에 필수 입력 사항으로,
-- 회원 비밀번호는 필수 입력 사항,
-- 회원 이름, 성별('M', 'F'),
-- 회원 연락처, 회원 생년월일 정보를
-- 받을 수 있는 컬럼을 가진 테이블을 생성하시오.
-- 단, 각 컬럼의 길이는 직접 판단하고,
-- 위에 생성된 테이블 기준으로
-- 회원 정보를 최소 5개 이상 삽입하여 확인하시오.
DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(30) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(30) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE NUMBER,
    BIRTH DATE
);
INSERT INTO MEMBER
VALUES(1,'user01','pass01','남','0102323244',SYSDATE);

INSERT INTO MEMBER
VALUES(2,'user02','pass02','여','0102323245',SYSDATE);

INSERT INTO MEMBER
VALUES(3,'user03','pass03','남','0102323246',SYSDATE);

INSERT INTO MEMBER
VALUES(4,'user04','pass04','여','0102323247',SYSDATE);

INSERT INTO MEMBER
VALUES(5,'user05','pass05','남','0102323248',SYSDATE);

SELECT * FROM MEMBER;

-- 2.
-- 방명수 사원의 급여 인상 소식을 전해들은
-- '노옹철', '전형돈', '정중하', '하동운' 사원들이
-- 자신들도 급여와 보너스를 인상해 달라며 파업을 하고 있다.
-- 노옹철, 전형돈, 정중하, 하동운 사원의 급여를
-- 유재식 사원과 같은 급여, 보너스로 수정하는 UPDATE 구문을
-- 작성하시오.
-- 단, 다중 열 서브쿼리로 구현하여 작성해 보시오.
UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY, BONUS
                        FROM EMP_SALARY
                        WHERE EMP_NAME = '유재식')
WHERE EMP_NAME IN ('노옹철','전형돈','정중하','하동운');

SELECT * FROM EMP_SALARY;


-- 3
-- 위와 같은 직원들의 급여 인상 소식이 메스컴으로 통해
-- 퍼져나가 아시아 지역에 근무하는 전 직원들의 급여도 인상해 달라는
-- 시위가 진행되고 있다.
-- 이에 난감한 운영 측은 급여는 인상이 불가 하지만, 보너스는 0.25 로 인상을
-- 해주겠다고 시위 대표자인 선동일 사원과 합의를 보게 되었다.
-- EMP_SALARY 테이블에서 아시아 지역에 근무하는 모든 직원들의
-- 보너스를 0.25 로 인상하는 UPDATE 구문을 작성하시오.

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
