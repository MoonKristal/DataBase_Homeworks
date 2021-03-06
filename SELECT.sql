--EMPLOYEE 테이블로부터 부서코드가 D9가 아닌 사원들의 사원명, 부서코드 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';

--EMPLOYEE 테이블에서 현재 재직중인 사원들의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

--EMPLOYEE 테이블에서 연봉 (급여 * 12) 이 5000만원 이상인 사원들의 이름, 급여, 연봉, 입사일 조회
SELECT EMP_NAME, SALARY, (SALARY*12)"연봉", HIRE_DATE
FROM EMPLOYEE
WHERE SALARY * 12 >= 50000000;

-- 급여가 350만원 미만이고 600만원 초과인 사원들의 이름, 사번, 급여 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- 입사일이 '90/01/01 ~ 03/01/01'인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '03/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

-- 전화번호 4번째 자리가 9로 시작하는 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- 전화번호 처음 3글자가 010이 아닌 사원들의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 사수도 없고 부서배치도 받지 않은 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 부서코드가 D6이거나 또는 D8이거나 또는 D5인 사원들의 이름, 부서코드 급여
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN('D6', 'D8', 'D5');

-- 직급이 'J7'이거나 'J2'이면서 급여를 200만원 이상 받는 직원의 
-- 사번, 사원명, 직급코드, 급여, 연봉 조회하기
SELECT EMP_NO, EMP_NAME, JOB_CODE, SALARY, SALARY*12
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >=2000000;


