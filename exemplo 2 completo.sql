CREATE TABLE Filmes(
    id    int      PRIMARY KEY auto_increment,
    titulo VARCHAR(60),
    minutos int
);

delimiter $
create trigger chk_minutos before insert on Filmes
    for each row
    begin
       if new.minutos < 0 then
           set new.minutos = null;
	   end if;
    end$
delimiter ;

Insert into Filmes (titulo, minutos) values ("The terrible trigger", 120);
insert into Filmes (titulo, minutos) values ("0 alto da compadecida", 135);
insert into Filmes (titulo, minutos) values ("Faroeste caboclo",240);
insert into Filmes (titulo, minutos) values ("The matrix",90);
insert into Filmes (titulo, minutos) values ("Blade runner",-88);
insert into Filmes (titulo, minutos) values ("0 labirinto do fauno", 110);
insert into Filmes (titulo, minutos) values ("Metropole",0);
insert into Filmes (titulo, minutos) values ("A lista",120);

delimiter $

create trigger chk_minutos before insert on Filmes
   for each row
   begin
      if new.minutos < 0 then
          
          -- Lançar um Erro
          signal SQLSTATE '45000'        -- exceção não tratada
          set message_text = "Valor inválido para minutos",
          mysql_errno = 2022;            -- código de errro pra controle
          
	   end if;
  end$

delimiter ;

CREATE TABLE Log_deletions (
   id    int    primary key    auto_increment,
   titulo varchar(60),
   quando datetime,
   quem varchar(40)
);


delimiter $
create trigger log_deletions after delete on Filmes
   for each row
   begin
       insert into Log_deletions values (null, old.titulo, sysdate(), user());
   end$
delimiter ;

delete from Filmes where id = 2;
delete from Filmes where id = 4;

select*from Log_deletions;

Insert into Filmes (titulo, minutos) values ("The terrible trigger", 120);
insert into Filmes (titulo, minutos) values ("0 alto da compadecida", 135);
insert into Filmes (titulo, minutos) values ("Faroeste caboclo",240);
insert into Filmes (titulo, minutos) values ("The matrix",90);
insert into Filmes (titulo, minutos) values ("Blade runner",-88);
insert into Filmes (titulo, minutos) values ("0 labirinto do fauno", 110);
insert into Filmes (titulo, minutos) values ("Metropole",0);
insert into Filmes (titulo, minutos) values ("A lista",120);