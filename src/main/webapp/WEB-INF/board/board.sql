show databases;
show tables;

create table board(
	idx int not null auto_increment, /*게시글의 고유번호*/
	mid varchar(30) not null, /*게시글 올린이 아이디 닉네임은 변경이 가능하기 때문에 아이디가 있어야 한다 구조가 다른 테이블과 같아야 한다*/
	nickName varchar(30) not null, /*게시글 올린이 닉네임*/
	title varchar(100) not null, /*게시글 제목*/
	content text not null, /* 글 내용*/
	hostIp varchar(40) not null, /*글 올린이 IP*/
	openSw char(3) default '공개', /*공개글 유무(공개, 비공개) 디폴트를 라이도 버튼으로 처리해도 됨*/
  readNum int default 0, /*글 조회수 누적 = 업데이트*/
  good int default 0, /*좋아요 수 누적 = 업데이트*/
	wDate datetime default now(), /*글올린 날짜*/
	claim char(2) default 'NO', /*신고글 유무(신고당한글 : OK, 정상글:NO)*/
  
  
	primary key(idx),
	foreign key(mid) references member(mid)
);

-- drop table board;
desc board;

insert into board values (default, 'admin', '관리맨', '게시판 서비스를 시작합니다', '공개게시판입니다 많이 사랑해주세요', '192.168.50.58', default, default, default, default, default);

select * from board;

select * from board order by idx desc;

select idx, mid, title, datediff(wDate, now()) as date_diff from board order by idx desc;

select idx, mid, title, timestampdiff(hour, wDate, now()) as time_diff from board order by idx desc;

 -- 이전글/다음글 연습
 select idx, title from board where idx < 17 order by idx desc limit 1; -- 이전글
 
 select idx, title from board where idx > 17 order by idx limit 1; -- 다음글
 
 /* 댓글 테이블(boardReply) */
create table boardReply (
	idx      			int not null auto_increment, /*댓글의 고유번호*/
	boardIdx 			int not null, /*원본글(부모글)의 고유번호 - 외래키 지정*/
	mid 					varchar(30) not null, /*댓글 올린이의 아이디 내가 쓴 댓글 모아보기 같은거할때 닉네임을 기준으로 하면 닉네임을 바꿨을때
	 이전에 쓴댓글은 볼수가 없어서 아이디로 해준다*/
	nickName 			varchar(30) not null, /*댓글 올린이의 닉네임*/
	content text 	not null, /*댓글 내용*/
	hostIp 				varchar(50) not null, /*접속자 IP*/
	wDate datetime default now(), /*댓글 올린 날짜*/
	
	primary key(idx),
	foreign key(boardIdx) references board(idx) on update cascade on delete cascade
);

desc boardReply;

select * from board order by idx desc;

insert into boardReply values(default, 25, 'admin', '관리맨', '관리맨 댓글연습', '192.168.50.58', default);
insert into boardReply values(default, 26, 'ftom1234', '에프톰', '에프톰 댓글연습', '192.168.50.58', default);
insert into boardReply values(default, 24, 'gtom124', '지톰', '지톰 댓글연습', '192.168.50.58', default);

select * from boardReply;

select * from board order by idx desc;
select b.*, r.content from board b, boardReply r where b.idx=r.boardIdx order by idx desc;

-- 서브쿼리는 무조건 () 안에.  select안에 select = 서브쿼리
/* 서브쿼리는 3군데 들어갈수 있다 필드절, from절, where 절*/
select b.*, (select count(idx) from boardReply where boardIdx=b.idx) from board b order by idx desc;

