select*from hakkwa;
select*from student;

/* 학과(hakkwa) 테이블 */
create table hakkwa (
	code int not null, /*학과 코드*/
    name VARCHAR(20), /*학과명*/
    PRIMARY KEY(code),
    UNIQUE KEY(name)
);
desc hakkwa;
drop table hakkwa;

insert into hakkwa values (101, '컴퓨터공학과');
insert into hakkwa values (102, '멀티미디어과');
insert into hakkwa values (103, '경영학과');
insert into hakkwa values (104, '토목공학과');
insert into hakkwa values (105, '기계공학과');
insert into hakkwa values (106, '영문학과');

select * from hakkwa;

/*학생(student) 테이블*/
create table student (
	st_code int not null auto_increment, /*학생 고유번호*/
	name 	varchar(20) not null, /*학생 이름*/
    age 	int default 20, /*나이*/
    hakkwa_code INT, /*학과 코드*/
    PRIMARY KEY(st_code),
    /*이렇게 연관관계를 해두면 제약조건이 걸려서 원본을 못고침*/
    foreign key(hakkwa_code) references hakkwa(code) /*이 외래키는 레퍼런스에서 유일한키여야한다*/
	on update cascade /* cascade(반영)   set null(null로 채우기)   restrict(수정/삭제 불가) */
    on delete set null
);
desc student;
drop table student;

insert into student values (default, '홍길동', default, 101);
insert into student values (default, '김말숙', default, 101);
insert into student values (default, '이기자', default, 102);
insert into student values (default, '오하늘', default, 102);
insert into student values (default, '김연아', default, 103);
insert into student values (default, '소나무', default, 103);
insert into student values (default, '대나무', default, 104);
insert into student values (default, '고인돌', default, 104);
insert into student values (default, '이사라', default, 105);
insert into student values (default, '강감찬', default, 105);
insert into student values (default, '연습이', default, 106);
insert into student values (default, '강의실', default, 106);

select*from student;

/* 조인(join) - 테이블간의 관련된 필드가 존재해야 한다 */

/*내부조인(Inner Join) - 일반적인 조인을 말한다 */
select * from hakkwa inner join student on hakkwa.code = student.hakkwa_code;
select * from hakkwa join student on hakkwa.code = student.hakkwa_code;
select * from hakkwa as h inner join student as s on h.code = s.hakkwa_code;
select * from hakkwa as h, student as s where h.code = s.hakkwa_code;
select * from hakkwa h, student s where h.code = s.hakkwa_code;

-- 학과코드, 학과명, 학생이름 을 출력하시오 
-- 이걸 다 가진 테이블을 없지만 각각을 가진 테이블은 있다
select code, h.name, s.name from hakkwa h, student s where h.code = s.hakkwa_code;

-- 학과코드, 학과명, 학생이름 을 출력하시오 단 컴퓨터 공학과만 출력하시오
select code, h.name, s.name from hakkwa h, student s where (h.code = s.hakkwa_code) and (h.name = '컴퓨터공학과');
select code, h.name, s.name from hakkwa h, student s where h.name = '컴퓨터공학과';
-- 학과코드, 학과명, 학생이름 을 출력하시오 단 컴퓨터 공학과와 기계 공학과만 출력하시오
select code, h.name, s.name from hakkwa h, student s where (h.code = s.hakkwa_code) and ((h.name = '컴퓨터공학과') or (h.name = '기계공학과'));
select code, h.name, s.name from hakkwa h, student s where (h.code = s.hakkwa_code) and (h.name in('컴퓨터공학과','기계공학과'));
-- 학과코드, 학과명, 학생이름 을 출력하시오  단 이씨성을 가진 사람만 출력
select code, h.name, s.name from hakkwa h, student s where h.code = s.hakkwa_code and s.name like '이%';

/* 외부조인(Outer Join)*/

/*크로스조인(교차조인 - Cross Join) : 2개 테이블의 곱집합*/
select*from hakkwa cross join student;
select*from hakkwa, student;

/*Left Outer Join(왼쪽 외부 조인) : 왼쪽 테이블을 기준으로 우측테이블을 참조*/
insert into hakkwa values (200, '성악과');
/*            여기기준 여기Left Outer Join를 기준으로 왼쪽이 기준                 */
select*from hakkwa h Left Outer Join student s on h.code=s.hakkwa_code;

/*Right Outer Join(오른쪽 외부 조인) : 오른쪽 테이블을 기준으로 좌측테이블을 참조*/
/*이러면 성악과 안나옴*/
select*from hakkwa h Right Outer Join student s on h.code=s.hakkwa_code;

/*Full Outer Join - 양쪽 테이블을 모두 기준 테이블로 설정한다(Mysql 지원 안함 사용법은 같음 오라클에 있다)*/
/*Mysql에서의 합집합으로 대치사용 : union(중복배제) / union all(중복허용) - 필드의 갯수를 일치시켜야한다 */
select code from hakkwa union select hakkwa_code from student;
select code from hakkwa union all select hakkwa_code from student;

-- 필드 개수가 일치하지 않으면 error 발생
select * from hakkwa union all select * from student; -- 컬럼(필드)의 갯수가 일치하지 않아서 오류 발생 
/*이렇게 맞춰줘야 하는데 비어있는 부분에 그냥 맞춰서 넣는다 */
select * from hakkwa union all select hakkwa_code, name from student;
select h.*, s.name from hakkwa h, student s where code=hakkwa_code union 
select hakkwa_code,h.name,s.name from hakkwa h, student s where code=hakkwa_code;

create table test1 (
	code int not null primary key,
    name varchar(10)
);

create table test2 (
	idx int not null auto_increment primary key,
    name varchar(10),
    code int,
    foreign key(code) references test1(code)
	on update cascade 
    on delete set null
);

insert into test1 values(1, '가');
insert into test1 values(2, '나');
insert into test1 values(3, '다');
insert into test1 values(4, '라');
insert into test1 values(5, '마');
insert into test1 values(6, '카');
insert into test1 values(7, '타');

insert into test2 (idx, code, name) values(default, 1, '가');
insert into test2 (idx, code, name) values(default, 2, '나');
insert into test2 (idx, code, name) values(default, 3, '바');
insert into test2 (idx, code, name) values(default, 4, '사');
insert into test2 (idx, code, name) values(default, 5, '아');
insert into test2 (idx, code, name) values(default, 1, '자');
insert into test2 (idx, code, name) values(default, 2, '차');

select*from test1;
select*from test2;
delete from test2;

select*from test1 union select * from test2;
select*from test1 union all select * from test2;

select t1.code, t1.name from test1 t1 inner join test2 t2 on t1.code = t2.code;
select t1.code, t1.name from test1 t1, test2 t2 where t1.code = t2.code;

select t1.code, t1.name, t2.name from test1 t1 left join test2 t2 on t1.code = t2.code;
select t1.code, t1.name, t2.name from test1 t1 right join test2 t2 on t1.code = t2.code;

-- 차집합
select t1.code, t1.name, t2.name from test1 t1 left join test2 t2 on t1.code = t2.code where t2.code is null;
select t1.code, t1.name, t2.name from test1 t1 left join test2 t2 on t1.code = t2.code where t2.code is not null;

/*제약 조건에 대한 보기*/
-- 현재 데이터베이스에 설정된 모든 제약조건 확인 
select * from information_schema.TABLE_CONSTRAINTS;
select * from information_schema.TABLE_CONSTRAINTS where CONSTRAINT_SCHEMA='javagroup';