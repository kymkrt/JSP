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


