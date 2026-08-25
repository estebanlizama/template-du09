/* 
	Procedimiento es_orgasSecgen01
	
   
   Objetivo:   Firmantes y subrogantes para resoluciones excentas
    Servidor:   CHE
	Autor:      JLRS 
    Fecha :     19/06/2024
*/ 
 
create procedure Analisis2.es_orgasSecgen01
		
as 
create table #firmantes(
    rut_firma   char(9)         not null,   --Rut del firmante
    nom_firma	varchar(100)    not null,   --Nombre del firmante
    ap1_firma	varchar(100)    not null,   --Apellido 1 del firmante
    ap2_firma	varchar(100)    not null,   --Apellido 2 del firmante
    cod_organi	int             null,       --Cargo del firmante (corresponde al cargo que deberia firmar y no al que realmente firma)
    cod_organ2	int             null,       --Cargo del firmante (corresponde al cargo que firma y no al que deberia firmar)
    des_organi	varchar(100)    null,       --Descripcion del Cargo del firmante (corresponde a quien debe firmar)
    des_organ2	varchar(100)    null,       --Descripcion del Cargo del firmante (corresponde a quien firma)
    subrogante  char(1)         null,       --Marca si es subrogante o no
    prioridad   tinyint         null        --prioridad de subrrogancia
)

INSERT INTO #firmantes
SELECT      a.rut_person, CASE WHEN len(isnull(c.nom_dest, "")) <= 1 THEN c.nom_nombre ELSE c.nom_dest END AS nom_nombre, c.nom_appate, c.nom_apmate, a.cod_organi, a.cod_organi cod_organ2, b.des_organi, b.des_organi des_organ2, 'N' subrogante, 1 as prioridad
FROM        sisper_db..sp_orco a, ufro_db..es_orga b, sisper_db..sp_pers c
WHERE   a.cod_organi        =   b.cod_organi
        AND a.rut_person    =   c.rut_person
		and b.cod_organi    in  (1,39,73)
		and a.vigente       =   "S"
		and b.cod_tiporg    =   1
		and b.por_contra    =   "S"	
UNION
SELECT      a.rut_person, CASE WHEN len(isnull(c.nom_dest, "")) <= 1 THEN c.nom_nombre ELSE c.nom_dest END AS nom_nombre, c.nom_appate, c.nom_apmate, a.cod_organi, a.cod_organi cod_organ2, b.des_organi, b.des_organi des_organ2, 'N' subrogante, 1 as prioridad
FROM        sisper_db..sp_orde a, ufro_db..es_orga b, sisper_db..sp_pers c
WHERE   a.cod_organi        =   b.cod_organi
        AND a.rut_person    =   c.rut_person
		and b.cod_organi    in  (1,39,73)
		and a.vigente       =   "S"
		and b.cod_tiporg    =   1
		and b.por_contra    =   "S"	
UNION
SELECT      a.rut_person, CASE WHEN len(isnull(c.nom_dest, "")) <= 1 THEN c.nom_nombre ELSE c.nom_dest END AS nom_nombre, c.nom_appate, c.nom_apmate, d.cod_organi, d.cod_organ2, e.des_organi, b.des_organi as des_organ2, 'S' subrogante, d.prioridad+ 1 as prioridad
FROM        sisper_db..sp_orco a, ufro_db..es_orga b, sisper_db..sp_pers c, sisper_db..sp_aufi d, ufro_db..es_orga e
WHERE       a.cod_organi    =   b.cod_organi
        AND a.rut_person    =   c.rut_person
        AND b.cod_organi    =   d.cod_organ2
        AND e.cod_organi    =   d.cod_organi
		and d.cod_organi    in  (1,39,73)
		and a.vigente       =   "S"
		and b.cod_tiporg    =   1
		and b.por_contra    =   "S"
UNION
SELECT      a.rut_person, CASE WHEN len(isnull(c.nom_dest, "")) <= 1 THEN c.nom_nombre ELSE c.nom_dest END AS nom_nombre, c.nom_appate, c.nom_apmate, d.cod_organi, d.cod_organ2, e.des_organi, b.des_organi as des_organ2, 'S' subrogante, d.prioridad+ 1 as prioridad
FROM        sisper_db..sp_orde a, ufro_db..es_orga b, sisper_db..sp_pers c, sisper_db..sp_aufi d, ufro_db..es_orga e
WHERE       a.cod_organi    =   b.cod_organi
        AND a.rut_person    =   c.rut_person
        AND b.cod_organi    =   d.cod_organ2
        AND e.cod_organi    =   d.cod_organi
		and d.cod_organi    in  (1,39,73)
		and a.vigente       =   "S"
		and b.cod_tiporg    =   1
		and b.por_contra    =   "S"		
ORDER BY cod_organi, prioridad
SELECT rut_firma, nom_firma, ap1_firma, ap2_firma, cod_organi, cod_organ2, des_organi, des_organ2, subrogante, prioridad FROM #firmantes
