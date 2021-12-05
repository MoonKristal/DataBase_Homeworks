/* 
    문제 1) 직급코드를 기준으로 사원 이상 과장 미만의 직원들을 찾아 
      사번, 사원명, 직급명을 조회하라
*/
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON(JOB_CODE = JOB_CODE)
WHERE JOB_CODE > 'J5' AND JOB_CODE <= 'J7';
/*
      문제 2) 회사에서 OFFICE 프로그램을 불법으로 사용하다 벌금이 부과되었다.
      그 결과 회사 측은 전 직원들에게도 책임이 있다며 급여의 0.1% 씩 강제로 기부받겠다고 한다.
      그렇다면 EMPLOYEE 테이블을 활용하여 남사원 여사원 각각 총 얼마의 금액을 
      기부하게되는지 조회하시오.
      예시)   사원        총 기부금   
            남자사원  (원화표기)99,760원
            여자사원  (원화표기)20,336원 
*/
        
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자사원', '2', '여자사원') 사원, 
       TO_CHAR(SUM(SALARY) * 0.001, 'L999,999')||'원' "총 기부금"  
FROM EMPLOYEE        
GROUP BY SUBSTR(EMP_NO, 8, 1);
        


/*
    문제 3) EMPLOYEE 테이블에서
     매니저 별로 관리하는 사원들을 조회하여 한 매니저가 관리하는 사원들의 총 인원수를 구하여, 
     매니저명, 관리사원 수로 조회하시오.
     예시)  매니저명 관리사원 수
            송종기    1명
            유재식    2명
*/
SELECT MANAGER_ID
FROM EMPLOYEE
GROUP BY MANAGER_ID;




SELECT 매니저 "매니저명", COUNT(관리사원)||'명' "관리사원 수"
FROM (SELECT E2.EMP_NAME 매니저, E1.EMP_NAME 관리사원
      FROM EMPLOYEE E1
      JOIN EMPLOYEE E2 ON(E1.MANAGER_ID = E2.EMP_ID))
GROUP BY 매니저;

