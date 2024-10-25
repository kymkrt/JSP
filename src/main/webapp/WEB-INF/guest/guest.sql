show databases;
/*연결됐는지 확인*/
show tables;

/*데이터베이스 설계*/
create table guest (
	idx int not null auto_increment primary key, /*방명록 고유번호*/
	name varchar(20) not null, /*방명록 작성자 성명*/
	content text not null, /*방명록 글 내용 text는 긴 글을 담을때 사용 기본2K. 더 긴것도 있다 */
	email varchar(60), /* 메일주소 */
	homePage varchar(60), /*홈페이지주소(유튜브, 블로그주소)*/
	visitDate datetime default now(), /* 날짜형식은 date 날짜시간형식은 datetime 시스템 날짜 출력함수 now()*/ 	
	hostIp varchar(30) not null /*방문자의 접속 IP 30이면 충분하다*/
);

desc guest;
/* 더미 데이터는 무조건 꽉 채워야 한다*/
insert into guest values (default, '관리자', '방명록 서비스를 시작합니다', 'kthsd@asdf.com', 'http:/www.naver.com', default, '192.168.50.58');

select * from guest;