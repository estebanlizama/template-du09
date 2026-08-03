/* Procedimiento ar_doc1iSecgen10 
 
   Objetivo: Grabar datos de un Documento
             Considera numeración única en 2 modalidades
             Junio 2011 - Diciembre 2011 por Tipo de documento, año y unidad emisora.
             Enero 2012 en adelante por tipo de documento y año.

   Realizado por : Jorge Hott A. 
   Copiado por Jose Luis Rodriguez  desde ar_doc1iArchivo10
    Servidor: CHE
   Fecha : 26/06/2024

   Modificación, ACP, 07/01/2014: Se agrega validación de que la fecha del documento coincida con el año del mismo
   Modificación, ACP, 28/01/2015: Se verifica si hay que grabar en una tabla mysql distinta del default
   Modificación, ACP, 27/05/2015: Verificamos vigencia del administrador
   Modificación, ACP, 24/10/2016: Verificación de que el Nº no esté repetido, si viene el Nº pero no se lleva
                                  la información del último correlativo (¿por qué estaba así"?""?""?""?")
   Modificación, JLRS, 07/03/2019: LEY, DFL, DL, DS, Oficio (cod_tipdoc = 6,7,8,9,14), permiten numeración manual, solo se valida que no exista el archivo.
Modificación, JLRS, 05/07/2024: Solo dejamos numeración automatica y restringimos al uso de resoluciones exentas emitidas por secretaria general 
	 
   Fecha : 10/05/2011
	 
   Tabla de Entrada: 
    - ar_doc1 : Documentos
    - ar_prm2 : Último correlativo según tipo documento y año de proceso (único para toda la Universidad) 
    - ar_prm3 : Último correlativo según tipo documento, emisor y año de proceso
 

   Tabla de Salida: 
    - []
*/ 
 
create procedure Analisis2.ar_doc1iSecgen10 
@rut         char(9)      = null,
@cod_tipdoc  tinyint      = null,
@ano         smallint     = null,
@cod_emisor  smallint     = null,
--@nro_docum   int          = null,
@f_docum     varchar(10)  = null,
@mensaje     varchar(255) = null,
@observacio  varchar(200) = null,
@ubi_fisica  varchar(40)  = null,
@cod_estdoc  tinyint      = null,
@cod_privac  tinyint      = null,
@f_tramitot  varchar(10)  = null,
@mensaje2    varchar(255) = null

as 
/* VALIDACION DE CAMPOS OBLIGATORIOS */

if (@rut IS NULL OR @cod_tipdoc IS NULL OR @ano IS NULL OR @cod_emisor IS NULL OR @f_docum IS NULL OR @cod_estdoc IS NULL OR @cod_privac IS NULL)
BEGIN
    SELECT "Faltan Parámetros, No es posible grabar" error 
    RETURN
END

/* Variables */ 
DECLARE @fecha      datetime,
        @f_tram     datetime,
        @id_docum   int,
        @nro_docum  int,
        @tab_mysql  varchar(15)        -- ACP, 28/01/2015: la tabla mysql para grabar, si no es la default
                        

SELECT @tab_mysql = tab_mysql  FROM archivo_db..ar_prm2  WHERE cod_tipdoc = @cod_tipdoc    AND ano        = @ano
if @@rowcount = 0
BEGIN
   SELECT @tab_mysql = tab_mysql    FROM archivo_db..ar_prm3     WHERE cod_tipdoc = @cod_tipdoc       AND ano        = @ano       AND cod_emisor = @cod_emisor
END
-- END ACP, 28/01/2015




-- determinar si el rut es amdinistrador de documentos
if not exists(SELECT 1 FROM archivo_db..ar_adm1     WHERE rut = @rut   AND vigente = "S")   -- ACP, 27/05/2015
   BEGIN
      SELECT "Ud. no es Administrador de Documentos, No es posible grabar" error 
      return
   END
-- Verifica que el documento sea una resolución exente y el emisor sea secretaria general
if @cod_tipdoc != 3 OR  @cod_emisor !=1  -- JLRS 05-07-2024
   BEGIN
      SELECT "Ud. solo puede registrar resoluciones exentas de secretaria general, No es posible grabar" error 
      return
   END


      -- Para utlizar numeración automática debe existir último correlativo en tabla de parámetros
if not exists ( SELECT 1 FROM archivo_db..ar_prm2   WHERE cod_tipdoc = @cod_tipdoc  AND   ano        = @ano )    AND
   not exists ( SELECT 1 FROM archivo_db..ar_prm3   WHERE cod_tipdoc = @cod_tipdoc  AND   ano        = @ano      AND   cod_emisor = @cod_emisor )
BEGIN
    SELECT "No fue posible generar numeración automática, no existen parámetros definidos para tipo de documento, año y emisor" error 
    return
END

SELECT @fecha = convert(datetime,@f_docum,103)

-- ACP, 07/01/2014: Agregamos validación de que el año del documento coincida con la fecha del mismo
if @ano <> datepart(yy, @fecha)
begin
   SELECT "No coincide la fecha del documento (" + @f_docum + ") con el año del mismo (" + convert(varchar, @ano) + ")" error 
   return
end


if (char_length(@f_tramitot) = 10)
   SELECT @f_tram = convert(datetime,@f_tramitot,103)


BEGIN TRAN
   declare @ult_corr1 int
   declare @ult_corr2 int

   select @id_docum = isnull(id_docum,0) + 1
   from archivo_db..ar_parm holdlock 

   -- Si @nro_docum es nulo se debe obtener de tabla de parametros
   if @nro_docum is null
      begin
         -- en primera instancia se utiliza numeracion por tipo de documento y año
         if exists ( select 1 from archivo_db..ar_prm2  where cod_tipdoc = @cod_tipdoc  and   ano        = @ano )
            begin
               select @ult_corr1 = isnull(nro_docum,0) + 1
               from archivo_db..ar_prm2 holdlock
               where cod_tipdoc = @cod_tipdoc
               and   ano        = @ano 
            end

         if @ult_corr1 is not null
            begin 
               select @nro_docum = @ult_corr1

               -- actualiza ultimo correlativo
               update archivo_db..ar_prm2
               set nro_docum = @ult_corr1
               where cod_tipdoc = @cod_tipdoc
               and   ano        = @ano 

               if @@transtate = 2
                  begin
                     ROLLBACK TRAN
                     select "No se pudo actualizar ultimo correlativo por tipo de documento y año" error
                     return
                  end

            end

         -- Si ultimo correlativo es nulo, se obtiene por tipo de documento, año y emisor
         if @ult_corr1 is null
            and 
            exists ( select 1 from archivo_db..ar_prm3
                     where cod_tipdoc = @cod_tipdoc
                     and   ano        = @ano 
                     and   cod_emisor = @cod_emisor)
            begin
               select @ult_corr2 = isnull(nro_docum,0) + 1
               from archivo_db..ar_prm3 holdlock
               where cod_tipdoc = @cod_tipdoc
               and   ano        = @ano 
               and   cod_emisor = @cod_emisor
            end

         if @ult_corr2 is not null
            begin 
               select @nro_docum = @ult_corr2

               -- actualiza ultimo correlativo
               update archivo_db..ar_prm3
               set nro_docum = @ult_corr2
               where cod_tipdoc = @cod_tipdoc
               and   ano        = @ano 
               and   cod_emisor = @cod_emisor

               if @@transtate = 2
                  begin
                     ROLLBACK TRAN
                     select "No se pudo actualizar ultimo correlativo por tipo de documento, año y emisor" error
                     return
                  end

            end

         -- Si no se logró obtener el numero de documento automatico se termina el proceso
         if @nro_docum is null
            begin
               ROLLBACK TRAN
               select "No se pudo obtener número de documento" error
               return
            end

      end

-- ACP, 28/01/2015: Agregamos la tabla mysql
   -- graba datos del documento
   insert archivo_db..ar_doc1   (id_docum,  cod_tipdoc, ano,    cod_emisor, nro_docum,  f_docum,    mensaje,                observacio, ubi_fisica, cod_estdoc, cod_privac, f_tramitot, tab_mysql)
                        values  (@id_docum, @cod_tipdoc,@ano,   @cod_emisor,@nro_docum, @fecha,     @mensaje + @mensaje2,   @observacio,@ubi_fisica,@cod_estdoc,@cod_privac,@f_tram,    @tab_mysql)

   if @@transtate = 2
      begin
          ROLLBACK TRAN
          select "No se pudo grabar los datos del documento" error
          return
      end

   -- graba registro de estado de documento y registro rut del usuario
   insert archivo_db..ar_doc6 (id_docum,f_estado,cod_estdoc, rut)
   values(@id_docum,getdate(),@cod_estdoc, @rut)

   if @@transtate = 2
      begin
          ROLLBACK TRAN
          select "No se pudo grabar registro de estados del documento" error
          return
      end

   update archivo_db..ar_parm
   set id_docum = @id_docum

   if @@transtate = 2
      begin
          ROLLBACK TRAN
          select "No se pudo grabar los datos del documento" error
          return
      end


COMMIT TRAN


-- si graba, retorna el id del documento
select @id_docum id_docum, @nro_docum nro_docum

return