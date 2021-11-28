---------------------- JOIN 종합 실습문제 ----------------------
-- 1. 직급이 대리이면서 ASIA 지역에 근무하는 직원들의
-- 사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_NAME 직급명, DEPT_TITLE 부서명, LOCAL_NAME 근무지역명, SALARY 급여
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE J.JOB_NAME = '대리' AND L.LOCAL_NAME LIKE 'ASIA%';

-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
-- 사원명, 주민번호, 부서명, 직급명을 조회하시오
SELECT EMP_NAME 사원명, EMP_NO 주민번호, DEPT_TITLE 부서명, JOB_NAME 직급명
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE (SUBSTR(EMP_NO,1,1)='7' AND SUBSTR(EMP_NO,8,1)='2')
 AND SUBSTR(EMP_NAME,1,1)='전';

-- 3. 이름에 '형'자가 들어있는 직원들의 
-- 사번, 사원명, 직급명을 조회하시오
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_NAME 직급명
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE  EMP_NAME LIKE '%형%';

-- 4. 해외영업팀에 근무하는 직원들의
-- 사원명, 직급명, 부서코드, 부서명을 조회하시오
SELECT EMP_NAME 사원명, JOB_NAME 직급명, DEPT_CODE 부서코드, DEPT_TITLE 부서명
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE E.DEPT_CODE IN ('D5','D6','D7');

-- 5. 보너스를 받는 직원들의
-- 사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오
SELECT EMP_NAME 사원명, BONUS 보너스, SALARY*12 연봉, DEPT_TITLE 부서명, LOCAL_NAME 근무지역명
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 6. 부서가 있는 직원들의
-- 사원명, 직급명, 부서명, 근무지역명을 조회하시오
SELECT EMP_NAME 사원명, JOB_NAME 직급명, DEPT_TITLE 부서명, LOCAL_NAME 근무지역명
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE E.DEPT_CODE IS NOT NULL;

-- 7. '한국' 과 '일본' 에 근무하는 직원들의
-- 사원명, 부서명, 근무지역명, 근무국가명을 조회하시오
SELECT EMP_NAME 사원명, DEPT_TITLE 부서명, LOCAL_NAME 근무지역명, NATIONAL_NAME 근무국가명
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE L.NATIONAL_CODE IN ('KO', 'JP');


-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7 인 직원들의
-- 사원명, 직급명, 급여를 조회하시오
SELECT EMP_NAME 사원명, JOB_NAME 직급명, SALARY 급여
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE E.JOB_CODE IN ('J4','J7') AND BONUS IS NULL;

-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
-- 이 때, 구분에 해당하는 값은
-- 급여등급이 S1, S2 인 경우 '고급'
-- 급여등급이 S3, S4 인 경우 '중급'
-- 급여등급이 S5, S6 인 경우 '초급' 으로 조회되게 하시오
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_NAME 직급명
        , CASE WHEN SAL_LEVEL IN ('S1','S2') THEN '고급'
        WHEN SAL_LEVEL IN ('S3','S4') THEN '중급'
        ELSE '초급'
    END AS 급여등급
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);


