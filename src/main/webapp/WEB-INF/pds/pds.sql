show tables;

create table pds (
	idx int not null auto_increment, /*자료실 고유번호*/
	mid varchar(30) not null, /*올린 사람 아이디*/
	nickName varchar(30) not null, /*올린사람 닉네임*/
	fName varchar(200) not null, /*업로드시 원본 파일명 보통 이거 자체를 여러개 주는데 우리는 /ㅁㄴㅇ/ㅁㄴㅇ/ 이런식으로 줄거라 용량을 길게 준다*/
	fSName varchar(200) not null, /*실제 서버에 저장되는 파일명*/
	fSize int not null, /*업로드 파일의 총 사이즈*/
	part varchar(20) not null, /*파일 분류(학습/여행/음식/기타)*/
	title varchar(100) not null, /*업로드 파일의 간단한 제목*/
	content text, /*업로드파일의 상세 설명*/
	openSw varchar(3) default '공개', /*파일의 공개여부(공개/비공개)*/
	hostIp varchar(40) not null, /*업로드한 클라이언트 IP*/
	fDate datetime default now(), /*업로드 시킨 날짜*/
	downNum int default 0, /*파일 다운 횟수*/
	primary key(idx),
	foreign key(mid) references member(mid)	
);

desc pds;

