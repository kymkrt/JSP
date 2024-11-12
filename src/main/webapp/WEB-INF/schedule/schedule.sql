show tables;

create table schedule(
	idx int not null auto_increment, /*스케줄 관리 고유번호*/
	mid varchar(20) not null,/*회원 아이디*/
	sDate datetime not null, /*일정이 있는 날자*/
	part varchar(10) not null, /*일정분류(1.모임,2.업무,3학습,4여행,5기타)*/
	content text not null, /*일정 상세내역*/
	primary key(idx),
	foreign key(mid) references member(mid)
);

desc schedule;

insert into schedule values (default, 'admin', '2024-9-5', '학습', 'JSP 컨트롤러');
insert into schedule values (default, 'admin', '2024-11-10', '학습', '프로젝트 기획서 설계');
insert into schedule values (default, 'admin', '2024-11-11', '모임', '프로젝트 제작');
insert into schedule values (default, 'admin', '2024-11-12', '업무', '스케줄 면접보기');
insert into schedule values (default, 'admin', '2024-11-13', '여행', '서울 바로보기');
insert into schedule values (default, 'admin', '2024-11-13', '여행', '치킨먹기');
insert into schedule values (default, 'admin', '2024-11-09', '기타', '프로젝트 예정');
insert into schedule values (default, 'admin', '2024-11-20', '여행', '백엔드 자바네트워크');
insert into schedule values (default, 'admin', '2024-10-30', '기타', '프로젝트 그리미쉬쉐이크');
insert into schedule values (default, 'admin', '2024-11-30', '모임', '버거킹');
insert into schedule values (default, 'admin', '2024-11-30', '모임', '카에프체');
insert into schedule values (default, 'admin', '2024-11-30', '학습', '맥도날드');
insert into schedule values (default, 'admin', '2024-12-10', '기타', '프로젝트 그리미쉬쉐이크');
insert into schedule values (default, 'admin', '2024-12-01', '학습', 'buttercup');
insert into schedule values (default, 'qtom123', '2024-11-20', '기타', '그리미쉬쉐이크');
insert into schedule values (default, 'qtom123', '2024-11-10', '여행', '백룸 그리미쉬쉐이크');
insert into schedule values (default, 'qtom123', '2024-11-01', '모임', '데이지');

select * from schedule order by idx desc;
select * from schedule where mid='admin' order by idx desc;
/*DB는 인덱스 번호가 1부터 시작*/
select * from schedule where mid='admin' and substring(sDate, 1, 10)='2024-11-12' order by idx desc;
/*DB저장된건 한자리 숫자앞에 0이 붙기 때문에 한자리숫자면 앞에 0을 붙여줘야 한다*/
select * from schedule where mid='admin' and substring(sDate, 1, 10)='2024-12-1' order by idx desc; (X:검색불가)
select * from schedule where mid='admin' and date_format(sDate, '%Y-%m-%d')='2024-12-01' order by idx desc;
select * from schedule where mid='admin' and date_format(sDate, '%Y-%m-%d')='2024-12-1' order by idx desc;(X:검색불가)

select * from schedule where mid='admin' and date_format(sDate, '%Y-%m')='2024-11' order by idx desc;
select * from schedule where mid='admin' and date_format(sDate, '%Y-%m')='2024-9' order by idx desc;(X:검색불가)
select * from schedule where mid='admin' and date_format(sDate, '%Y-%m')='2024-09' order by idx desc;
select * from schedule where mid='admin' and date_format(sDate, '%Y-%m')='2024-11' order by sDate;
select * from schedule where mid='admin' and date_format(sDate, '%Y-%m')='2024-11' order by sDate, part;
select *, count(*) from schedule where mid='admin' and date_format(sDate, '%Y-%m')='2024-11' order by sDate, part;
select *, count(*) from schedule where mid='admin' and date_format(sDate, '%Y-%m')='2024-11' group by sDate order by sDate, part;
select *, count(*) from schedule where mid='admin' and date_format(sDate, '%Y-%m')='2024-11' group by sDate, part order by sDate, part;
select *, count(*) from schedule where mid='admin' and date_format(sDate, '%Y-%m-%d')='2024-11-30' group by sDate, part order by sDate, part;

