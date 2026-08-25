USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_apsouSecgen01'
)
    DROP PROCEDURE Analisis2.sg_apsouSecgen01
GO

/* Procedimiento : Analisis2.sg_apsouSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Obligatorio)
   @rut_usua            -> RUT del usuario. (Obligatorio)
   @cod_estapr          -> Codigo de estado de aprobacion. (Obligatorio)

   Objetivo : update AprobaciA³n de solicitudes

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/09
*/
CREATE PROCEDURE Analisis2.sg_apsouSecgen01
    @nro_solici int = None,
    @rut_usua char(9) = None,
    @cod_estapr tinyint = None

    as

    if @nro_solici is null
    begin
        select 'Falta campo Numero Resolucion' msg
        return
    end

    if @rut_usua is null
    begin
        select 'Falta campo RUT Usuario' msg
        return
    end

    if @cod_estapr is null
    begin
        select 'Falta campo Codigo Estado Aprobacion' msg
        return
    end

    begin tran

    update sg_apso set rut_usua = @rut_usua, cod_estapr = @cod_estapr,
                       f_aprobac = getDate(), f_ultmodif = getDate()
                       where nro_solici = @nro_solici and rut_usua = @rut_usua

        commit tran
go

GRANT EXECUTE ON Analisis2.sg_apsouSecgen01 TO UsuaVrac
go
