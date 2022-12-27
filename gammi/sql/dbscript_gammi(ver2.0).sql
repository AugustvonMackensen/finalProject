DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE FOODINFO CASCADE CONSTRAINTS;
DROP TABLE RECIPE CASCADE CONSTRAINTS;
DROP TABLE NOTICE CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;
DROP TABLE BOARDREPLY CASCADE CONSTRAINTS;
DROP TABLE GROUPMEMBER CASCADE CONSTRAINTS;
DROP TABLE GAMMIGROUP CASCADE CONSTRAINTS;
DROP TABLE CHATROOMJOIN CASCADE CONSTRAINTS;
DROP TABLE CHATROOM CASCADE CONSTRAINTS;
DROP TABLE CHATMESSAGE CASCADE CONSTRAINTS;
DROP TABLE GALLERY CASCADE CONSTRAINTS;
DROP TABLE GALLERYREPLY CASCADE CONSTRAINTS;
DROP TABLE NEWS CASCADE CONSTRAINTS;
DROP TABLE GALLERYIMG CASCADE CONSTRAINTS;
DROP TABLE GAMMICALENDAR CASCADE CONSTRAINTS;

CREATE TABLE MEMBER(
    M_ID                VARCHAR2(50)                PRIMARY KEY,
    M_PW                VARCHAR2(100)             NULL,
    M_EMAIL             VARCHAR2(50)               UNIQUE      NULL,
    M_NAME              VARCHAR2(30)                NULL,
    M_NICKNAME          VARCHAR2(30)               UNIQUE      NULL,
    M_BIRTH             VARCHAR2(50)                NULL,
    ADMIN               VARCHAR2(1)     DEFAULT 'N' NOT NULL,
    LOGIN_OK            VARCHAR2(1)     DEFAULT 'Y' NOT NULL
);

COMMENT ON COLUMN MEMBER.M_ID IS '유저아이디';
COMMENT ON COLUMN MEMBER.M_PW IS '비밀번호';
COMMENT ON COLUMN MEMBER.M_EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.M_NICKNAME IS '이름';
COMMENT ON COLUMN MEMBER.M_NICKNAME IS '유저닉네임';
COMMENT ON COLUMN MEMBER.M_BIRTH IS '생년월일';
COMMENT ON COLUMN MEMBER.ADMIN IS '관리자여부';
COMMENT ON COLUMN MEMBER.LOGIN_OK IS '로그인가능여부';

CREATE TABLE FOODINFO(
    FOOD_NO             NUMBER          GENERATED ALWAYS AS IDENTITY        PRIMARY KEY,
    FOOD_NAME         VARCHAR2(50)                        NOT NULL,
    FOOD_CONTENT    VARCHAR2(5000)                      NOT NULL
);

COMMENT ON COLUMN FOODINFO.FOOD_NO IS '음식번호';
COMMENT ON COLUMN FOODINFO.FOOD_NAME IS '음식명';
COMMENT ON COLUMN FOODINFO.FOOD_CONTENT IS '음식내용';

CREATE TABLE RECIPE (
	RECIPE_NUM	            number generated always as identity PRIMARY KEY,
	RECIPE_TITLE	        varchar2(200)		 UNique   NOT NULL,
	RECIPE_IMG	 varchar2(200)		    NULL,
    RECIPE_URL	 varchar2(200)		    NULL,
    RECIPE_READCOUNT number DEFAULT 0 not null,
    RECIPE_READCOUNT_WEEK number DEFAULT 0 not null
);

COMMENT ON COLUMN RECIPE.RECIPE_NUM IS '레시피번호';
COMMENT ON COLUMN RECIPE.RECIPE_TITLE IS '레시피 제목';
COMMENT ON COLUMN RECIPE.RECIPE_IMG IS '이미지경로';
COMMENT ON COLUMN RECIPE.RECIPE_URL IS '레시피경로';
COMMENT ON COLUMN RECIPE.RECIPE_READCOUNT IS '조회수';
COMMENT ON COLUMN RECIPE.RECIPE_READCOUNT_WEEK IS '주간조회수';

CREATE TABLE NOTICE (
   NOTICE_NUM               number             generated always as identity PRIMARY KEY,
   NOTICE_WRITER            varchar2(50)      NOT NULL,
   NOTICE_TITLE            varchar2(100)      NOT NULL,
   NOTICE_CONTENT            varchar2(2000)      NOT NULL,
   NOTICE_ORIGINAL_FILENAME   varchar2(200)      NULL,
   NOTICE_RENAME_FILENAME      varchar2(200)      NULL,
   NOTICE_READCOUNT         number            DEFAULT 0   NOT NULL,
   NOTICE_DATE               date            DEFAULT sysdate   NOT NULL
);

COMMENT ON COLUMN NOTICE.NOTICE_NUM IS '공지번호';
COMMENT ON COLUMN NOTICE.NOTICE_WRITER IS '작성자아이디';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '공지제목';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '공지내용';
COMMENT ON COLUMN NOTICE.NOTICE_ORIGINAL_FILENAME IS '원본첨부파일명';
COMMENT ON COLUMN NOTICE.NOTICE_RENAME_FILENAME IS '바뀐첨부파일명';
COMMENT ON COLUMN NOTICE.NOTICE_READCOUNT IS '조회수';
COMMENT ON COLUMN NOTICE.NOTICE_DATE IS '작성날짜';


CREATE TABLE BOARD (
	B_NO	            number GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	B_WRITER	        varchar2(50)		            NOT NULL,
	B_TITLE	            varchar2(200)		            NOT NULL,
	B_DATE	            date	    DEFAULT SYSDATE     NOT NULL,
	B_CONTENT	        varchar2(1000)		            NOT NULL,
	B_UPFILE	        varchar2(1000)		                    ,
	B_READCOUNT	        number	    DEFAULT 0	        NOT NULL,
    B_ORIGINAL_IMAGE	varchar2(2000)		                    ,
	B_RENAME_IMAGE	    varchar2(2000)
);

COMMENT ON COLUMN BOARD.B_NO IS '게시판번호';
COMMENT ON COLUMN BOARD.B_WRITER IS '유저아이디';
COMMENT ON COLUMN BOARD.B_TITLE IS '게시판제목';
COMMENT ON COLUMN BOARD.B_DATE IS '게시판작성날짜';
COMMENT ON COLUMN BOARD.B_CONTENT IS '게시판내용';
COMMENT ON COLUMN BOARD.B_UPFILE IS '첨부파일';
COMMENT ON COLUMN BOARD.B_READCOUNT IS '게시판조회수';
COMMENT ON COLUMN BOARD.B_ORIGINAL_IMAGE IS '게시판원본사진';
COMMENT ON COLUMN BOARD.B_RENAME_IMAGE IS '게시판수정사진';

CREATE TABLE BOARDREPLY(
    BR_NO       NUMBER GENERATED ALWAYS AS IDENTITY     PRIMARY KEY,
    B_NO        NUMBER                  NOT NULL,
    BR_ID       VARCHAR2(50)            NOT NULL,
    BR_DATE     DATE    DEFAULT SYSDATE NOT NULL,
    BR_CONTENT  VARCHAR2(100)           NOT NULL,
    constraint fk_reply_bno foreign key(B_NO) references board(b_no) on delete cascade
);

COMMENT ON COLUMN BOARDREPLY.BR_NO IS '댓글번호';
COMMENT ON COLUMN BOARDREPLY.B_NO IS '원글번호';
COMMENT ON COLUMN BOARDREPLY.BR_ID IS '유저아이디';
COMMENT ON COLUMN BOARDREPLY.BR_DATE IS '댓글작성날짜';
COMMENT ON COLUMN BOARDREPLY.BR_CONTENT IS '댓글내용';

CREATE TABLE GAMMIGROUP(
    GROUP_NO	number generated always as identity PRIMARY KEY,
	GROUP_OWNER	varchar2(50)		                NOT NULL,
    GROUP_NAME  VARCHAR2(50)            UNIQUE    NOT NULL,
	GROUP_DATE	date	DEFAULT SYSDATE	    NOT NULL,
	GROUP_INFO	varchar2(150)		        NOT NULL,
	GROUP_IMG	varchar2(200)		        NULL,
    GROUP_OK    varchar2(1)     DEFAULT 'Y' NOT NULL
);

COMMENT ON COLUMN GAMMIGROUP.GROUP_NO IS '모임번호';
COMMENT ON COLUMN GAMMIGROUP.GROUP_OWNER IS '그룹장아이디';
COMMENT ON COLUMN GAMMIGROUP.GROUP_NAME IS '그룹명';
COMMENT ON COLUMN GAMMIGROUP.GROUP_DATE IS '개설날짜';
COMMENT ON COLUMN GAMMIGROUP.GROUP_INFO IS '모임설명';
COMMENT ON COLUMN GAMMIGROUP.GROUP_IMG IS '그룹이미지';
COMMENT ON COLUMN GAMMIGROUP.GROUP_OK IS '그룹제한여부';

CREATE TABLE GROUPMEMBER(
    JOIN_NO       NUMBER      generated always as identity              PRIMARY KEY,
    GROUP_NO        NUMBER          NOT NULL,
    M_ID            VARCHAR2(50)    NOT NULL,
    MEMBER_GRADE    NUMBER          NOT NULL,
    MEMBER_GRADE_DATE   DATE  DEFAULT SYSDATE NOT NULL
);

COMMENT ON COLUMN GROUPMEMBER.JOIN_NO IS '기본키생성용도';
COMMENT ON COLUMN GROUPMEMBER.GROUP_NO IS '모임번호';
COMMENT ON COLUMN GROUPMEMBER.M_ID IS '유저아이디';
COMMENT ON COLUMN GROUPMEMBER.MEMBER_GRADE IS '유저등급';
COMMENT ON COLUMN GROUPMEMBER.MEMBER_GRADE_DATE IS '등급변경일';

CREATE TABLE GALLERY (
	GAL_NO	    number GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GROUP_NO	number		NOT NULL,
	GAL_ID	    varchar2(50)		NOT NULL,
	GAL_TITLE	varchar2(100)		NOT NULL,
	GAL_DATE	date	DEFAULT SYSDATE	NOT NULL,
	GAL_CONTENT	varchar2(500)		NOT NULL
);

COMMENT ON COLUMN GALLERY.GAL_NO IS '갤러리번호';
COMMENT ON COLUMN GALLERY.GROUP_NO IS '모임번호';
COMMENT ON COLUMN GALLERY.GAL_ID IS '유저아이디';
COMMENT ON COLUMN GALLERY.GAL_TITLE IS '갤러리게시글제목';
COMMENT ON COLUMN GALLERY.GAL_DATE IS '갤러리게시글작성날짜';
COMMENT ON COLUMN GALLERY.GAL_CONTENT IS '갤러리게시글내용';

CREATE TABLE GALLERYREPLY (
	REPLY_NO	number GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GAL_NO	    number		NOT NULL,
	REPLY_ID	    varchar2(50)		NOT NULL,
	REPLY_DATE	    date	DEFAULT SYSDATE	NOT NULL,
	REPLY_CONTENT	varchar2(1000)		NOT NULL
);

COMMENT ON COLUMN GALLERYREPLY.REPLY_NO IS '갤러리댓글번호';
COMMENT ON COLUMN GALLERYREPLY.GAL_NO IS '갤러리번호';
COMMENT ON COLUMN GALLERYREPLY.REPLY_ID IS '갤러리댓글아이디';
COMMENT ON COLUMN GALLERYREPLY.REPLY_DATE IS '갤러리댓글작성날짜';
COMMENT ON COLUMN GALLERYREPLY.REPLY_CONTENT IS '갤러리댓글내용';

CREATE TABLE CHATROOMJOIN(
    JOIN_NO         number		GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    M_ID            VARCHAR2(50)    NOT NULL,
    CHATROOM_NO     NUMBER          NOT NULL,
    CHATJOIN_DATE     DATE     Default SYSDATE NOT NULL
);

COMMENT ON COLUMN CHATROOMJOIN.JOIN_NO IS '기본키생성용도';
COMMENT ON COLUMN CHATROOMJOIN.M_ID IS '유저아이디';
COMMENT ON COLUMN CHATROOMJOIN.CHATROOM_NO IS '채팅방번호';
COMMENT ON COLUMN CHATROOMJOIN.CHATJOIN_DATE IS '가입일자';

CREATE TABLE CHATROOM(
    CHATROOM_NO     NUMBER          PRIMARY KEY,
    GROUP_NO    NUMBER  NOT NULL,
    M_ID            VARCHAR2(50)    NOT NULL,
    CHATROOM_NAME   VARCHAR2(50)    NOT NULL,
    CHATROOM_DATE      DATE     default SYSDATE     NOT NULL
);

COMMENT ON COLUMN CHATROOM.CHATROOM_NO IS '채팅방번호';
COMMENT ON COLUMN CHATROOM.GROUP_NO IS '모임번호';
COMMENT ON COLUMN CHATROOM.M_ID IS '유저아이디';
COMMENT ON COLUMN CHATROOM.CHATROOM_NAME IS '채팅방이름';
COMMENT ON COLUMN CHATROOM.CHATROOM_DATE IS '채팅방생성일';

CREATE TABLE CHATMESSAGE (
	CM_NO	number		GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	M_ID	varchar2(50)		NOT NULL,
	CHATROOM_NO	number		NOT NULL,
	MESSAGE	varchar2(3000)		NOT NULL,
	CM_TIME	DATE	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN CHATMESSAGE.CM_NO IS '채팅방번호';
COMMENT ON COLUMN CHATMESSAGE.M_ID IS '유저아이디';
COMMENT ON COLUMN CHATMESSAGE.CHATROOM_NO IS '채팅방번호';
COMMENT ON COLUMN CHATMESSAGE.MESSAGE IS '채팅메세지';
COMMENT ON COLUMN CHATMESSAGE.CM_TIME IS '메세지시간';

CREATE TABLE GALLERYIMG (
	GALIMG_NO	number GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GAL_NO	    number		NOT NULL,
	GAL_ORI_IMAGE	varchar2(200),
	GAL_RENAME_IMAGE	varchar2(200)
);

COMMENT ON COLUMN GALLERYIMG.GALIMG_NO IS '갤러리이미지번호';
COMMENT ON COLUMN GALLERYIMG.GAL_NO IS '갤러리번호';
COMMENT ON COLUMN GALLERYIMG.GAL_ORI_IMAGE IS '갤러리이미지원본명';
COMMENT ON COLUMN GALLERYIMG.GAL_RENAME_IMAGE IS '갤러리이미지바뀐파일명';

CREATE TABLE NEWS(
    NEWS_NO NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NEWS_TITLE VARCHAR2(200) NOT NULL,
    NEWS_DATE VARCHAR2(200) NOT NULL,
    NEWS_LINK VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN NEWS.NEWS_NO IS '게시글번호';
COMMENT ON COLUMN NEWS.NEWS_TITLE IS '뉴스제목';
COMMENT ON COLUMN NEWS.NEWS_DATE IS '뉴스작성날짜';
COMMENT ON COLUMN NEWS.NEWS_LINK IS '뉴스링크';

create table GAMMICALENDAR(
    CAL_ID NUMBER GENERATED ALWAYS AS IDENTITY     PRIMARY KEY,
    GROUP_NO NUMBER not null,
    CAL_WRITER varchar2(50) not null,
    CAL_TITLE varchar2(100) not null,
    CAL_CONTENT varchar2(1000) not null,
    START_DATE DATE not null,
    END_DATE date not null,
    ALLDAY number(1) not null
);

COMMENT ON COLUMN GAMMICALENDAR.CAL_ID IS '캘린더기본키';
COMMENT ON COLUMN GAMMICALENDAR.GROUP_NO IS '모임번호';
COMMENT ON COLUMN GAMMICALENDAR.CAL_WRITER IS '작성자아이디';
COMMENT ON COLUMN GAMMICALENDAR.CAL_TITLE IS '일정제목';
COMMENT ON COLUMN GAMMICALENDAR.CAL_CONTENT IS '일정내용';
COMMENT ON COLUMN GAMMICALENDAR.START_DATE IS '일정시작일';
COMMENT ON COLUMN GAMMICALENDAR.END_DATE IS '일정종료일';
COMMENT ON COLUMN GAMMICALENDAR.ALLDAY IS 'TRUE_FALSE';


ALTER TABLE NOTICE ADD CONSTRAINT FK_NOTICE_NOTICE_WRITER FOREIGN KEY(
    NOTICE_WRITER
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE BOARD ADD CONSTRAINT FK_BOARD_B_WRITER FOREIGN KEY(
    B_WRITER
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE BOARDREPLY ADD CONSTRAINT FK_BOARDREPLY_BR_ID FOREIGN KEY(
    BR_ID
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE GROUPMEMBER ADD CONSTRAINT FK_GROUPMEMBER_GROUP_NO FOREIGN KEY(
    GROUP_NO
) REFERENCES GAMMIGROUP(
    GROUP_NO
)ON DELETE CASCADE;

ALTER TABLE GROUPMEMBER ADD CONSTRAINT FK_GROUPMEMBER_M_ID FOREIGN KEY(
    M_ID
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE GAMMIGROUP ADD CONSTRAINT FK_GAMMIGROUP_GROUP_OWNER FOREIGN KEY(
    GROUP_OWNER
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE GALLERY ADD CONSTRAINT FK_GALLERY_GROUP_NO FOREIGN KEY(
    GROUP_NO
) REFERENCES GAMMIGROUP(
    GROUP_NO
)ON DELETE CASCADE;

ALTER TABLE GALLERY ADD CONSTRAINT FK_GALLERY_GAL_ID FOREIGN KEY(
    GAL_ID
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE GALLERYREPLY ADD CONSTRAINT FK_GALLERYREPLY_GAL_NO FOREIGN KEY(
    GAL_NO
) REFERENCES GALLERY(
    GAL_NO
)ON DELETE CASCADE;

ALTER TABLE GALLERYREPLY ADD CONSTRAINT FK_GALLERYREPLY_REPLY_ID FOREIGN KEY(
    REPLY_ID
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE GALLERYIMG ADD CONSTRAINT FK_GALLERYIMG_GALLERY_ID FOREIGN KEY(
    GAL_NO
) REFERENCES GALLERY(
    GAL_NO
)ON DELETE CASCADE;

ALTER TABLE CHATROOMJOIN ADD CONSTRAINT FK_CHATROOMJOIN_M_ID FOREIGN KEY(
    M_ID
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE CHATROOMJOIN ADD CONSTRAINT FK_CHATROOMJOIN_CHATROOM_NO FOREIGN KEY(
    CHATROOM_NO
) REFERENCES CHATROOM(
    CHATROOM_NO
)ON DELETE CASCADE;

ALTER TABLE CHATROOM ADD CONSTRAINT FK_CHATROOM_M_ID FOREIGN KEY(
    M_ID
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE CHATROOM ADD CONSTRAINT FK_CHATROOM_GAMMIGROUP FOREIGN KEY(
    GROUP_NO
) REFERENCES GAMMIGROUP(
    GROUP_NO
)ON DELETE CASCADE;

ALTER TABLE CHATMESSAGE ADD CONSTRAINT FK_CHATMESSAGE_M_ID FOREIGN KEY(
    M_ID
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE CHATMESSAGE ADD CONSTRAINT FK_CHATMESSAGE_CHATROOM_NO FOREIGN KEY(
    CHATROOM_NO
) REFERENCES CHATROOM(
    CHATROOM_NO
)ON DELETE CASCADE;

ALTER TABLE GAMMICALENDAR ADD CONSTRAINT FK_GAMMICALENDAR_M_ID FOREIGN KEY(
    CAL_WRITER
) REFERENCES MEMBER(
    M_ID
)ON DELETE CASCADE;

ALTER TABLE GAMMICALENDAR ADD CONSTRAINT FK_GROUPNO_GAMMIGROUP FOREIGN KEY(
    GROUP_NO
) REFERENCES GAMMIGROUP(
    GROUP_NO
)ON DELETE CASCADE;

-----check제약조건 추가
ALTER TABLE MEMBER ADD CONSTRAINT check_admin_y_n CHECK (ADMIN IN ('Y', 'N'));
ALTER TABLE MEMBER ADD CONSTRAINT check_login_ok CHECK (login_ok IN ('Y', 'N'));
ALTER TABLE GAMMIGROUP ADD CONSTRAINT check_group_ok CHECK (group_ok IN ('Y','N'));

-----관리자 등록
INSERT into MEMBER values('admin','$2a$10$w3jdVv6FgyBUXBddDA9gNuKKvjasaniUjDSRSCbB8LsvtoyDNg4Me','admin@admin.com','관리자이름','관리자','11111111','Y','Y');

commit;

-- 회원 샘플 데이터 --
INSERT into MEMBER values('user001','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user001@gammi.com','유저001이름','유저001','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user002','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user002@gammi.com','유저002이름','유저002','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user003','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user003@gammi.com','유저003이름','유저003','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user004','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user004@gammi.com','유저004이름','유저004','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user005','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user005@gammi.com','유저005이름','유저005','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user006','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user006@gammi.com','유저006이름','유저006','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user007','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user007@gammi.com','유저007이름','유저007','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user008','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user008@gammi.com','유저008이름','유저008','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user009','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user009@gammi.com','유저009이름','유저009','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user010','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user010@gammi.com','유저010이름','유저010','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user011','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user011@gammi.com','유저011이름','유저011','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user012','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user012@gammi.com','유저012이름','유저012','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user013','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user013@gammi.com','유저013이름','유저013','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user014','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user014@gammi.com','유저014이름','유저014','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user015','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user015@gammi.com','유저015이름','유저015','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user016','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user016@gammi.com','유저016이름','유저016','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user017','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user017@gammi.com','유저017이름','유저017','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user018','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user018@gammi.com','유저018이름','유저018','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user019','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user019@gammi.com','유저019이름','유저019','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user020','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user020@gammi.com','유저020이름','유저020','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user021','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user021@gammi.com','유저021이름','유저021','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user022','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user022@gammi.com','유저022이름','유저022','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user023','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user023@gammi.com','유저023이름','유저023','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user024','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user024@gammi.com','유저024이름','유저024','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user025','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user025@gammi.com','유저025이름','유저025','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user026','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user026@gammi.com','유저026이름','유저026','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user027','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user027@gammi.com','유저027이름','유저027','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user028','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user028@gammi.com','유저028이름','유저028','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user029','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user029@gammi.com','유저029이름','유저029','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user030','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user030@gammi.com','유저030이름','유저030','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user031','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user031@gammi.com','유저031이름','유저031','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user032','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user032@gammi.com','유저032이름','유저032','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user033','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user033@gammi.com','유저033이름','유저033','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user034','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user034@gammi.com','유저034이름','유저034','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user035','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user035@gammi.com','유저035이름','유저035','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user036','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user036@gammi.com','유저036이름','유저036','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user037','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user037@gammi.com','유저037이름','유저037','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user038','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user038@gammi.com','유저038이름','유저038','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user039','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user039@gammi.com','유저039이름','유저039','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user040','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user040@gammi.com','유저040이름','유저040','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user041','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user041@gammi.com','유저041이름','유저041','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user042','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user042@gammi.com','유저042이름','유저042','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user043','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user043@gammi.com','유저043이름','유저043','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user044','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user044@gammi.com','유저044이름','유저044','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user045','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user045@gammi.com','유저045이름','유저045','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user046','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user046@gammi.com','유저046이름','유저046','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user047','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user047@gammi.com','유저047이름','유저047','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user048','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user048@gammi.com','유저048이름','유저048','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user049','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user049@gammi.com','유저049이름','유저049','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user050','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user050@gammi.com','유저050이름','유저050','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user051','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user051@gammi.com','유저051이름','유저051','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user052','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user052@gammi.com','유저052이름','유저052','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user053','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user053@gammi.com','유저053이름','유저053','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user054','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user054@gammi.com','유저054이름','유저054','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user055','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user055@gammi.com','유저054이름','유저055','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user056','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user056@gammi.com','유저055이름','유저056','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user057','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user057@gammi.com','유저055이름','유저057','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user058','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user058@gammi.com','유저055이름','유저058','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user059','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user059@gammi.com','유저055이름','유저059','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user060','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user060@gammi.com','유저055이름','유저060','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user061','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user061@gammi.com','유저055이름','유저061','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user062','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user062@gammi.com','유저055이름','유저062','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user063','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user063@gammi.com','유저055이름','유저063','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user064','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user064@gammi.com','유저055이름','유저064','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user065','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user065@gammi.com','유저055이름','유저065','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user066','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user066@gammi.com','유저055이름','유저066','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user067','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user067@gammi.com','유저055이름','유저067','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user068','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user068@gammi.com','유저055이름','유저068','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user069','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user069@gammi.com','유저055이름','유저069','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user070','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user070@gammi.com','유저055이름','유저070','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user071','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user071@gammi.com','유저055이름','유저071','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user072','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user072@gammi.com','유저055이름','유저072','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user073','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user073@gammi.com','유저055이름','유저073','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user074','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user074@gammi.com','유저055이름','유저074','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user075','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user075@gammi.com','유저055이름','유저075','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user076','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user076@gammi.com','유저055이름','유저076','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user077','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user077@gammi.com','유저055이름','유저077','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user078','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user078@gammi.com','유저055이름','유저078','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user079','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user079@gammi.com','유저055이름','유저079','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user080','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user080@gammi.com','유저055이름','유저080','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user081','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user081@gammi.com','유저055이름','유저081','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user082','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user082@gammi.com','유저055이름','유저082','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user083','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user083@gammi.com','유저055이름','유저083','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user084','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user084@gammi.com','유저055이름','유저084','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user085','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user085@gammi.com','유저055이름','유저085','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user086','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user086@gammi.com','유저055이름','유저086','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user087','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user087@gammi.com','유저055이름','유저087','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user088','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user088@gammi.com','유저055이름','유저088','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user089','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user089@gammi.com','유저055이름','유저089','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user090','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user090@gammi.com','유저055이름','유저090','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user091','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user091@gammi.com','유저055이름','유저091','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user092','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user092@gammi.com','유저055이름','유저092','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user093','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user093@gammi.com','유저055이름','유저093','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user094','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user094@gammi.com','유저055이름','유저094','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user095','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user095@gammi.com','유저055이름','유저095','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user096','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user096@gammi.com','유저055이름','유저096','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user097','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user097@gammi.com','유저055이름','유저097','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user098','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user098@gammi.com','유저055이름','유저098','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user099','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user099@gammi.com','유저055이름','유저099','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0100','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user100@gammi.com','유저055이름','유저100','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0101','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user101@gammi.com','유저055이름','유저101','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0102','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user102@gammi.com','유저055이름','유저102','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0103','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user103@gammi.com','유저055이름','유저103','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0104','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user104@gammi.com','유저055이름','유저104','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0105','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user105@gammi.com','유저055이름','유저105','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0106','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user106@gammi.com','유저055이름','유저106','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0107','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user107@gammi.com','유저055이름','유저107','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0108','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user108@gammi.com','유저055이름','유저108','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0109','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user109@gammi.com','유저055이름','유저109','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0110','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user110@gammi.com','유저055이름','유저110','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0111','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user111@gammi.com','유저055이름','유저111','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0112','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user112@gammi.com','유저055이름','유저112','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0113','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user113@gammi.com','유저055이름','유저113','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0114','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user114@gammi.com','유저055이름','유저114','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0115','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user115@gammi.com','유저055이름','유저115','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0116','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user116@gammi.com','유저055이름','유저116','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0117','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user117@gammi.com','유저055이름','유저117','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0118','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user118@gammi.com','유저055이름','유저118','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0119','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user119@gammi.com','유저055이름','유저119','000101',DEFAULT,DEFAULT);
INSERT into MEMBER values('user0120','$2a$10$9PWEA7QnN1TEQDStqPT44ugRzwljYXruFUTu4CyEdSJ7ZvcMqTfwK','user120@gammi.com','유저055이름','유저120','000101',DEFAULT,DEFAULT);
commit;

-----그룹 생성 insert문
insert into gammigroup values ( default, 'user001', '테스트용31', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용32', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용33', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용34', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용35', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용36', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용37', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용38', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용39', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용40', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용41', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용42', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용43', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용44', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용45', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용46', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용47', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용48', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용49', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용50', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
commit;
insert into gammigroup values ( default, 'user001', '테스트용51', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용52', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용53', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용54', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용55', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용56', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용57', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용58', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용59', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용60', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용61', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용62', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용63', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용64', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용65', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용66', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용67', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용68', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용69', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용70', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
commit;
insert into gammigroup values ( default, 'user001', '테스트용71', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용72', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용73', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용74', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용75', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용76', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용77', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용78', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용79', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용80', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용81', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용82', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용83', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용84', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용85', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용86', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용87', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용88', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용89', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용90', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
commit;
insert into gammigroup values ( default, 'user001', '테스트용91', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용92', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용93', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용94', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용95', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용96', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용97', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용98', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용99', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용100', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용101', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용102', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용103', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용104', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용105', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용106', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용107', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용108', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용109', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용110', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
commit;
insert into gammigroup values ( default, 'user004', '테스트용111', default, '설명', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user004') , 'user004', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용112', default, '테스트용', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user004', '테스트용113', default, '11', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user004') , 'user004', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용114', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user004', '테스트용115', default, '11', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user004') , 'user004', 4, default);
insert into gammigroup values ( default, 'user003', '테스트용116', default, '33', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user003') , 'user003', 4, default);
insert into gammigroup values ( default, 'user005', '테스트용117', default, '11', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user005') , 'user005', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용118', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용119', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user004', '테스트용120', default, '11', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user004') , 'user004', 4, default);
insert into gammigroup values ( default, 'user003', '테스트용121', default, '33', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user003') , 'user003', 4, default);
insert into gammigroup values ( default, 'user005', '테스트용122', default, '11', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user005') , 'user005', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용123', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용124', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user004', '테스트용125', default, '11', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user004') , 'user004', 4, default);
insert into gammigroup values ( default, 'user003', '테스트용126', default, '33', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user003') , 'user003', 4, default);
insert into gammigroup values ( default, 'user005', '테스트용127', default, '11', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user005') , 'user005', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용128', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용129', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user004', '테스트용130', default, '11', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user004') , 'user004', 4, default);
insert into gammigroup values ( default, 'user003', '테스트용131', default, '33', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user003') , 'user003', 4, default);
insert into gammigroup values ( default, 'user005', '테스트용132', default, '11', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user005') , 'user005', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용133', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용134', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용135', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용136', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user001', '테스트용137', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user001') , 'user001', 4, default);
insert into gammigroup values ( default, 'user002', '테스트용138', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user002') , 'user002', 4, default);
insert into gammigroup values ( default, 'user003', '테스트용139', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user003') , 'user003', 4, default);
insert into gammigroup values ( default, 'user004', '테스트용140', default, '22', null, default);
commit;
insert into groupmember values(default, (select max(group_no) from gammigroup where group_owner='user004') , 'user004', 4, default);
commit;

--공지사항 insert
insert into notice values(default,'admin','첫번째 공지입니다.','첫번째 공지내용입니다.',null,null,default,default);
insert into notice values(default,'admin','두번째 공지입니다.','두번째 공지내용입니다.',null,null,default,default);
insert into notice values(default,'admin','세번째 공지입니다.','세번째 공지내용입니다.',null,null,default,default);
insert into notice values(default,'admin','네번째 공지입니다.','네번째 공지내용입니다.',null,null,default,default);
commit;
--자유게시판 insert
insert into board values(default,'user001','첫번째 게시글입니다.',default,'첫번째 게시글입니다.',null,default,null,null);
insert into board values(default,'user002','두번째 게시글입니다.',default,'두번째 게시글입니다.',null,default,null,null);
insert into board values(default,'user003','세번째 게시글입니다.',default,'세번째 게시글입니다.',null,default,null,null);
insert into board values(default,'user004','네번째 게시글입니다.',default,'네번째 게시글입니다.',null,default,null,null);
commit;