-- GRUPO: Mont Clio
--   TURMA: 2TDSPX
--   Integrantes e RM :     Leonardo Santos | 557541 
--                          Pedro Santos | 558243 
--                          Vitor Martins | 558244 

--   


/*
DROP TABLE TB_LST_EMPREGO CASCADE CONSTRAINTS;

DROP TABLE TB_LST_ESTADO_RETORNO CASCADE CONSTRAINTS;

DROP TABLE TB_LST_HUMOR CASCADE CONSTRAINTS;

DROP TABLE TB_LST_PERFIL CASCADE CONSTRAINTS;

DROP TABLE TB_LST_RECOMENDACAO CASCADE CONSTRAINTS;

DROP TABLE TB_LST_USUARIO CASCADE CONSTRAINTS;

*/

CREATE TABLE TB_LST_EMPREGO 
    ( 
     id_emprego            INTEGER  NOT NULL , 
     empresa               VARCHAR2 (100)  NOT NULL , 
     data_admissao         DATE  NOT NULL , 
     cargo                 VARCHAR2 (100)  NOT NULL , 
     tipo_contrato         VARCHAR2 (30)  NOT NULL , 
     carga_horaria_semanal INTEGER  NOT NULL , 
     modelo_trabalho       VARCHAR2 (25)  NOT NULL , 
     satisfacao_trabalho   INTEGER  NOT NULL 
    ) 
;

ALTER TABLE TB_LST_EMPREGO 
    ADD CONSTRAINT id_emprego_pk PRIMARY KEY ( id_emprego ) ;

CREATE TABLE TB_LST_ESTADO_RETORNO 
    ( 
     id_retorno         INTEGER  NOT NULL , 
     data_retorno       DATE  NOT NULL , 
     eficacia_percebida INTEGER  NOT NULL , 
     comentario         VARCHAR2 (350) , 
     acao_realizada     CHAR (1)  NOT NULL 
    ) 
;

ALTER TABLE TB_LST_ESTADO_RETORNO 
    ADD CONSTRAINT id_retorno_pk PRIMARY KEY ( id_retorno ) ;

CREATE TABLE TB_LST_HUMOR 
    ( 
     id_humor             INTEGER  NOT NULL , 
     data_registro        DATE  NOT NULL , 
     emocao_palavra_chave VARCHAR2 (25) , 
     nivel_humor          INTEGER  NOT NULL , 
     cometario            VARCHAR2 (350) 
    ) 
;

ALTER TABLE TB_LST_HUMOR 
    ADD CONSTRAINT id_humor_pk PRIMARY KEY ( id_humor ) ;

CREATE TABLE TB_LST_PERFIL 
    ( 
     id_perfil   INTEGER  NOT NULL , 
     desc_perfil VARCHAR2 (75)  NOT NULL 
    ) 
;

ALTER TABLE TB_LST_PERFIL 
    ADD CONSTRAINT id_perfil_pk PRIMARY KEY ( id_perfil ) ;

CREATE TABLE TB_LST_RECOMENDACAO 
    ( 
     id_recomendacao        INTEGER  NOT NULL , 
     nivel_humor_alvo       INTEGER  NOT NULL , 
     titulo_recomendacao    VARCHAR2 (100)  NOT NULL , 
     descricao_recomendacao VARCHAR2 (350) , 
     tipo_acao              VARCHAR2 (55) , 
     link_acao              VARCHAR2 (250) 
    ) 
;

ALTER TABLE TB_LST_RECOMENDACAO 
    ADD CONSTRAINT id_recomendacao_pk PRIMARY KEY ( id_recomendacao ) ;

CREATE TABLE TB_LST_USUARIO 
    ( 
     id_usuario      INTEGER  NOT NULL , 
     id_perfil       INTEGER  NOT NULL , 
     id_humor        INTEGER  NOT NULL , 
     id_recomendacao INTEGER  NOT NULL , 
     id_retorno      INTEGER  NOT NULL , 
     id_emprego      INTEGER  NOT NULL , 
     nome_usuario    VARCHAR2 (50) , 
     sobrenome       VARCHAR2 (50) , 
     data_nascimento DATE  NOT NULL , 
     cpf             VARCHAR2 (25)  NOT NULL , 
     telefone        INTEGER  NOT NULL , 
     email_usuario   VARCHAR2 (75)  NOT NULL , 
     senha           VARCHAR2 (28)  NOT NULL 
    ) 
;

ALTER TABLE TB_LST_USUARIO 
    ADD CONSTRAINT id_usuario_pk PRIMARY KEY ( id_usuario ) ;

ALTER TABLE TB_LST_USUARIO 
    ADD CONSTRAINT id_emprego_fk FOREIGN KEY 
    ( 
     id_emprego
    ) 
    REFERENCES TB_LST_EMPREGO 
    ( 
     id_emprego
    ) 
;

ALTER TABLE TB_LST_USUARIO 
    ADD CONSTRAINT id_humor_fk FOREIGN KEY 
    ( 
     id_humor
    ) 
    REFERENCES TB_LST_HUMOR 
    ( 
     id_humor
    ) 
;

ALTER TABLE TB_LST_USUARIO 
    ADD CONSTRAINT id_perfil_fk FOREIGN KEY 
    ( 
     id_perfil
    ) 
    REFERENCES TB_LST_PERFIL 
    ( 
     id_perfil
    ) 
;

ALTER TABLE TB_LST_USUARIO 
    ADD CONSTRAINT id_recomendacao_fk FOREIGN KEY 
    ( 
     id_recomendacao
    ) 
    REFERENCES TB_LST_RECOMENDACAO 
    ( 
     id_recomendacao
    ) 
;

ALTER TABLE TB_LST_USUARIO 
    ADD CONSTRAINT id_retorno_fk FOREIGN KEY 
    ( 
     id_retorno
    ) 
    REFERENCES TB_LST_ESTADO_RETORNO 
    ( 
     id_retorno
    ) 
;

CREATE SEQUENCE TB_LST_EMPREGO_id_emprego_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_LST_EMPREGO_id_emprego_TRG 
BEFORE INSERT ON TB_LST_EMPREGO 
FOR EACH ROW 
WHEN (NEW.id_emprego IS NULL) 
BEGIN 
    :NEW.id_emprego := TB_LST_EMPREGO_id_emprego_SEQ.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_LST_ESTADO_RETORNO_id_retor 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_LST_ESTADO_RETORNO_id_retor 
BEFORE INSERT ON TB_LST_ESTADO_RETORNO 
FOR EACH ROW 
WHEN (NEW.id_retorno IS NULL) 
BEGIN 
    :NEW.id_retorno := TB_LST_ESTADO_RETORNO_id_retor.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_LST_HUMOR_id_humor_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_LST_HUMOR_id_humor_TRG 
BEFORE INSERT ON TB_LST_HUMOR 
FOR EACH ROW 
WHEN (NEW.id_humor IS NULL) 
BEGIN 
    :NEW.id_humor := TB_LST_HUMOR_id_humor_SEQ.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_LST_PERFIL_id_perfil_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_LST_PERFIL_id_perfil_TRG 
BEFORE INSERT ON TB_LST_PERFIL 
FOR EACH ROW 
WHEN (NEW.id_perfil IS NULL) 
BEGIN 
    :NEW.id_perfil := TB_LST_PERFIL_id_perfil_SEQ.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_LST_RECOMENDACAO_id_recomen 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_LST_RECOMENDACAO_id_recomen 
BEFORE INSERT ON TB_LST_RECOMENDACAO 
FOR EACH ROW 
WHEN (NEW.id_recomendacao IS NULL) 
BEGIN 
    :NEW.id_recomendacao := TB_LST_RECOMENDACAO_id_recomen.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_LST_USUARIO_id_usuario_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_LST_USUARIO_id_usuario_TRG 
BEFORE INSERT ON TB_LST_USUARIO 
FOR EACH ROW 
WHEN (NEW.id_usuario IS NULL) 
BEGIN 
    :NEW.id_usuario := TB_LST_USUARIO_id_usuario_SEQ.NEXTVAL; 
END;
/
