CREATE TABLE MEMBER (
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);

INSERT INTO MEMBER VALUES('user01', 'pass01', '홍길동', '2021-02-01');
INSERT INTO MEMBER VALUES('user02', 'pass02', '김길동', SYSDATE);
INSERT INTO MEMBER VALUES('user03', 'pass03', '이길동', '21/02/02');

CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

INSERT INTO MEM_NOTNULL
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hgd@naver.com');
INSERT INTO MEM_NOTNULL
VALUES (2, NULL, NULL, NULL, NULL, NULL, NULL); -- NOT NULL 제약조건에 위배 오류발생!
INSERT INTO MEM_NOTNULL
VALUES (2, 'user02', 'pass02', '김길동', NULL, NULL, NULL);
-- NOT NULL 제약조건이 부여되어있는 컬럼에는 반드시 값이 존재해야 함
INSERT INTO MEM_NOTNULL
VALUES (3, 'user01', 'pass03', '순순이', '여', NULL, NULL);

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 컬럼레벨 방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE (MEM_ID) -- 테이블레벨 방식
);

CREATE TABLE MEM_CON_NM(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL,--컬럼레벨방식
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID)--테이블레벨방식
);

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE NOT NULL
);

CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    -- CONSTRAINT MEM_PK PRIMARY KEY(MEM_NO) <- 테이블 레벨 방식
);

INSERT INTO MEM_PRIMARYKEY1 VALUES(1, 'user01', 'pass01', '홍길동', '남', NULL, NULL);
INSERT INTO MEM_PRIMARYKEY1 VALUES(1, 'user02', 'pass02', '김길동', NULL, NULL, NULL);
-- 기본기 컬럼에 중복으로 인한 오류!!!
INSERT INTO MEM_PRIMARYKEY1 VALUES(NULL, 'user02', 'pass02', '김길동', NULL, NULL, NULL);
-- 기본기 컬럼에 NULL 값으로 인한 오류!!!

CREATE TABLE MEM_PRIAMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    PRIMARY KEY (MEM_NO, MEM_ID) -- 컬럼을 묶어서 PRIMARY KEY하나로 설정 => 복합키
);

CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);
INSERT INTO MEM_GRADE VALUES('G1', '일반회원');
INSERT INTO MEM_GRADE VALUES('G2', '우수회원');
INSERT INTO MEM_GRADE VALUES('G3', '특별회원');
SELECT * FROM MEM_GRADE;

-- 자식 테이블
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE), -- 컬럼레벨 방식
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    --FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) 테이블 레벨 방식
);

INSERT INTO MEM
VALUES (1, 'user01', 'pass01', '홍길동', 'G1', NULL, NULL, NULL);

INSERT INTO MEM
VALUES (2, 'user02', 'pass02', '김길동', 'G2', NULL, NULL, NULL);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- 자식테이블 (MEM) 중에 G1을 사용하고 있기 때문에 삭제할 수 없음
-- 외래키 제약조건 부여시 삭제옵션을 부여하지 않았음
-- 자식테이블에서 사용하고 있는 값이 있을 경우 삭제가 안되는 "삭제제한옵션"이 걸려있음
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3'; --  자식테이블에 사용되고 있는 값이 아니기 때문에 삭제 가능


