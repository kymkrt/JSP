select * from hoewon;
select * from hoewon order by name;
select * from hoewon order by age desc;
select * from hoewon order by gender, age desc;


show databases;

use javagroup;

show tables;

select * from hoewon;

/*여러줄 주석*/
-- 한줄주석

-- 테이블 복사(신규테이블 생성시 복사)
create table hoewon2 as select * from hoewon;
select * from hoewon2;

drop table hoewon2;

select * from hoewon where gender='남자';

select * from hoewon where gender != '남자';

select * from hoewon where address = '서울';

select * from hoewon where address = '서울' and gender = '남자';

select name, age, address from hoewon where address = '서울';

select name as 성명, age as 나이, address as 주소 from hoewon where address = '서울';

select name, gender, age from hoewon where gender = '남자';

update hoewon set age = age + 1 where gender = '남자';

select * from hoewon where age <20;

select * from hoewon where age >= 20 and age <= 30;

select * from hoewon where age between 20 and 30;

select * from hoewon where address='서울' or address='청주';

select * from hoewon where address in('서울','청주'); -- in 붙여도 되고 띄어도 되고alter

select * from hoewon where name like '홍%';
select * from hoewon where name like '%자';
select * from hoewon where name like '%자%';

desc hoewon;

insert into hoewon (name, address) value ('씨톰','청주');
insert into hoewon (name, address, age, gender) value ('디톰','서울',35, '남자');
insert into hoewon values (default, '디톰', default, '남자', default, '제주' ); -- 전체 다넣을때는 values 순서도 맞춰야 하고 비우는 부분도 다 default로 해야함 

select * from hoewon where name = '디톰';
delete from hoewon where name = '디톰';

-- DDL(Creat, Drop, alter table)
-- 구조 보기(desc)
desc hoewon;

-- 새로운 필드 추가(add column)
-- hoewon테이블의 직업(job)필드를 가변길이 문자 10자 null허용 
alter table hoewon add column job varchar(10);-- not null만 적용 기본은 null
alter table hoewon add column job varchar(10) default '학생'; -- 처음부터 들어감

-- 필드 삭제 (drop column)
-- hoewon테이블의 직업(job)필드를 삭제alter
alter table hoewon drop column job;

-- 필드 수정(modify column)
-- hoewon테이블의 직업(job)필드에 기본값을 '학생'으로 변경(modify)하시오 기존 데이터에는 안들어감 
alter table hoewon modify column job varchar(10) default '학생';
alter table hoewon modify column jikup varchar(10) default '학생';

-- 필드 이름 수정(change column)
-- hoewon테이블의 직업(job)필드명을 jikup으로 변경하시오
alter table hoewon change column job jikup varchar(10);

-- auto_increment 제어하기 
-- 확인
-- (X)show table status where idx = 'hoewon';
show table status like 'hoewon';

-- auto_increment 초기화(변경)
-- 자료를 다 지우고 나서 번호를 이걸로 새로 애야한다
alter table hoewon auto_increment = 28; -- 이미 있는거에는 안들어감 에러는 안난다

-- 남자들을 모두 삭제 33
select * from hoewon where gender = '남자';
delete from hoewon where gender = '남자';

select * from hoewon where name like '%톰%';
delete from hoewon where name like '%톰%';
delete from hoewon where idx = 34;

/* ------------------*/

set @count=0;
select * from hoewon;
update hoewon set age=@count:=@count+1;
-- (X)update hoewon set idx=@count:=@count+1; -- idx는 auto_increment(기본키)라 중복되는 값이 생겨서 안됨
alter table hoewon add column num int;
update hoewon set num=@count:=@count+1;