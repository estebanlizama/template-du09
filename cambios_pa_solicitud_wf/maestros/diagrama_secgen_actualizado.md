-- secgen_db.dbo.sg_anso definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_anso;

CREATE TABLE secgen_db.dbo.sg_anso (
	id_antsol tinyint NOT NULL,
	des_antsol varchar(50) NOT NULL,
	CONSTRAINT SG_ANSO_PK PRIMARY KEY (id_antsol)
);
CREATE UNIQUE INDEX PK_sg_anso ON secgen_db.dbo.sg_anso (id_antsol);


-- secgen_db.dbo.sg_caju definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_caju;

CREATE TABLE secgen_db.dbo.sg_caju (
	id_caljur tinyint NOT NULL,
	des_caljur varchar(100) NOT NULL,
	CONSTRAINT SG_CAJU_PK PRIMARY KEY (id_caljur)
);
CREATE UNIQUE INDEX PK_sg_caju ON secgen_db.dbo.sg_caju (id_caljur);


-- secgen_db.dbo.sg_ccbc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_ccbc;

CREATE TABLE secgen_db.dbo.sg_ccbc (
	id_catego tinyint NOT NULL,
	nom_catego varchar(100) NOT NULL,
	CONSTRAINT SG_CCBC_PK PRIMARY KEY (id_catego)
);
CREATE UNIQUE INDEX PK_sg_ccbc ON secgen_db.dbo.sg_ccbc (id_catego);


-- secgen_db.dbo.sg_eapr definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_eapr;

CREATE TABLE secgen_db.dbo.sg_eapr (
	cod_estapr tinyint NOT NULL,
	des_estapr varchar(30) NOT NULL,
	CONSTRAINT SG_EAPR_PK PRIMARY KEY (cod_estapr)
);
CREATE UNIQUE INDEX PK_sg_eapr ON secgen_db.dbo.sg_eapr (cod_estapr);


-- secgen_db.dbo.sg_earc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_earc;

CREATE TABLE secgen_db.dbo.sg_earc (
	cod_estarc tinyint NOT NULL,
	des_estarc varchar(100) NOT NULL,
	CONSTRAINT SG_EARC_PK PRIMARY KEY (cod_estarc)
);
CREATE UNIQUE INDEX PK_sg_earc ON secgen_db.dbo.sg_earc (cod_estarc);


-- secgen_db.dbo.sg_ebco definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_ebco;

CREATE TABLE secgen_db.dbo.sg_ebco (
	id_estbco tinyint NOT NULL,
	nom_estbco varchar(100) NOT NULL,
	CONSTRAINT SG_EBCO_PK PRIMARY KEY (id_estbco)
);
CREATE UNIQUE INDEX PK_sg_ebco ON secgen_db.dbo.sg_ebco (id_estbco);


-- secgen_db.dbo.sg_ecuo definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_ecuo;

CREATE TABLE secgen_db.dbo.sg_ecuo (
	cod_estcuo tinyint NOT NULL,
	des_estcuo varchar(60) NOT NULL,
	CONSTRAINT SG_ECUO_PK PRIMARY KEY (cod_estcuo)
);
CREATE UNIQUE INDEX PK_sg_ecuo ON secgen_db.dbo.sg_ecuo (cod_estcuo);


-- secgen_db.dbo.sg_efun definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_efun;

CREATE TABLE secgen_db.dbo.sg_efun (
	cod_estfun tinyint NOT NULL,
	des_estfun varchar(60) NOT NULL,
	CONSTRAINT SG_EFUN_PK PRIMARY KEY (cod_estfun)
);
CREATE UNIQUE INDEX PK_sg_efun ON secgen_db.dbo.sg_efun (cod_estfun);


-- secgen_db.dbo.sg_eibc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_eibc;

CREATE TABLE secgen_db.dbo.sg_eibc (
	id_esibc tinyint NOT NULL,
	nom_estibc varchar(50) NOT NULL,
	CONSTRAINT SG_EIBC_PK PRIMARY KEY (id_esibc)
);
CREATE UNIQUE INDEX PK_sg_eibc ON secgen_db.dbo.sg_eibc (id_esibc);


-- secgen_db.dbo.sg_ersl definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_ersl;

CREATE TABLE secgen_db.dbo.sg_ersl (
	cod_estres tinyint NOT NULL,
	des_estres varchar(100) NOT NULL,
	CONSTRAINT SG_ERSL_PK PRIMARY KEY (cod_estres)
);
CREATE UNIQUE INDEX PK_sg_ersl ON secgen_db.dbo.sg_ersl (cod_estres);


-- secgen_db.dbo.sg_esol definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_esol;

CREATE TABLE secgen_db.dbo.sg_esol (
	cod_estsol tinyint NOT NULL,
	des_estsol varchar(30) NOT NULL,
	CONSTRAINT SG_ESOL_PK PRIMARY KEY (cod_estsol)
);
CREATE UNIQUE INDEX PK_sg_esol ON secgen_db.dbo.sg_esol (cod_estsol);


-- secgen_db.dbo.sg_inag definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_inag;

CREATE TABLE secgen_db.dbo.sg_inag (
	id_incagr tinyint NOT NULL,
	nom_incagr varchar(100) NOT NULL,
	CONSTRAINT SG_INAG_PK PRIMARY KEY (id_incagr)
);
CREATE UNIQUE INDEX PK_sg_inag ON secgen_db.dbo.sg_inag (id_incagr);


-- secgen_db.dbo.sg_moci definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_moci;

CREATE TABLE secgen_db.dbo.sg_moci (
	id_motcie tinyint NOT NULL,
	des_motcie varchar(100) NOT NULL,
	CONSTRAINT SG_MOCI_PK PRIMARY KEY (id_motcie)
);
CREATE UNIQUE INDEX PK_sg_moci ON secgen_db.dbo.sg_moci (id_motcie);


-- secgen_db.dbo.sg_parm definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_parm;

CREATE TABLE secgen_db.dbo.sg_parm (
	nom_tabla varchar(15) NOT NULL,
	ultimo_id int NOT NULL,
	CONSTRAINT SG_PARM_PK PRIMARY KEY (nom_tabla)
);
CREATE UNIQUE INDEX PK_sg_parm ON secgen_db.dbo.sg_parm (nom_tabla);


-- secgen_db.dbo.sg_perf definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_perf;

CREATE TABLE secgen_db.dbo.sg_perf (
	id_perfil tinyint NOT NULL,
	nom_perfil varchar(80) NOT NULL,
	des_perfil text NULL,
	CONSTRAINT SG_PERF_PK PRIMARY KEY (id_perfil)
);
CREATE UNIQUE INDEX PK_sg_perf ON secgen_db.dbo.sg_perf (id_perfil);


-- secgen_db.dbo.sg_plbc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_plbc;

CREATE TABLE secgen_db.dbo.sg_plbc (
	id_plbaco smallint NOT NULL,
	nom_plbaco varchar(100) NOT NULL,
	vigente char(1) NOT NULL,
	des_plbaco text NULL,
	CONSTRAINT SG_PLBC_PK PRIMARY KEY (id_plbaco)
);
CREATE UNIQUE INDEX PK_sg_plbc ON secgen_db.dbo.sg_plbc (id_plbaco);


-- secgen_db.dbo.sg_plpc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_plpc;

CREATE TABLE secgen_db.dbo.sg_plpc (
	id_plapca smallint NOT NULL,
	nom_plapca varchar(100) NOT NULL,
	vigente char(1) NOT NULL,
	f_creacion datetime NULL,
	f_ultmodif datetime NULL,
	CONSTRAINT SG_PLPC_PK PRIMARY KEY (id_plapca)
);
CREATE UNIQUE INDEX PK_sg_plpc ON secgen_db.dbo.sg_plpc (id_plapca);


-- secgen_db.dbo.sg_plse definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_plse;

CREATE TABLE secgen_db.dbo.sg_plse (
	cod_tipsec tinyint NOT NULL,
	des_tipsec varchar(50) NOT NULL,
	nro_orden tinyint NOT NULL,
	vigente char(1) NOT NULL,
	CONSTRAINT SG_PLSE_PK PRIMARY KEY (cod_tipsec)
);
CREATE INDEX NC_sg_plse_orden ON secgen_db.dbo.sg_plse (nro_orden);
CREATE UNIQUE INDEX PK_sg_plse ON secgen_db.dbo.sg_plse (cod_tipsec);


-- secgen_db.dbo.sg_prm1 definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_prm1;

CREATE TABLE secgen_db.dbo.sg_prm1 (
	ano_proces smallint NOT NULL
);


-- secgen_db.dbo.sg_tacc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_tacc;

CREATE TABLE secgen_db.dbo.sg_tacc (
	id_tipacc tinyint NOT NULL,
	des_accion varchar(50) NOT NULL,
	CONSTRAINT SG_TACC_PK PRIMARY KEY (id_tipacc)
);
CREATE UNIQUE INDEX PK_sg_tacc ON secgen_db.dbo.sg_tacc (id_tipacc);


-- secgen_db.dbo.sg_tdre definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_tdre;

CREATE TABLE secgen_db.dbo.sg_tdre (
	id_tipdev smallint NOT NULL,
	des_tipdev varchar(100) NOT NULL,
	CONSTRAINT SG_TDRE_PK PRIMARY KEY (id_tipdev)
);
CREATE UNIQUE INDEX PK_sg_tdre ON secgen_db.dbo.sg_tdre (id_tipdev);


-- secgen_db.dbo.sg_telm definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_telm;

CREATE TABLE secgen_db.dbo.sg_telm (
	id_tipelm tinyint NOT NULL,
	nom_tipelm varchar(100) NOT NULL,
	CONSTRAINT SG_TELM_PK PRIMARY KEY (id_tipelm)
);
CREATE UNIQUE INDEX PK_sg_telm ON secgen_db.dbo.sg_telm (id_tipelm);


-- secgen_db.dbo.sg_tfls definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_tfls;

CREATE TABLE secgen_db.dbo.sg_tfls (
	cod_flusol tinyint NOT NULL,
	des_flusol varchar(60) NOT NULL,
	abr_flusol varchar(10) NOT NULL,
	vigente char(1) NOT NULL,
	f_creacion datetime NULL,
	f_ultmodif datetime NULL,
	CONSTRAINT SG_TFLS_PK PRIMARY KEY (cod_flusol)
);
CREATE UNIQUE INDEX PK_sg_tfls ON secgen_db.dbo.sg_tfls (cod_flusol);


-- secgen_db.dbo.sg_tipc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_tipc;

CREATE TABLE secgen_db.dbo.sg_tipc (
	id_tipinc tinyint NOT NULL,
	des_tipinc varchar(255) NOT NULL,
	CONSTRAINT SG_TIPC_PK PRIMARY KEY (id_tipinc)
);
CREATE UNIQUE INDEX PK_sg_tipc ON secgen_db.dbo.sg_tipc (id_tipinc);


-- secgen_db.dbo.sg_tmod definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_tmod;

CREATE TABLE secgen_db.dbo.sg_tmod (
	cod_modprs tinyint NOT NULL,
	des_modprs varchar(60) NOT NULL,
	CONSTRAINT SG_TMOD_PK PRIMARY KEY (cod_modprs)
);
CREATE UNIQUE INDEX PK_sg_tmod ON secgen_db.dbo.sg_tmod (cod_modprs);


-- secgen_db.dbo.sg_toca definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_toca;

CREATE TABLE secgen_db.dbo.sg_toca (
	cod_cargo smallint NOT NULL,
	cod_unidad char(8) NOT NULL,
	f_inicio datetime NOT NULL,
	f_termino datetime NULL,
	mto_tope int NOT NULL,
	vigente char(1) NULL,
	CONSTRAINT SG_TOCA_PK PRIMARY KEY (cod_cargo,cod_unidad,f_inicio)
);
CREATE UNIQUE INDEX PK_sg_toca ON secgen_db.dbo.sg_toca (cod_cargo,cod_unidad,f_inicio);


-- secgen_db.dbo.sg_tpag definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_tpag;

CREATE TABLE secgen_db.dbo.sg_tpag (
	cod_tipago tinyint NOT NULL,
	des_tipago varchar(30) NOT NULL,
	CONSTRAINT SG_TPAG_PK PRIMARY KEY (cod_tipago)
);
CREATE UNIQUE INDEX PK_sg_tpag ON secgen_db.dbo.sg_tpag (cod_tipago);


-- secgen_db.dbo.sg_tpps definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_tpps;

CREATE TABLE secgen_db.dbo.sg_tpps (
	cod_tpps int NOT NULL,
	des_tpps varchar(10) NOT NULL,
	CONSTRAINT SG_TPPS_PK PRIMARY KEY (cod_tpps)
);
CREATE UNIQUE INDEX PK_sg_tpps ON secgen_db.dbo.sg_tpps (cod_tpps);


-- secgen_db.dbo.sg_trec definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_trec;

CREATE TABLE secgen_db.dbo.sg_trec (
	id_tiprec tinyint NOT NULL,
	des_tiprec varchar(100) NOT NULL,
	CONSTRAINT SG_TREC_PK PRIMARY KEY (id_tiprec)
);
CREATE UNIQUE INDEX PK_sg_trec ON secgen_db.dbo.sg_trec (id_tiprec);


-- secgen_db.dbo.sg_tsol definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_tsol;

CREATE TABLE secgen_db.dbo.sg_tsol (
	cod_tipsol tinyint NOT NULL,
	des_tipsol varchar(30) NOT NULL,
	nro_orden tinyint NOT NULL,
	vigente char(1) NOT NULL,
	CONSTRAINT SG_TSOL_PK PRIMARY KEY (cod_tipsol)
);
CREATE INDEX NC_sg_tsol_orden ON secgen_db.dbo.sg_tsol (nro_orden);
CREATE UNIQUE INDEX PK_sg_tsol ON secgen_db.dbo.sg_tsol (cod_tipsol);


-- secgen_db.dbo.sg_eta1 definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_eta1;

CREATE TABLE secgen_db.dbo.sg_eta1 (
	cod_flusol tinyint NOT NULL,
	cod_etapa tinyint NOT NULL,
	des_etapa varchar(100) NOT NULL,
	cod_sistem char(2) NOT NULL,
	cod_modulo varchar(8) NOT NULL,
	cod_perfil smallint NOT NULL,
	est_final char(1) NULL,
	vigente char(1) NULL,
	cod_organi int NULL,
	CONSTRAINT SG_ETA1_PK PRIMARY KEY (cod_flusol,cod_etapa),
	CONSTRAINT FK_sg_eta1_sg_tfls FOREIGN KEY (cod_flusol) REFERENCES secgen_db.dbo.sg_tfls(cod_flusol) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_eta1 ON secgen_db.dbo.sg_eta1 (cod_flusol,cod_etapa);


-- secgen_db.dbo.sg_eta2 definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_eta2;

CREATE TABLE secgen_db.dbo.sg_eta2 (
	cod_flusol tinyint NOT NULL,
	cod_etapa1 tinyint NOT NULL,
	cod_etapa2 tinyint NOT NULL,
	id_tipacc tinyint NOT NULL,
	cod_estsol tinyint NULL,
	CONSTRAINT SG_ETA2_PK PRIMARY KEY (cod_flusol,cod_etapa1,id_tipacc),
	CONSTRAINT FK_sg_eta2_sg_esol FOREIGN KEY (cod_estsol) REFERENCES secgen_db.dbo.sg_esol(cod_estsol) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_eta2_eta_ori FOREIGN KEY (cod_flusol,cod_etapa1) REFERENCES secgen_db.dbo.sg_eta1(cod_flusol,cod_etapa) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_eta2_eta_des FOREIGN KEY (cod_flusol,cod_etapa2) REFERENCES secgen_db.dbo.sg_eta1(cod_flusol,cod_etapa) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_eta2_sg_tacc_6 FOREIGN KEY (id_tipacc) REFERENCES secgen_db.dbo.sg_tacc(id_tipacc) ON DELETE RESTRICT ON UPDATE RESTRICT
);


-- secgen_db.dbo.sg_grpc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_grpc;

CREATE TABLE secgen_db.dbo.sg_grpc (
	id_grupca int NOT NULL,
	id_plapca smallint NOT NULL,
	nom_grupca varchar(150) NOT NULL,
	num_orden tinyint NOT NULL,
	num_etique varchar(10) NULL,
	leyenda text NULL,
	CONSTRAINT SG_GRPC_PK PRIMARY KEY (id_grupca),
	CONSTRAINT FK_sg_grpc_sg_plpc FOREIGN KEY (id_plapca) REFERENCES secgen_db.dbo.sg_plpc(id_plapca) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_grpc_pla_orden ON secgen_db.dbo.sg_grpc (id_plapca,num_orden);
CREATE UNIQUE INDEX PK_sg_grpc ON secgen_db.dbo.sg_grpc (id_grupca);


-- secgen_db.dbo.sg_itpc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_itpc;

CREATE TABLE secgen_db.dbo.sg_itpc (
	id_itepca int NOT NULL,
	nom_itepca varchar(255) NOT NULL,
	id_grupca int NOT NULL,
	num_orden tinyint NOT NULL,
	id_tipelm tinyint NOT NULL,
	des_itepca text NULL,
	CONSTRAINT SG_ITPC_PK PRIMARY KEY (id_itepca),
	CONSTRAINT FK_sg_itpc_sg_grpc FOREIGN KEY (id_grupca) REFERENCES secgen_db.dbo.sg_grpc(id_grupca) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_itpc_sg_telm_2 FOREIGN KEY (id_tipelm) REFERENCES secgen_db.dbo.sg_telm(id_tipelm) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX NCU_sg_itpc_gru_orden ON secgen_db.dbo.sg_itpc (id_grupca,num_orden);
CREATE UNIQUE INDEX PK_sg_itpc ON secgen_db.dbo.sg_itpc (id_itepca);


-- secgen_db.dbo.sg_plre definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_plre;

CREATE TABLE secgen_db.dbo.sg_plre (
	id_planti smallint NOT NULL,
	nombre varchar(100) NOT NULL,
	vigente char(1) NOT NULL,
	cod_tipsol tinyint NOT NULL,
	f_creacion datetime NULL,
	f_ultmodif datetime NULL,
	CONSTRAINT SG_PLRE_PK PRIMARY KEY (id_planti),
	CONSTRAINT FK_sg_plre_sg_tsol FOREIGN KEY (cod_tipsol) REFERENCES secgen_db.dbo.sg_tsol(cod_tipsol) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_plre ON secgen_db.dbo.sg_plre (id_planti);


-- secgen_db.dbo.sg_rear definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_rear;

CREATE TABLE secgen_db.dbo.sg_rear (
	id_regarc int NOT NULL,
	ano_resolu smallint NOT NULL,
	nro_resolu int NOT NULL,
	id_perfil tinyint NOT NULL,
	rut char(9) NOT NULL,
	f_archiva tinyint NOT NULL,
	cod_estarc tinyint NULL,
	CONSTRAINT SG_REAR_PK PRIMARY KEY (id_regarc),
	CONSTRAINT FK_sg_rear_sg_earc FOREIGN KEY (cod_estarc) REFERENCES secgen_db.dbo.sg_earc(cod_estarc) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_rear_resol ON secgen_db.dbo.sg_rear (ano_resolu,nro_resolu);
CREATE UNIQUE INDEX PK_sg_rear ON secgen_db.dbo.sg_rear (id_regarc);


-- secgen_db.dbo.sg_rslc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_rslc;

CREATE TABLE secgen_db.dbo.sg_rslc (
	ano_resolu smallint NOT NULL,
	nro_resolu int NOT NULL,
	respon_res varchar(40) NULL,
	f_resolucio datetime NULL,
	id_planti smallint NULL,
	cod_estres tinyint NOT NULL,
	f_archivad datetime NULL,
	rut_archiv char(9) NULL,
	id_docum int NULL,
	codigo_sdg varchar(50) NULL,
	num_resolu int NULL,
	CONSTRAINT SG_RSLC_PK PRIMARY KEY (ano_resolu,nro_resolu),
	CONSTRAINT FK_sg_rslc_sg_ersl FOREIGN KEY (cod_estres) REFERENCES secgen_db.dbo.sg_ersl(cod_estres) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_rslc_sg_plre_2 FOREIGN KEY (id_planti) REFERENCES secgen_db.dbo.sg_plre(id_planti) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_rslc_id_docum ON secgen_db.dbo.sg_rslc (id_docum);
CREATE UNIQUE INDEX PK_sg_rslc ON secgen_db.dbo.sg_rslc (ano_resolu,nro_resolu);


-- secgen_db.dbo.sg_soli definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_soli;

CREATE TABLE secgen_db.dbo.sg_soli (
	nro_solici int NOT NULL,
	cod_tipsol tinyint NOT NULL,
	rut_solici char(9) NOT NULL,
	f_solicit datetime NOT NULL,
	cod_estsol tinyint NOT NULL,
	f_ultmodif datetime NOT NULL,
	ano_resolu smallint NULL,
	nro_resolu int NULL,
	f_creacion datetime NULL,
	ano_proces smallint NULL,
	CONSTRAINT SG_SOLI_PK PRIMARY KEY (nro_solici),
	CONSTRAINT FK_sg_soli_sg_esol FOREIGN KEY (cod_estsol) REFERENCES secgen_db.dbo.sg_esol(cod_estsol) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_soli_sg_rslc FOREIGN KEY (nro_resolu) REFERENCES secgen_db.dbo.sg_rslc(ano_resolu,nro_resolu) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_soli_sg_rslc_2 FOREIGN KEY (ano_resolu) REFERENCES secgen_db.dbo.sg_rslc(ano_resolu,nro_resolu) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_soli_sg_tsol_4 FOREIGN KEY (cod_tipsol) REFERENCES secgen_db.dbo.sg_tsol(cod_tipsol) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_soli_resol ON secgen_db.dbo.sg_soli (ano_resolu,nro_resolu);
CREATE UNIQUE INDEX PK_sg_soli ON secgen_db.dbo.sg_soli (nro_solici);


-- secgen_db.dbo.sg_uspe definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_uspe;

CREATE TABLE secgen_db.dbo.sg_uspe (
	rut char(9) NOT NULL,
	id_perfil tinyint NOT NULL,
	f_creacion datetime NOT NULL,
	vigente char(1) NOT NULL,
	f_no_vigen datetime NULL,
	CONSTRAINT SG_USPE_PK PRIMARY KEY (rut,id_perfil),
	CONSTRAINT FK_sg_uspe_sg_perf FOREIGN KEY (id_perfil) REFERENCES secgen_db.dbo.sg_perf(id_perfil) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NCU_sg_uspe_perf_rut ON secgen_db.dbo.sg_uspe (id_perfil,rut);
CREATE UNIQUE INDEX PK_sg_uspe ON secgen_db.dbo.sg_uspe (rut,id_perfil);


-- secgen_db.dbo.sg_apcc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_apcc;

CREATE TABLE secgen_db.dbo.sg_apcc (
	nro_solici int NOT NULL,
	nro_linea tinyint NOT NULL,
	rut_respon char(9) NOT NULL,
	nom_cencos varchar(255) NOT NULL,
	cod_unidad char(8) NOT NULL,
	id_antsol tinyint NOT NULL,
	ccte_exclu char(1) NOT NULL,
	cod_tfondo smallint NOT NULL,
	decr_afect char(1) NULL,
	id_resolex int NULL,
	f_creacion datetime NULL,
	f_ultmodif datetime NULL,
	cod_unifin smallint NULL,
	cod_ccto smallint NULL,
	cc_global varchar(9) NULL,
	pry_global varchar(12) NULL,
	tiene_adju char(1) NOT NULL,
	CONSTRAINT SG_APCC_PK PRIMARY KEY (nro_solici,nro_linea),
	CONSTRAINT FK_sg_apcc_sg_anso FOREIGN KEY (id_antsol) REFERENCES secgen_db.dbo.sg_anso(id_antsol) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_apcc_sg_soli_2 FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_soli(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_apcc_cc_global ON secgen_db.dbo.sg_apcc (cc_global,pry_global);
CREATE INDEX NC_sg_apcc_cc_ufro ON secgen_db.dbo.sg_apcc (cod_unifin,cod_ccto);
CREATE UNIQUE INDEX PK_sg_apcc ON secgen_db.dbo.sg_apcc (nro_solici,nro_linea);


-- secgen_db.dbo.sg_apre definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_apre;

CREATE TABLE secgen_db.dbo.sg_apre (
	id_aprbres int NOT NULL,
	ano_resolu smallint NOT NULL,
	nro_resolu int NOT NULL,
	rut_aprob char(9) NOT NULL,
	cod_estapr tinyint NOT NULL,
	id_perfil smallint NOT NULL,
	cod_sistem char(2) NULL,
	cod_modulo varchar(8) NULL,
	observacio text NULL,
	CONSTRAINT SG_APRE_PK PRIMARY KEY (id_aprbres),
	CONSTRAINT FK_sg_apre_sg_eapr FOREIGN KEY (cod_estapr) REFERENCES secgen_db.dbo.sg_eapr(cod_estapr) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_apre_sg_rslc FOREIGN KEY (nro_resolu) REFERENCES secgen_db.dbo.sg_rslc(ano_resolu,nro_resolu) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_apre_sg_rslc_2 FOREIGN KEY (ano_resolu) REFERENCES secgen_db.dbo.sg_rslc(ano_resolu,nro_resolu) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_apre_resol ON secgen_db.dbo.sg_apre (ano_resolu,nro_resolu);
CREATE UNIQUE INDEX PK_sg_apre ON secgen_db.dbo.sg_apre (id_aprbres);


-- secgen_db.dbo.sg_baco definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_baco;

CREATE TABLE secgen_db.dbo.sg_baco (
	nro_solici int NOT NULL,
	cod_unidad varchar(8) NULL,
	ident_carg varchar(255) NULL,
	cant_vacan tinyint NOT NULL,
	id_caljur tinyint NOT NULL,
	grad_solic varchar(20) NULL,
	jornada varchar(200) NULL,
	mot_vacanc varchar(255) NULL,
	rut_ultocu char(9) NULL,
	f_con_des datetime NULL,
	f_con_has datetime NULL,
	es_recpers char(1) NULL,
	id_tiprec tinyint NULL,
	eva_psicol char(1) NULL,
	pers_eval char(1) NULL,
	rut_visad char(9) NULL,
	cod_unifin smallint NULL,
	cod_ccto smallint NULL,
	cc_global varchar(9) NULL,
	pry_global varchar(12) NULL,
	cod_unifsl smallint NULL,
	cod_cctsl smallint NULL,
	cc_globsl varchar(9) NULL,
	pry_globsl varchar(12) NULL,
	text_horar varchar(250) NULL,
	id_estbco tinyint NULL,
	rut_encarg char(9) NULL,
	f_visado datetime NULL,
	rut_cdir char(9) NULL,
	nom_cdir varchar(30) NULL,
	appat_cdir varchar(30) NULL,
	apmat_cdir varchar(30) NULL,
	es_academi char(1) NULL,
	CONSTRAINT SG_BACO_PK PRIMARY KEY (nro_solici),
	CONSTRAINT FK_sg_baco_sg_caju FOREIGN KEY (id_caljur) REFERENCES secgen_db.dbo.sg_caju(id_caljur) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_baco_sg_ebco_2 FOREIGN KEY (id_estbco) REFERENCES secgen_db.dbo.sg_ebco(id_estbco) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_baco_sg_soli_3 FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_soli(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_baco_sg_trec_4 FOREIGN KEY (id_tiprec) REFERENCES secgen_db.dbo.sg_trec(id_tiprec) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_baco ON secgen_db.dbo.sg_baco (nro_solici);


-- secgen_db.dbo.sg_bccm definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_bccm;

CREATE TABLE secgen_db.dbo.sg_bccm (
	id_coment int NOT NULL,
	nro_solici int NOT NULL,
	rut char(9) NOT NULL,
	fecha datetime NOT NULL,
	comentario text NULL,
	id_catego tinyint NULL,
	CONSTRAINT SG_BCCM_PK PRIMARY KEY (id_coment),
	CONSTRAINT FK_sg_bccm_sg_baco FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_baco(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_bccm_nro_solici ON secgen_db.dbo.sg_bccm (nro_solici);
CREATE UNIQUE INDEX PK_sg_bccm ON secgen_db.dbo.sg_bccm (id_coment);


-- secgen_db.dbo.sg_bcre definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_bcre;

CREATE TABLE secgen_db.dbo.sg_bcre (
	nro_solici int NOT NULL,
	correlativ tinyint NOT NULL,
	rut_revis char(9) NOT NULL,
	id_perfil tinyint NULL,
	cod_estapr tinyint NOT NULL,
	com_revis text NULL,
	CONSTRAINT SG_BCRE_PK PRIMARY KEY (nro_solici,correlativ),
	CONSTRAINT FK_sg_bcre_sg_baco FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_baco(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_bcre_sg_eapr_2 FOREIGN KEY (cod_estapr) REFERENCES secgen_db.dbo.sg_eapr(cod_estapr) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_bcre ON secgen_db.dbo.sg_bcre (nro_solici,correlativ);


-- secgen_db.dbo.sg_cicc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_cicc;

CREATE TABLE secgen_db.dbo.sg_cicc (
	nro_solici int NOT NULL,
	nro_linea tinyint NOT NULL,
	id_motcie tinyint NOT NULL,
	otro_motiv text NULL,
	id_docum int NULL,
	cod_unifin smallint NULL,
	cod_ccto smallint NULL,
	cc_global varchar(9) NULL,
	pry_global varchar(12) NULL,
	tiene_adju char(1) NOT NULL,
	clave_cier varchar(30) NULL,
	CONSTRAINT SG_CICC_PK PRIMARY KEY (nro_solici,nro_linea),
	CONSTRAINT FK_sg_cicc_sg_moci FOREIGN KEY (id_motcie) REFERENCES secgen_db.dbo.sg_moci(id_motcie) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_cicc_sg_soli_2 FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_soli(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_cicc ON secgen_db.dbo.sg_cicc (nro_solici,nro_linea);


-- secgen_db.dbo.sg_delm definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_delm;

CREATE TABLE secgen_db.dbo.sg_delm (
	id_detelm int NOT NULL,
	id_itepca int NOT NULL,
	nom_detelm varchar(255) NULL,
	des_detelm text NULL,
	num_orden tinyint NOT NULL,
	val_radmin tinyint NULL,
	val_radmax tinyint NULL,
	etiquet_si varchar(250) NULL,
	etiquet_no varchar(250) NULL,
	CONSTRAINT SG_DELM_PK PRIMARY KEY (id_detelm),
	CONSTRAINT FK_sg_delm_sg_itpc FOREIGN KEY (id_itepca) REFERENCES secgen_db.dbo.sg_itpc(id_itepca) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX NCU_sg_delm_detalle_orden ON secgen_db.dbo.sg_delm (id_itepca,num_orden);
CREATE UNIQUE INDEX PK_sg_delm ON secgen_db.dbo.sg_delm (id_detelm);


-- secgen_db.dbo.sg_drec definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_drec;

CREATE TABLE secgen_db.dbo.sg_drec (
	nro_solici int NOT NULL,
	nro_linea tinyint NOT NULL,
	id_tipdev smallint NOT NULL,
	CONSTRAINT SG_DREC_PK PRIMARY KEY (nro_solici,nro_linea),
	CONSTRAINT FK_sg_drec_sg_soli FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_soli(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_drec_sg_tdre_2 FOREIGN KEY (id_tipdev) REFERENCES secgen_db.dbo.sg_tdre(id_tipdev) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX NCU_sg_drec_sol_tipdev ON secgen_db.dbo.sg_drec (nro_solici,id_tipdev);
CREATE UNIQUE INDEX PK_sg_drec ON secgen_db.dbo.sg_drec (nro_solici,nro_linea);


-- secgen_db.dbo.sg_fopc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_fopc;

CREATE TABLE secgen_db.dbo.sg_fopc (
	nro_solici int NOT NULL,
	id_plapca smallint NOT NULL,
	f_creacion datetime NOT NULL,
	CONSTRAINT SG_FOPC_PK PRIMARY KEY (nro_solici),
	CONSTRAINT FK_sg_fopc_sg_baco FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_baco(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_fopc_sg_plpc_2 FOREIGN KEY (id_plapca) REFERENCES secgen_db.dbo.sg_plpc(id_plapca) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_fopc ON secgen_db.dbo.sg_fopc (nro_solici);


-- secgen_db.dbo.sg_hist definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_hist;

CREATE TABLE secgen_db.dbo.sg_hist (
	id_histor int NOT NULL,
	cod_tipsol tinyint NULL,
	nro_solici int NULL,
	nro_resolu int NULL,
	ano_resolu smallint NULL,
	id_tipacc tinyint NULL,
	observaci text NULL,
	rut_accion char(9) NULL,
	id_perfil smallint NULL,
	cod_sistem char(2) NULL,
	cod_modulo varchar(8) NULL,
	f_creacion datetime NULL,
	f_ultmodif datetime NULL,
	CONSTRAINT SG_HIST_PK PRIMARY KEY (id_histor),
	CONSTRAINT FK_sg_hist_sg_rslc FOREIGN KEY (ano_resolu,nro_resolu) REFERENCES secgen_db.dbo.sg_rslc(ano_resolu,nro_resolu) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_hist_sg_soli_3 FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_soli(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_hist_sg_tacc_4 FOREIGN KEY (id_tipacc) REFERENCES secgen_db.dbo.sg_tacc(id_tipacc) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_hist_sg_tsol_5 FOREIGN KEY (cod_tipsol) REFERENCES secgen_db.dbo.sg_tsol(cod_tipsol) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_hist ON secgen_db.dbo.sg_hist (id_histor);


-- secgen_db.dbo.sg_ifpc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_ifpc;

CREATE TABLE secgen_db.dbo.sg_ifpc (
	id_itfopc int NOT NULL,
	nro_solici int NOT NULL,
	valor_text text NULL,
	id_itepca int NOT NULL,
	rut_creaci char(9) NOT NULL,
	CONSTRAINT SG_IFPC_PK PRIMARY KEY (id_itfopc),
	CONSTRAINT FK_sg_ifpc_sg_fopc FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_fopc(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_ifpc_sg_itpc_2 FOREIGN KEY (id_itepca) REFERENCES secgen_db.dbo.sg_itpc(id_itepca) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_ifpc_solici_itepca ON secgen_db.dbo.sg_ifpc (nro_solici,id_itepca);
CREATE UNIQUE INDEX PK_sg_ifpc ON secgen_db.dbo.sg_ifpc (id_itfopc);


-- secgen_db.dbo.sg_inbc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_inbc;

CREATE TABLE secgen_db.dbo.sg_inbc (
	nro_solici int NOT NULL,
	id_esibc tinyint NOT NULL,
	id_plbaco smallint NULL,
	informe text NULL,
	CONSTRAINT SG_INBC_PK PRIMARY KEY (nro_solici),
	CONSTRAINT FK_sg_inbc_sg_baco FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_baco(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_inbc_sg_eibc_2 FOREIGN KEY (id_esibc) REFERENCES secgen_db.dbo.sg_eibc(id_esibc) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_inbc_sg_plbc_3 FOREIGN KEY (id_plbaco) REFERENCES secgen_db.dbo.sg_plbc(id_plbaco) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_inbc ON secgen_db.dbo.sg_inbc (nro_solici);


-- secgen_db.dbo.sg_inpc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_inpc;

CREATE TABLE secgen_db.dbo.sg_inpc (
	nro_solici int NOT NULL,
	id_tipinc tinyint NOT NULL,
	f_creacion datetime NULL,
	f_ultmodif datetime NULL,
	CONSTRAINT SG_INPC_PK PRIMARY KEY (nro_solici),
	CONSTRAINT FK_sg_inpc_sg_soli FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_soli(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_inpc_sg_tipc_2 FOREIGN KEY (id_tipinc) REFERENCES secgen_db.dbo.sg_tipc(id_tipinc) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_inpc ON secgen_db.dbo.sg_inpc (nro_solici);


-- secgen_db.dbo.sg_plde definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_plde;

CREATE TABLE secgen_db.dbo.sg_plde (
	id_pladet tinyint NOT NULL,
	id_planti smallint NOT NULL,
	cod_tipsec tinyint NOT NULL,
	nombre varchar(100) NOT NULL,
	valor text NULL,
	editable char(1) NOT NULL,
	orden tinyint NOT NULL,
	f_creacion datetime NULL,
	f_ultmodif datetime NULL,
	CONSTRAINT SG_PLDE_PK PRIMARY KEY (id_pladet),
	CONSTRAINT FK_sg_plde_sg_plre FOREIGN KEY (id_planti) REFERENCES secgen_db.dbo.sg_plre(id_planti) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_plde_sg_plse_2 FOREIGN KEY (cod_tipsec) REFERENCES secgen_db.dbo.sg_plse(cod_tipsec) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_plde_plantilla_orden ON secgen_db.dbo.sg_plde (id_planti,orden);
CREATE UNIQUE INDEX PK_sg_plde ON secgen_db.dbo.sg_plde (id_pladet);


-- secgen_db.dbo.sg_prse definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_prse;

CREATE TABLE secgen_db.dbo.sg_prse (
	nro_solici int NOT NULL,
	actividad varchar(255) NOT NULL,
	per_desde datetime NOT NULL,
	per_hasta datetime NOT NULL,
	rut_jefpro char(9) NOT NULL,
	cod_unifin smallint NULL,
	cod_ccto smallint NULL,
	cc_global varchar(9) NULL,
	pry_global varchar(12) NULL,
	cod_modprs tinyint NULL,
	cod_flusol tinyint NULL,
	cod_etapa tinyint NULL,
	CONSTRAINT SG_PRSE_PK PRIMARY KEY (nro_solici),
	CONSTRAINT FK_sg_prse_sg_eta1 FOREIGN KEY (cod_flusol,cod_etapa) REFERENCES secgen_db.dbo.sg_eta1(cod_flusol,cod_etapa) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_prse_sg_soli_3 FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_soli(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_prse_sg_tmod_4 FOREIGN KEY (cod_modprs) REFERENCES secgen_db.dbo.sg_tmod(cod_modprs) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_prse ON secgen_db.dbo.sg_prse (nro_solici);


-- secgen_db.dbo.sg_rede definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_rede;

CREATE TABLE secgen_db.dbo.sg_rede (
	id_resdet int NOT NULL,
	ano_resolu smallint NOT NULL,
	nro_resolu int NOT NULL,
	id_pladet int NOT NULL,
	cod_tipsec tinyint NULL,
	nombre varchar(100) NULL,
	valor text NULL,
	editable char(1) NULL,
	orden tinyint NOT NULL,
	f_creacion datetime NULL,
	f_ultmodif datetime NULL,
	CONSTRAINT SG_REDE_PK PRIMARY KEY (id_resdet),
	CONSTRAINT FK_sg_rede_sg_plse FOREIGN KEY (cod_tipsec) REFERENCES secgen_db.dbo.sg_plse(cod_tipsec) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_rede_sg_rslc FOREIGN KEY (nro_resolu) REFERENCES secgen_db.dbo.sg_rslc(ano_resolu,nro_resolu) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_rede_sg_rslc_2 FOREIGN KEY (ano_resolu) REFERENCES secgen_db.dbo.sg_rslc(ano_resolu,nro_resolu) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_rede_resol_orden ON secgen_db.dbo.sg_rede (ano_resolu,nro_resolu,orden);
CREATE UNIQUE INDEX PK_sg_rede ON secgen_db.dbo.sg_rede (id_resdet);


-- secgen_db.dbo.sg_appc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_appc;

CREATE TABLE secgen_db.dbo.sg_appc (
	nro_solici int NOT NULL,
	correlativ tinyint NOT NULL,
	rut_aprob char(9) NOT NULL,
	cod_estapr tinyint NOT NULL,
	fecha_reg datetime NOT NULL,
	comentario text NULL,
	CONSTRAINT SG_APPC_PK PRIMARY KEY (nro_solici,correlativ),
	CONSTRAINT FK_sg_appc_sg_eapr FOREIGN KEY (cod_estapr) REFERENCES secgen_db.dbo.sg_eapr(cod_estapr) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_appc_sg_fopc_2 FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_fopc(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_appc ON secgen_db.dbo.sg_appc (nro_solici,correlativ);


-- secgen_db.dbo.sg_dben definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_dben;

CREATE TABLE secgen_db.dbo.sg_dben (
	nro_solici int NOT NULL,
	nro_linea tinyint NOT NULL,
	rut_benef char(9) NOT NULL,
	nom_benef varchar(100) NULL,
	motivo varchar(255) NOT NULL,
	cod_unifin smallint NULL,
	cod_ccto smallint NULL,
	cc_global varchar(9) NULL,
	pry_global varchar(12) NULL,
	monto decimal(19,2) NOT NULL,
	cod_tipago tinyint NOT NULL,
	cod_banco smallint NULL,
	cod_tcuent varchar(2) NULL,
	nro_cta varchar(30) NULL,
	CONSTRAINT SG_DBEN_PK PRIMARY KEY (nro_solici,nro_linea,rut_benef),
	CONSTRAINT FK_sg_dben_sg_drec FOREIGN KEY (nro_solici,nro_linea) REFERENCES secgen_db.dbo.sg_drec(nro_solici,nro_linea) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_dben_sg_tpag_3 FOREIGN KEY (cod_tipago) REFERENCES secgen_db.dbo.sg_tpag(cod_tipago) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_dben_rut ON secgen_db.dbo.sg_dben (rut_benef);
CREATE UNIQUE INDEX PK_sg_dban ON secgen_db.dbo.sg_dben (nro_solici,nro_linea,rut_benef);


-- secgen_db.dbo.sg_dfpc definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_dfpc;

CREATE TABLE secgen_db.dbo.sg_dfpc (
	id_defopc int NOT NULL,
	id_itfopc int NOT NULL,
	id_detelm int NOT NULL,
	val_num int NULL,
	val_bool char(1) NULL,
	val_texto text NULL,
	f_creacion datetime NULL,
	CONSTRAINT SG_DFPC_PK PRIMARY KEY (id_defopc),
	CONSTRAINT FK_sg_dfpc_sg_delm FOREIGN KEY (id_detelm) REFERENCES secgen_db.dbo.sg_delm(id_detelm) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_dfpc_sg_ifpc_2 FOREIGN KEY (id_itfopc) REFERENCES secgen_db.dbo.sg_ifpc(id_itfopc) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_dfpc_itm_form_plant ON secgen_db.dbo.sg_dfpc (id_itfopc,id_detelm);
CREATE UNIQUE INDEX PK_sg_dfpc ON secgen_db.dbo.sg_dfpc (id_defopc);


-- secgen_db.dbo.sg_fups definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_fups;

CREATE TABLE secgen_db.dbo.sg_fups (
	id_funprse int NOT NULL,
	nro_solici int NOT NULL,
	rut char(9) NOT NULL,
	cod_cargo smallint NULL,
	cod_sitm varchar(5) NULL,
	itm_global varchar(15) NULL,
	motivo varchar(255) NULL,
	periodos tinyint NOT NULL,
	monto_mes decimal(19,2) NOT NULL,
	mto_total decimal(19,2) NOT NULL,
	cod_moneda tinyint NULL,
	cod_tpps int NULL,
	f_inicio datetime NULL,
	f_termino datetime NULL,
	cod_estfun tinyint NULL,
	dentro_jor char(1) NULL,
	cod_contra int NULL,
	mes_haber tinyint NULL,
	ano_haber smallint NULL,
	mto_haber int NULL,
	mto_tope int NULL,
	f_cal_tope datetime NULL,
	tot_cuotas tinyint NULL,
	CONSTRAINT SG_FUPS_PK PRIMARY KEY (id_funprse),
	CONSTRAINT FK_sg_fups_sg_efun FOREIGN KEY (cod_estfun) REFERENCES secgen_db.dbo.sg_efun(cod_estfun) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_fups_sg_prse_2 FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_prse(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_fups_sg_tpps_3 FOREIGN KEY (cod_tpps) REFERENCES secgen_db.dbo.sg_tpps(cod_tpps) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_fups_rut ON secgen_db.dbo.sg_fups (rut);
CREATE UNIQUE INDEX PK_sg_fups ON secgen_db.dbo.sg_fups (id_funprse);


-- secgen_db.dbo.sg_his2 definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_his2;

CREATE TABLE secgen_db.dbo.sg_his2 (
	id_funprse int NOT NULL,
	f_visacion datetime NOT NULL,
	rut_visado char(9) NOT NULL,
	cod_estact tinyint NOT NULL,
	cod_estnue tinyint NOT NULL,
	CONSTRAINT SG_HIS2_PK PRIMARY KEY (id_funprse,f_visacion),
	CONSTRAINT FK_sg_his2_sg_fups FOREIGN KEY (id_funprse) REFERENCES secgen_db.dbo.sg_fups(id_funprse) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_his2 ON secgen_db.dbo.sg_his2 (id_funprse,f_visacion);


-- secgen_db.dbo.sg_inac definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_inac;

CREATE TABLE secgen_db.dbo.sg_inac (
	id_incacad int NOT NULL,
	nro_solici int NOT NULL,
	rut_acad char(9) NOT NULL,
	cod_moneda tinyint NULL,
	monto decimal(19,2) NOT NULL,
	f_ultmodif datetime NOT NULL,
	id_incagr tinyint NULL,
	CONSTRAINT SG_INAC_PK PRIMARY KEY (id_incacad),
	CONSTRAINT FK_sg_inac_sg_inag FOREIGN KEY (id_incagr) REFERENCES secgen_db.dbo.sg_inag(id_incagr) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_inac_sg_inpc_2 FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_inpc(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_inac_rut ON secgen_db.dbo.sg_inac (rut_acad);
CREATE INDEX NC_sg_inac_solici ON secgen_db.dbo.sg_inac (nro_solici);
CREATE UNIQUE INDEX PK_sg_inac ON secgen_db.dbo.sg_inac (id_incacad);


-- secgen_db.dbo.sg_apso definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_apso;

CREATE TABLE secgen_db.dbo.sg_apso (
	nro_aproba int NOT NULL,
	nro_solici int NOT NULL,
	rut_usua char(9) NOT NULL,
	cod_estapr tinyint NOT NULL,
	comentario text NULL,
	f_aprobac datetime NULL,
	f_creacion datetime NULL,
	f_ultmodif datetime NULL,
	cod_flusol tinyint NULL,
	cod_etapa tinyint NULL,
	rut_autori char(9) NULL,
	id_funprse int NULL,
	CONSTRAINT SG_APSO_PK PRIMARY KEY (nro_aproba),
	CONSTRAINT FK_sg_apso_sg_eapr FOREIGN KEY (cod_estapr) REFERENCES secgen_db.dbo.sg_eapr(cod_estapr) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_apso_sg_eta1 FOREIGN KEY (cod_flusol,cod_etapa) REFERENCES secgen_db.dbo.sg_eta1(cod_flusol,cod_etapa) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_apso_sg_fups_4 FOREIGN KEY (id_funprse) REFERENCES secgen_db.dbo.sg_fups(id_funprse) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_apso_sg_soli_5 FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_soli(nro_solici) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE INDEX NC_sg_apso_rut ON secgen_db.dbo.sg_apso (rut_usua);
CREATE INDEX NC_sg_apso_soli ON secgen_db.dbo.sg_apso (nro_solici);
CREATE INDEX NC_sg_apso_etapa ON secgen_db.dbo.sg_apso (nro_solici,cod_flusol,cod_etapa,cod_estapr);
CREATE UNIQUE INDEX PK_sg_apso ON secgen_db.dbo.sg_apso (nro_aproba);


-- secgen_db.dbo.sg_fuco definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_fuco;

CREATE TABLE secgen_db.dbo.sg_fuco (
	id_funprse int NOT NULL,
	fec_compro datetime NOT NULL,
	hora_ini time(3) NOT NULL,
	hora_ter time(3) NOT NULL,
	CONSTRAINT SG_FUCO_PK PRIMARY KEY (id_funprse,fec_compro),
	CONSTRAINT FK_sg_fuco_sg_fups FOREIGN KEY (id_funprse) REFERENCES secgen_db.dbo.sg_fups(id_funprse) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_fuco ON secgen_db.dbo.sg_fuco (id_funprse,fec_compro);


-- secgen_db.dbo.sg_fume definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_fume;

CREATE TABLE secgen_db.dbo.sg_fume (
	id_funprse int NOT NULL,
	nro_cuota tinyint NOT NULL,
	ano_prop smallint NOT NULL,
	mes_prop tinyint NOT NULL,
	cod_estcuo tinyint NOT NULL,
	ano_ejec smallint NULL,
	mes_ejec tinyint NULL,
	mto_apagar int NULL,
	id_evidenc int NULL,
	val_licmed char(1) NULL,
	val_inabili char(1) NULL,
	val_singoce char(1) NULL,
	val_ciecc char(1) NULL,
	fec_valida datetime NULL,
	rut_autori char(9) NULL,
	fec_autori datetime NULL,
	fec_envrem datetime NULL,
	fec_pago datetime NULL,
	ano_pago smallint NULL,
	mes_pago tinyint NULL,
	CONSTRAINT SG_FUME_PK PRIMARY KEY (id_funprse,nro_cuota),
	CONSTRAINT FK_sg_fume_sg_ecuo FOREIGN KEY (cod_estcuo) REFERENCES secgen_db.dbo.sg_ecuo(cod_estcuo) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_sg_fume_sg_fups_2 FOREIGN KEY (id_funprse) REFERENCES secgen_db.dbo.sg_fups(id_funprse) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_fume ON secgen_db.dbo.sg_fume (id_funprse,nro_cuota);


-- secgen_db.dbo.sg_fuc2 definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_fuc2;

CREATE TABLE secgen_db.dbo.sg_fuc2 (
	id_funprse int NOT NULL,
	nro_cuota tinyint NOT NULL,
	fec_comrea datetime NOT NULL,
	hora_ini time(3) NOT NULL,
	hora_ter time(3) NOT NULL,
	CONSTRAINT SG_FUC2_PK PRIMARY KEY (id_funprse,nro_cuota,fec_comrea),
	CONSTRAINT FK_sg_fuc2_sg_fume FOREIGN KEY (id_funprse,nro_cuota) REFERENCES secgen_db.dbo.sg_fume(id_funprse,nro_cuota) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_fuc2 ON secgen_db.dbo.sg_fuc2 (id_funprse,nro_cuota,fec_comrea);


-- secgen_db.dbo.sg_fum2 definition

-- Drop table

-- DROP TABLE secgen_db.dbo.sg_fum2;

CREATE TABLE secgen_db.dbo.sg_fum2 (
	id_funprse int NOT NULL,
	nro_cuota tinyint NOT NULL,
	correlativ tinyint NOT NULL,
	ano_prop smallint NOT NULL,
	mes_prop tinyint NOT NULL,
	cod_estcuo tinyint NOT NULL,
	ano_ejec smallint NULL,
	mes_ejec tinyint NULL,
	mto_apagar int NULL,
	id_evidenc int NULL,
	val_licmed char(1) NULL,
	val_inabili char(1) NULL,
	val_singoce char(1) NULL,
	val_ciecc char(1) NULL,
	fec_valida datetime NULL,
	rut_autori char(9) NULL,
	fec_autori datetime NULL,
	fec_envrem datetime NULL,
	CONSTRAINT SG_FUM2_PK PRIMARY KEY (id_funprse,nro_cuota,correlativ),
	CONSTRAINT FK_sg_fum2_sg_fume FOREIGN KEY (id_funprse,nro_cuota) REFERENCES secgen_db.dbo.sg_fume(id_funprse,nro_cuota) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE UNIQUE INDEX PK_sg_fum2 ON secgen_db.dbo.sg_fum2 (id_funprse,nro_cuota,correlativ);
