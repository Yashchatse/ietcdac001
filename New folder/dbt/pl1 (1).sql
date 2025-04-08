/* drop procedure if exists pro1;
delimiter $
create procedure pro1()
begin
	select 'Hello World' AS "Message Box";
end $
delimiter ;



drop procedure if exists pro1;
delimiter $
create procedure pro1(in x int, in y int, in z int)
begin
	select x + y + z R1;
end $
delimiter ;


drop procedure if exists pro1;
delimiter $
create procedure pro1(in x int, in y int, out z int)
begin
	 set z := x+y;
end $
delimiter ;



drop procedure if exists pro1;
delimiter $
create procedure pro1(in x int, in y int, out z1 int, out z2 int)
begin
	 set z1 := x+y;
	 set z2 := x*y;
end $
delimiter ;


drop procedure if exists pro1;
delimiter $
create procedure pro1(in x int)
begin
	if x >100 THEN
		select 'Good';
	ELSE
		select "Bad";
	end if;
end $
delimiter ;

drop procedure if exists pro1;
delimiter $
create procedure pro1()
begin
	declare cnt int default 0;
	lbl1:LOOP
		set cnt := cnt + 1;
		
		if cnt > 5 THEN
			leave lbl1;
		end if;
		select cnt;
	end loop lbl1;
end $
delimiter ;



drop procedure if exists pro1;
delimiter $
create procedure pro1(x varchar(10))
begin
	declare cnt int default 0;
	
	lbl1:LOOP
		set cnt := cnt + 1;
		
		if cnt > length(x) THEN
			leave lbl1;
		end if;
		select substr(x, cnt, 1);
	end loop lbl1;
end $
delimiter ;



drop procedure if exists pro1;
delimiter $
create procedure pro1(in x int, in y varchar(20))
begin
	insert into d values(x, upper(y));
end $
delimiter ;

drop procedure if exists pro1;
delimiter $
create procedure pro1(in _deptno int, in _dname varchar(20), in _city varchar(20))
begin

	if binary _city = 'BARODA' then
		insert into d values(_deptno, upper(_dname), _city );
	else 
		select "Invalid City";
	end if;
end $
delimiter ;


drop procedure if exists pro1;
delimiter $
create procedure pro1(in x int)
begin
	declare flag BOOLEAN default false;
	select true into flag from emp where empno=x;
	if flag then
		select empno, ename, job,sal from emp where empno = x;
	else
		select "Employee not found...";
	end if;
end $
delimiter ;


drop procedure if exists pro1;
delimiter $
create procedure pro1(in x int)
begin
	
	if (select distinct true from emp where mgr=x) then
		select empno, ename, job,sal from emp where mgr = x;
	else
		select "Employee not found...";
	end if;
end $
delimiter ;
prepare y from @a;
	



drop procedure if exists pro1;
delimiter $
create procedure pro1(in x varchar(64))
begin
	set @a := concat('select * from ', x);
	prepare y from @a;
	execute y;
end $
delimiter ;

drop procedure if exists pro1;
delimiter $
create procedure pro1(in c varchar(1000), in x varchar(64))
begin
	set @a := concat('select ', c ,' from ', x);
	prepare y from @a;
	execute y;
end $
declare ex CONDITION FOR SQLSTATE '42000';
SIGNAL ex SET MESSAGE_TEXT = 'bad';

delimiter ;


drop procedure if exists pro1;
delimiter $
create procedure pro1(in x int)
begin
	declare exit handler for 1062 select "invalie data";
	declare exit handler for 1406  select "Long Data entered.. Pl check";
	if x < 50 then
		insert into dept values(x,'asg',1,1,1);
	end if;
end $
delimiter ;


drop procedure if exists pro1;
delimiter $
create procedure pro1(in w int)
begin
	declare balance int default 5000;
	declare ex condition for sqlstate '42000';
	
	if  w >= balance then
		select "Bad";
	else
		select "Good";
		signal ex set message_text = " Invalid Balance SBI";
	end if;
	select "After If block";
end $
delimiter ;



drop procedure if exists pro1;
delimiter $
create procedure pro1()
begin
	declare v1 int;
	declare v2 varchar(100);
	declare c1 CURSOR for select deptno, dname from dept;
	declare exit handler for 1329 select "No more data to fetch by SALEEL";
	open c1;
		loop
			fetch c1 into v1, v2;
			select v1, v2;
		end loop;
	close c1;
end $
delimiter ;



drop procedure if exists pro1;
delimiter $
create procedure pro1()
begin
	declare _empno, _deptno int;
	declare _ename varchar(10);
	
	declare c1 cursor for select empno, ename, deptno from emp;
	declare exit handler for 1329 select "No more data to fetch by SALEEL";
	open c1;
		loop
			fetch c1 into _empno, _ename, _deptno ;
			if _deptno=10 then
				insert into e10 values(default, _empno, _ename, _deptno);
			elseif _deptno=20 then
				insert into e20 values(default, _empno, _ename, _deptno);
			elseif _deptno=30 then
				insert into e30 values(default, _empno, _ename, _deptno);
			else
				select concat(_deptno , " Say something");
			end if;
		end loop;
	close c1;
end $
delimiter ;





drop procedure if exists pro1;
delimiter $
create procedure pro1()
	b1: begin
		declare x int default 100;
		
		b2:begin
			declare y int default 200;
			select x , y;
		end b2;
	end b1 $
delimiter ;


drop procedure if exists pro1;
delimiter $
create procedure pro1()
	b1: begin
		declare _deptno int;
	    declare _dname, _loc varchar(20);
		declare c1 cursor for select deptno, dname, loc from dept;
		declare exit handler for 1329 select "No more data to fetch by SALEEL";
		open c1;
			loop
				fetch c1 into _deptno, _dname, _loc;
				select _deptno, _dname, _loc;
				select  empno, ename, job, deptno from emp where deptno = _deptno; 
			end loop;
		close c1;
		
		
	end b1 $
delimiter ;

drop procedure if exists display;
delimiter $
create procedure display(msg varchar(1000))
	begin
		select msg R1;
	end $
delimiter ;

drop procedure if exists pro1;
delimiter $
create procedure pro1()
begin
	call display('Hello World');
end $
delimiter ;



drop function if exists fn1;
delimiter $
create function fn1()  returns varchar(1000) deterministic
begin
	return "Hello World by saleel";
end $
delimiter ;



drop function if exists fn1;
delimiter $
create function fn1(x int, y int)  returns int deterministic
begin
	return ifnull(x,0) + ifnull(y,0);
end $
delimiter ;



drop procedure if exists display;
delimiter $
create procedure display(msg varchar(1000))
	begin
	declare a varchar(1000);
		select msg into @w;
	end $
delimiter ;

drop function if exists fn1;
delimiter $
create function fn1()  returns int deterministic
begin
	declare x int default 0;
	
	select max(deptno) + 1 into x from dept;
	call display('baroda');
	return x;
end $
delimiter ;
*/



DROP FUNCTION IF EXISTS fn1;
delimiter $
CREATE FUNCTION fn1() RETURNS VARCHAR(40) deterministic
begin
    declare x, y, z VARCHAR(40) default "";
    declare cnt INT default 1;
    lbl:loop
       SELECT CAST(CHAR(FLOOR(65 + RAND() * 27)) as CHAR) INTO y;
       SELECT CAST(CHAR(FLOOR( 97 + RAND() * 27)) as CHAR) INTO z;
       SET x := CONCAT(x, y, z);
       if cnt > 2 then
          leave lbl;
       end if;
       SET cnt := cnt + 1;
    end loop lbl;
    return(x);
end $
delimiter ;


