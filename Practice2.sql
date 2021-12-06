/*
개발팀의 실수로 사원들의 연락처가 유출되었습니다.
      모든 사원들의 연락처 뒤 4자리를 '*'로 채우고
      (연락처가 없는 사람들은 고려하지 않음)
      사번, 사원이름, 연락처, 부서명을 조회하는 쿼리문을 작성하시오.
*/
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(PHONE,1,7), 11,'*') 폰번호, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
/*
연락처를 수정하다 보니, 011, 017 번호를 쓰는 직원들을 위해
최신 갤럭시 노트 10+를 회사 복지 차원으로 지급하기로 했다.
연락처가 '011', '017'로 시작하는 직원들의 사번, 사원명, 연락처, 부서명, 직급명을
조회하고 연락처를 '010'으로 시작하는 번호로 수정하는 쿼리문을 작성하시오.
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
근속연수 별 사원들의 연봉통계를 내고자 한다.
EMP_COPY_TEST에서 근속연수별 사원들의
근속연수가 10년 이상인 사원들의
근속연수별 평균급여과 최고급여를 구하여, 근속연수별 내림차순으로 정렬하시오.
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
기술지원부의 인원이 부족하여 부서가 없는 직원들을 기술지원부로 데려오기로 결정하였다.
부서가 없는 직원들을 기술지원부로 이동한 후
기술지원부의 사번 사원명 급여 직급명 부서명을 조회하시오.
*/

SELECT * FROM DEPARTMENT;

UPDATE EMPLOYEE SET DEPT_CODE = 'D8'
WHERE DEPT_CODE IS NULL;

SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '기술지원부';