do
$$
	begin
		if not exists(select * from pg_roles where rolname = 'admin') then
			create role admin with password 'Let me in!' login;
		end if;
	end;
$$;

drop database if exists vitfit WITH (FORCE);
create database vitfit with owner admin;