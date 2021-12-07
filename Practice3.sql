/*
문제 1)
연락처를 수정하다 보니, 011, 017 번호를 쓰는 직원들을 위해
최신 갤럭시 노트 10+를 회사 복지 차원으로 지급하기로 했다.
연락처가 '011', '017'로 시작하는 직원들의 사번, 사원명, 연락처, 부서명, 직급명을
조회하고 연락처를 '010'으로 시작하는 번호로 수정하는 쿼리문을 작성하시오.
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
문제 2)
근속연수 별 사원들의 연봉통계를 내고자 한다.
EMP_COPY_TEST에서 근속연수별 사원들의
근속연수가 10년 이상인 사원들의
근속연수별 평균급여과 최고급여를 구하여, 근속연수별 내림차순으로 정렬하시오.
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
문제 3)
기술지원부의 인원이 부족하여 부서가 없는 직원들을 기술지원부로 데려오기로 결정하였다.
부서가 없는 직원들을 기술지원부로 이동한 후
기술지원부의 사번 사원명 급여 직급명 부서명을 조회하시오.
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
WHERE DEPT_TITLE ='기술지원부';


--문제 4)
-- 매니저 번호 별로 그룹화하여 해당 매니저의 사번, 사원명, 휘하 사원들의 급여합계를 조회하시오.
SELECT 사수사번, 사수이름, SUM(사원급여) 사원급여합계
FROM (SELECT E.EMP_ID 사수사번, E.EMP_NAME 사수이름, EM.EMP_ID 사원사번, EM.EMP_NAME 사원이름, EM.SALARY 사원급여
      FROM EMPLOYEE E
      JOIN EMPLOYEE EM ON (E.EMP_ID = EM.MANAGER_ID))
GROUP BY 사수사번, 사수이름
ORDER BY 사수사번;



--문제 5)
-- 부서별 근속년수가 가장 오래된 사원을 찾아 해당 사원의 사번, 사원명, 부서명, 직급명, 입사일을 조회하시오.
SELECT DEPT_CODE, EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE
FROM EMPLOYEE E
LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE HIRE_DATE IN (SELECT MIN(HIRE_DATE)
                           FROM EMPLOYE
                           GROUP BY DEPT_CODE);


--문제 5)
-- 사내 생일파티가 이벤트! 이번 생일파티는 3,4,5월생들만 진행한다.
-- 이번 생일파티 주인공들의 사번, 사원명, 주민번호, 부서명, 직급명, 근무지명을 조회하시오.
-- 단, 주민번호는 앞자리만 공개한다. 뒷자리는 모두 *처리.
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO,1,7),14,'*') 주민번호, DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM EMPLOYEE E 
LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE SUBSTR(EMP_NO,3,2) IN (03,04,05);


-- 문제 6)
-- 회사에서 직원들의 사기충전을 위해 작은 이벤트!
-- 곧 있을 회사창립 30주년을 기념하여 주민등록번호에 3과 0이 들어가는 직원에게 소정의 선물을 증정하기로했다.
-- 주민등록번호에 3과 0이 들어가는 직원의 정보를 조회하시오.
SELECT *
FROM EMPLOYEE
WHERE EMP_NO LIKE '%0%' AND EMP_NO LIKE '%3%';

-- 문제 7)
-- 각 사원별 시급을 계산하여 사원번호, 사원이름, 시급을 조회시오.
-- 조건 1. 한 달 근무일 수는 25일, 하루 근무시간은 9시간이다.
-- 조건 2. 소수점 자리는 없애고 맨 뒷 자리수가 0으로 나타나게끔!
-- 조건 3. 시급이 높은 순으로 정렬
SELECT EMP_ID, EMP_NAME, TRUNC/*/ROUND*/(SALARY/25/9,-1) 시급
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- SALARY / 25 / 9

-- 부서별 급여 합이 가장 큰 부서 하나만을 조회 부서코드, 부서명, 급여합 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);