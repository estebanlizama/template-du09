use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'ar_doc1sSecgen01')
   drop procedure Analisis2.ar_doc1sSecgen01
go

/* Procedimiento : ar_doc1sSecgen01

     Entrada : @cod_tipdoc,@cod_emisor,@ano,@nro_docum
     Objetivo : Busqueda de archivos universitarios

     Creacion: ELA 2024 / 08 / 29

     */
create procedure  Analisis2.ar_doc1sSecgen01
    @cod_tipdoc tinyint = NULL,
    @cod_emisor smallint = NULL,
    @ano smallint = NULL,
    @nro_docum int = NULL

as
select doc.id_docum, doc.cod_tipdoc, doc.ano, doc.cod_emisor, doc.nro_docum, doc.f_docum, doc.mensaje, doc.observacio,
       doc.cod_estdoc, est.des_estdoc, doc.cod_privac, doc.existe_pdf, doc.tab_mysql, doc.tiene_anex
from archivo_db..ar_doc1 doc
         inner join archivo_db..ar_edoc est on (doc.cod_estdoc = est.cod_estdoc)
 WHERE (@cod_tipdoc IS NULL OR doc.cod_tipdoc = @cod_tipdoc)
      AND (@cod_emisor IS NULL OR doc.cod_emisor = @cod_emisor)
      AND (@ano IS NULL OR doc.ano = @ano)
      AND (@nro_docum IS NULL OR doc.nro_docum = @nro_docum)
      
go
grant execute on Analisis2.ar_doc1sSecgen01 to UsuaVrac
