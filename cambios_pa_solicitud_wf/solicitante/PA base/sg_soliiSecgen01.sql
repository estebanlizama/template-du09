USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_soliiSecgen01'
)
    DROP PROCEDURE Analisis2.sg_soliiSecgen01
GO

/* Procedimiento : Analisis2.sg_soliiSecgen01

   Entrada :
   @rut_solici          -> RUT del solicitante. (Opcional)
   @cod_estsol          -> Codigo de estado de solicitud. (Opcional)
   @cod_tipsol          -> Tipo de solicitud. (Opcional)

   Objetivo : insertar Solicitudes

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/01/27
*/
CREATE PROCEDURE Analisis2.sg_soliiSecgen01 @rut_solici char(9) = NULL,
    @cod_estsol tinyint = NULL,
    @cod_tipsol tinyint = NULL
    as

if @cod_tipsol is null begin
select
    'Falta campo Tipo de solicitud' msg return
end
if @rut_solici is null
    begin
     select 'Falta campo Rut  de solicitante' msg return
end
if @cod_estsol is null
    begin
        select 'Falta campo Codigo Estado de solicitud' msg return
end

begin
    tran
declare @nro_solici int
select
    @nro_solici = max(ultimo_id)
from
    secgen_db..sg_parm
WHERE
    nom_tabla LIKE 'sg_soli'
select
    @nro_solici = isnull(@nro_solici, 0) + 1
update
    secgen_db..sg_parm
set
    ultimo_id = @nro_solici
WHERE
    nom_tabla LIKE 'sg_soli' if @@transtate = 2
    or @@transtate = 3 begin
select
    'Error al actualizar correlativo. Se aborta el procedimiento' msg if @@transtate = 2 rollback tran return
end
insert into
    sg_soli (
        nro_solici,
        cod_tipsol,
        rut_solici,
        f_solicit,
        cod_estsol,
        f_ultmodif,
        f_creacion
    )
values
    (
        @nro_solici,
        @cod_tipsol,
        @rut_solici,
        GETDATE(),
        @cod_estsol,
        GETDATE(),
        GETDATE()
    )
        select @nro_solici as nro_solici
        if @@transtate = 2
    or @@transtate = 3 begin
select
    'Error al actualizar información de validación de proceso. Se aborta el procedimiento' msg if @@transtate = 2 rollback tran return
end commit tran
go
    GRANT EXECUTE ON Analisis2.sg_soliiSecgen01 TO UsuaVrac
go
    