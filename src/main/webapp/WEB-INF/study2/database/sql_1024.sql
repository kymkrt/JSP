/* 기본키(Primary key) 
	테이블을 대표하는 키, 중복을 허용하지 않음
    기본키는 1개를 설정할수 있으나 2개이상의 필드로 기본키를 설정할수도 있음
*/
create table test1 (
	idx int not null auto_increment primary key,
    name varchar(20) not null,
    age int default 20,
    address varchar(50)   
);
desc test1;
drop table test1; -- 구조 자체를 지움

select * from test1;
delete from test1;-- 내용을 지움

insert into test1 values(default, '홍길동', default, '서울');
insert into test1 values(default, '김말숙', 30, '청주');
insert into test1 values(default, '이기자', 44, '제주');
insert into test1 values(default, '오하늘', 21, '서울');

create table test2 (
	idx int not null,
    name varchar(20) not null,
    age int default 20,
    test2Code varchar(10) not null, -- sql에서는 대소문자 구별안함  
    primary key(name, test2Code) -- 이렇게 키를 나중에 줘도 됨
);
desc test2;
drop table test2; -- 구조 자체를 지움

create table test3 (
	idx int not null auto_increment,
    name varchar(20) not null,
    age int default 20,
    test3Code varchar(10) not null, -- sql에서는 대소문자 구별안함  
    primary key(idx), -- 이렇게 키를 나중에 줘도 됨
    unique key(test3Code)
);
desc test3;
drop table test3;
select * from test3;

insert into test3 values (default, '홍길동', default, 'a123');
insert into test3 values (2, '홍길자', default, 'b123');
insert into test3 values (5, '홍길자', default, 'c123'); -- 유니크 키는 중복 불가
insert into test3 values (default, '홍길자', default, 'd123');

/* 외래키(foreign key)
	하나의 테이블에서 다른테이블의 정보를 찾기위해서 연결해주는 역할을 하는 키를 말한다
    조건, 외래키로 지정하기 위해서는 상대쪽 테이블의 해당필드가 반드시 중복되지 않는 primary key, unique key로 되어있어야 한다
    속성도 같아야 한다 
*/
create table test4 (
	idx int not null auto_increment  primary key,
    name varchar(20) not null,
    age int default 20,
    test2Code varchar(10) not null,
    test3Code varchar(10) not null, -- sql에서는 대소문자 구별안함  
    --          여긴 속성만 같으면 됨       여긴 다 같아야 함 
    foreign key (test3Code) references test3 (test3Code),
    foreign key (name, test2Code) references test2 (name, test2Code)
);
desc test4;