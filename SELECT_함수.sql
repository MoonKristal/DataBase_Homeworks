----- 실습문제 3개! -----
-- 1. 직원명과 주민번호를 조회함
-- 단, 주민번호 9번째 자리부터 끝까지 '*'문자로 채움
-- 예: 홍길동 909090-9*****
SELECT EMP_NAME 직원명, 
    RPAD(SUBSTR(EMP_NO, 1, 8),14,'*') 주민번호
FROM EMPLOYEE;
-- 2. 직원명, 직급코드, 연봉(원) 조회
-- 단, 연봉은 ￦000,000,000으료 표시되게함
-- 연봉은 보너스 적용된 1년치 급여
SELECT EMP_NAME 직원명,
    JOB_CODE 직급코드,
    TO_CHAR((SALARY + (SALARY * NVL(BONUS, 0))) * 12, 'L999,999,999') "연봉(원)"
FROM EMPLOYEE;

-- 3. 부서코드가 D5, D9인 직원들중에서 2004년도에 입사한 직원의 수 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(HIRE_DATE, 1, 2) = '04' 
AND DEPT_CODE IN('D5', 'D9');

---------------------1103숙제----------------
--1번 문제
--EMPLOYEE 테이블에서 사원의 주민 번호를 확인하여 생년 월일을 각각 조회하시오.
--이름 | 생년 | 생월 | 생일
--홍길 | 00년 | 00월 | 00일
SELECT EMP_NAME "이름"
    ,CONCAT(SUBSTR(EMP_NO,1,2),'년')AS "생년"
    ,SUBSTR(EMP_NO,3,2)||'월'"생월"
    ,CONCAT(SUBSTR(EMP_NO,5,2),'일')"생일"
FROM EMPLOYEE;


--2번 문제
--EMPLOYEE 테이블에서 현재 근무하는 여성 사원의 사번, 사원명, 직급코드를 조회 하시오.
--ENT_YN : 현재 근무 여부 파악하는 컬럼 (퇴사 여부)
--WHERE 절에서도 함수 사용이 가능하다.
SELECT EMP_ID"사번",EMP_NAME"사원명",JOB_CODE"직급코드"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN = 'N';


--3번 문제
--EMPLOYEE 테이블에서 '해외영업1부'에 근무하는 모든 사원의 평균 급여, 가장 높은 급여, 낮은 급여, 급여 합계 조회하기
SELECT ROUND(AVG(SALARY)),MAX(SALARY),MIN(SALARY),SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE ='D5' AND ENT_YN = 'N';
-- D5가 해외영업1부


--4번 문제
--부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오. => case 사용
--단, 부서코드가 D5, D6, D9 인 직원의 사원명, 부서코드 부서명만 조회함
--부서코드 기준 오름차순 정렬함.

SELECT EMP_NAME 사원명, DEPT_CODE 부서코드
    , CASE WHEN DEPT_CODE = 'D5' THEN '총무부'
         WHEN DEPT_CODE = 'D6' THEN '기획부'
         ELSE '영업부'
     END 부서명
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY DEPT_CODE ASC;
     