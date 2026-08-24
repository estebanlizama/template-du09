use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
              where a.uid  = b.uid
                and a.type = 'P'
                and b.name = 'Analisis2'
                and a.name = 'sp_perssSecgen02')
   drop procedure Analisis2.sp_perssSecgen02
go

/* Procedimiento : sp_perssSecgen02

    Entrada  :
    @rut_person --> rut de usuario

    Objetivo : Obtener datos de usuario nombre, unidad y apellidos por rut.

    Creacion:  AI 2023/05/11
    Actualizacion:

*/

create procedure  Analisis2.sp_perssSecgen02
    @rut_person varchar(9) = null
as
    if @rut_person is null
        begin
          select 'Falta rut de la persona. Se aborta el procedimiento' msg
           return
        end


     SELECT per.rut_person, per.nom_nombre, per.nom_appate, per.nom_apmate,
      per.uni_ctadi, per.nom_appate + ' ' + per.nom_apmate + ' ' + per.nom_nombre full_name
    FROM sisper_db..sp_pers per
    WHERE per.rut_person = @rut_person
go

grant execute on Analisis2.sp_perssSecgen02 to UsuaVrac
go

/*
execute secgen_db.Analisis2.sp_perssSecgen02 @rut_person = '164850951'
*/

execute secgen_db.Analisis2.sp_perssSecgen02 @rut_person = '164850951'
