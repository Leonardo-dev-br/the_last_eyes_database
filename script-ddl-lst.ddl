--   GRUPO: Mont Clio
--   NOME PROJETO: The Last Eyes
--   TURMA: 2TDSPX
--   Integrantes e RM :     Leonardo Santos | 557541 
--                          Pedro Santos | 558243 
--                          Vitor Martins | 558244 

--   


/*
DROP TABLE tb_lst_emprego CASCADE CONSTRAINTS;

DROP TABLE tb_lst_empresa CASCADE CONSTRAINTS;

DROP TABLE tb_lst_estado_retorno CASCADE CONSTRAINTS;

DROP TABLE tb_lst_humor CASCADE CONSTRAINTS;

DROP TABLE tb_lst_perfil CASCADE CONSTRAINTS;

DROP TABLE tb_lst_recomendacao CASCADE CONSTRAINTS;

DROP TABLE tb_lst_usuario CASCADE CONSTRAINTS;
*/


CREATE TABLE tb_lst_emprego (
    id_emprego            INTEGER NOT NULL,
    id_empresa            INTEGER NOT NULL,
    empresa               VARCHAR2(100) NOT NULL,
    data_admissao         DATE NOT NULL,
    cargo                 VARCHAR2(100) NOT NULL,
    tipo_contrato         VARCHAR2(30) NOT NULL,
    carga_horaria_semanal INTEGER NOT NULL,
    modelo_trabalho       VARCHAR2(25) NOT NULL,
    satisfacao_trabalho   INTEGER NOT NULL
);

ALTER TABLE tb_lst_emprego ADD CONSTRAINT tb_lst_empr_id_emprego_pk PRIMARY KEY ( id_emprego );

CREATE TABLE tb_lst_empresa (
    id_empresa    INTEGER NOT NULL,
    cnpj          INTEGER NOT NULL,
    nome_fantasia VARCHAR2(100) NOT NULL,
    razao_social  VARCHAR2(100) NOT NULL,
    telefone      INTEGER NOT NULL,
    email         VARCHAR2(100) NOT NULL
);

ALTER TABLE tb_lst_empresa ADD CONSTRAINT tb_lst_emp_id_empresa_pk PRIMARY KEY ( id_empresa );

CREATE TABLE tb_lst_estado_retorno (
    id_retorno         INTEGER NOT NULL,
    data_retorno       DATE NOT NULL,
    eficacia_percebida INTEGER NOT NULL,
    comentario         VARCHAR2(350),
    acao_realizada     CHAR(1) NOT NULL
);

ALTER TABLE tb_lst_estado_retorno ADD CONSTRAINT tb_lst_std_ret_id_retorno_pk PRIMARY KEY ( id_retorno );

CREATE TABLE tb_lst_humor (
    id_humor             INTEGER NOT NULL,
    data_registro        DATE NOT NULL,
    emocao_palavra_chave VARCHAR2(25),
    nivel_humor          INTEGER NOT NULL,
    cometario            VARCHAR2(350)
);

ALTER TABLE tb_lst_humor ADD CONSTRAINT tb_lst_humor_id_humor_pk PRIMARY KEY ( id_humor );

CREATE TABLE tb_lst_perfil (
    id_perfil   INTEGER NOT NULL,
    desc_perfil VARCHAR2(75) NOT NULL
);

ALTER TABLE tb_lst_perfil ADD CONSTRAINT tb_lst_perfil_id_perfil_pk PRIMARY KEY ( id_perfil );

CREATE TABLE tb_lst_recomendacao (
    id_recomendacao        INTEGER NOT NULL,
    nivel_humor_alvo       INTEGER NOT NULL,
    titulo_recomendacao    VARCHAR2(100) NOT NULL,
    descricao_recomendacao VARCHAR2(350),
    tipo_acao              VARCHAR2(55),
    link_acao              VARCHAR2(250)
);

ALTER TABLE tb_lst_recomendacao ADD CONSTRAINT tb_lst_rec_id_recomendacao_pk PRIMARY KEY ( id_recomendacao );

CREATE TABLE tb_lst_usuario (
    id_usuario      INTEGER NOT NULL,
    id_perfil       INTEGER NOT NULL,
    id_humor        INTEGER NOT NULL,
    id_recomendacao INTEGER NOT NULL,
    id_retorno      INTEGER NOT NULL,
    id_emprego      INTEGER NOT NULL,
    id_empresa      INTEGER NOT NULL,
    nome_usuario    VARCHAR2(50),
    sobrenome       VARCHAR2(50),
    data_nascimento DATE NOT NULL,
    cpf             VARCHAR2(25) NOT NULL,
    telefone        INTEGER NOT NULL,
    email_usuario   VARCHAR2(75) NOT NULL,
    senha           VARCHAR2(28) NOT NULL
);

ALTER TABLE tb_lst_usuario ADD CONSTRAINT tb_lst_us_id_usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE tb_lst_usuario
    ADD CONSTRAINT tb_lst_emp_id_emprego_fk FOREIGN KEY ( id_emprego )
        REFERENCES tb_lst_emprego ( id_emprego );

ALTER TABLE tb_lst_emprego
    ADD CONSTRAINT tb_lst_emp_id_empresa_fk FOREIGN KEY ( id_empresa )
        REFERENCES tb_lst_empresa ( id_empresa );

ALTER TABLE tb_lst_usuario
    ADD CONSTRAINT tb_lst_humor_id_humor_fk FOREIGN KEY ( id_humor )
        REFERENCES tb_lst_humor ( id_humor );

ALTER TABLE tb_lst_usuario
    ADD CONSTRAINT tb_lst_perfil_id_perfil_fk FOREIGN KEY ( id_perfil )
        REFERENCES tb_lst_perfil ( id_perfil );

ALTER TABLE tb_lst_usuario
    ADD CONSTRAINT tb_lst_rec_id_recomendacao_fk FOREIGN KEY ( id_recomendacao )
        REFERENCES tb_lst_recomendacao ( id_recomendacao );

ALTER TABLE tb_lst_usuario
    ADD CONSTRAINT tb_lst_std_ret_id_retorno_fk FOREIGN KEY ( id_retorno )
        REFERENCES tb_lst_estado_retorno ( id_retorno );

CREATE SEQUENCE tb_lst_emprego_id_emprego_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_lst_emprego_id_emprego_trg BEFORE
    INSERT ON tb_lst_emprego
    FOR EACH ROW
    WHEN ( new.id_emprego IS NULL )
BEGIN
    :new.id_emprego := tb_lst_emprego_id_emprego_seq.nextval;
END;
/

CREATE SEQUENCE tb_lst_empresa_id_empresa_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_lst_empresa_id_empresa_trg BEFORE
    INSERT ON tb_lst_empresa
    FOR EACH ROW
    WHEN ( new.id_empresa IS NULL )
BEGIN
    :new.id_empresa := tb_lst_empresa_id_empresa_seq.nextval;
END;
/

CREATE SEQUENCE tb_lst_estado_retorno_id_retor START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_lst_estado_retorno_id_retor BEFORE
    INSERT ON tb_lst_estado_retorno
    FOR EACH ROW
    WHEN ( new.id_retorno IS NULL )
BEGIN
    :new.id_retorno := tb_lst_estado_retorno_id_retor.nextval;
END;
/

CREATE SEQUENCE tb_lst_humor_id_humor_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_lst_humor_id_humor_trg BEFORE
    INSERT ON tb_lst_humor
    FOR EACH ROW
    WHEN ( new.id_humor IS NULL )
BEGIN
    :new.id_humor := tb_lst_humor_id_humor_seq.nextval;
END;
/

CREATE SEQUENCE tb_lst_perfil_id_perfil_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_lst_perfil_id_perfil_trg BEFORE
    INSERT ON tb_lst_perfil
    FOR EACH ROW
    WHEN ( new.id_perfil IS NULL )
BEGIN
    :new.id_perfil := tb_lst_perfil_id_perfil_seq.nextval;
END;
/

CREATE SEQUENCE tb_lst_recomendacao_id_recomen START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_lst_recomendacao_id_recomen BEFORE
    INSERT ON tb_lst_recomendacao
    FOR EACH ROW
    WHEN ( new.id_recomendacao IS NULL )
BEGIN
    :new.id_recomendacao := tb_lst_recomendacao_id_recomen.nextval;
END;
/

CREATE SEQUENCE tb_lst_usuario_id_usuario_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_lst_usuario_id_usuario_trg BEFORE
    INSERT ON tb_lst_usuario
    FOR EACH ROW
    WHEN ( new.id_usuario IS NULL )
BEGIN
    :new.id_usuario := tb_lst_usuario_id_usuario_seq.nextval;
END;
/
