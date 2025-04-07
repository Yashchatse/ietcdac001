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
delimiter ;*/

drop procedure if exists pro1;
delimiter $
create procedure pro1(in c varchar(1000), in x varchar(64))
begin
	set @a := concat('select ', c ,' from ', x);
	prepare y from @a;
	execute y;
end $
delimiter ;