--   GRUPO: Mont Clio
--   NOME PROJETO: The Last Eyes
--   TURMA: 2TDSPX
--   Integrantes e RM :     Leonardo Santos | 557541 
--                          Pedro Santos | 558243 
--                          Vitor Martins | 558244 

-- EMPACOTAMENTO - PKG_UTILS
CREATE OR REPLACE PACKAGE PKG_LST_UTILS AS
  FUNCTION FN_VALIDATE_CPF(p_cpf IN VARCHAR2) RETURN BOOLEAN;
  FUNCTION FN_VALIDATE_EMAIL(p_email IN VARCHAR2) RETURN BOOLEAN;
  FUNCTION FN_VALIDATE_PHONE(p_phone IN VARCHAR2) RETURN BOOLEAN;
  FUNCTION FN_ESCAPE_JSON(p_str IN VARCHAR2) RETURN VARCHAR2;
END PKG_LST_UTILS;
/

CREATE OR REPLACE PACKAGE BODY PKG_LST_UTILS AS
  FUNCTION FN_VALIDATE_CPF(p_cpf IN VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    IF p_cpf IS NULL THEN
      RETURN FALSE;
    END IF;
    RETURN REGEXP_LIKE(p_cpf, '^(\d{3}\.\d{3}\.\d{3}\-\d{2}|\d{11})$');
  END FN_VALIDATE_CPF;

  FUNCTION FN_VALIDATE_EMAIL(p_email IN VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    IF p_email IS NULL THEN
      RETURN FALSE;
    END IF;
    RETURN REGEXP_LIKE(p_email, '^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$');
  END FN_VALIDATE_EMAIL;

  FUNCTION FN_VALIDATE_PHONE(p_phone IN VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    IF p_phone IS NULL THEN
      RETURN FALSE;
    END IF;
    RETURN REGEXP_LIKE(p_phone, '^\d{10,13}$');
  END FN_VALIDATE_PHONE;

  FUNCTION FN_ESCAPE_JSON(p_str IN VARCHAR2) RETURN VARCHAR2 IS
    v_out VARCHAR2(32767) := NVL(p_str,'');
  BEGIN
    v_out := REPLACE(v_out, '\', '\\');
    v_out := REPLACE(v_out, '"', '\"');
    v_out := REPLACE(v_out, CHR(10), '\n');
    v_out := REPLACE(v_out, CHR(13), '\r');
    RETURN v_out;
  END FN_ESCAPE_JSON;
END PKG_LST_UTILS;
/


-- EMPACOTAMENTO - PKG_PERFIL
CREATE OR REPLACE PACKAGE PKG_LST_PERFIL AS
  PROCEDURE PRC_INSERT_PERFIL(p_desc_perfil IN tb_lst_perfil.desc_perfil%TYPE);
END PKG_LST_PERFIL;
/

CREATE OR REPLACE PACKAGE BODY PKG_LST_PERFIL AS
  PROCEDURE PRC_INSERT_PERFIL(p_desc_perfil IN tb_lst_perfil.desc_perfil%TYPE) IS
  BEGIN
    INSERT INTO tb_lst_perfil(desc_perfil) VALUES (p_desc_perfil);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('PERFIL inserido');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro PKG_LST_PERFIL.PRC_INSERT_PERFIL: ' || SQLERRM);
      ROLLBACK;
  END PRC_INSERT_PERFIL;
END PKG_LST_PERFIL;
/


-- EMPACOTAMENTO - PKG_HUMOR
CREATE OR REPLACE PACKAGE PKG_LST_HUMOR AS
  PROCEDURE PRC_INSERT_HUMOR(
    p_data_registro IN tb_lst_humor.data_registro%TYPE,
    p_emocao_palavra_chave IN tb_lst_humor.emocao_palavra_chave%TYPE,
    p_nivel_humor IN tb_lst_humor.nivel_humor%TYPE,
    p_cometario IN tb_lst_humor.cometario%TYPE
  );
END PKG_LST_HUMOR;
/

CREATE OR REPLACE PACKAGE BODY PKG_LST_HUMOR AS
  PROCEDURE PRC_INSERT_HUMOR(
    p_data_registro IN tb_lst_humor.data_registro%TYPE,
    p_emocao_palavra_chave IN tb_lst_humor.emocao_palavra_chave%TYPE,
    p_nivel_humor IN tb_lst_humor.nivel_humor%TYPE,
    p_cometario IN tb_lst_humor.cometario%TYPE
  ) IS
  BEGIN
    INSERT INTO tb_lst_humor(
      data_registro,
      emocao_palavra_chave,
      nivel_humor,
      cometario
    ) VALUES (
      p_data_registro,
      p_emocao_palavra_chave,
      p_nivel_humor,
      p_cometario
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('HUMOR inserido');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro PKG_LST_HUMOR.PRC_INSERT_HUMOR: ' || SQLERRM);
      ROLLBACK;
  END PRC_INSERT_HUMOR;
END PKG_LST_HUMOR;
/


-- EMPACOTAMENTO - PKG_RECOMENDACAO
CREATE OR REPLACE PACKAGE PKG_LST_RECOMENDACAO AS
  PROCEDURE PRC_INSERT_RECOMENDACAO(
    p_nivel_humor_alvo IN tb_lst_recomendacao.nivel_humor_alvo%TYPE,
    p_titulo_recomendacao IN tb_lst_recomendacao.titulo_recomendacao%TYPE,
    p_descricao_recomendacao IN tb_lst_recomendacao.descricao_recomendacao%TYPE,
    p_tipo_acao IN tb_lst_recomendacao.tipo_acao%TYPE,
    p_link_acao IN tb_lst_recomendacao.link_acao%TYPE
  );
END PKG_LST_RECOMENDACAO;
/

CREATE OR REPLACE PACKAGE BODY PKG_LST_RECOMENDACAO AS
  PROCEDURE PRC_INSERT_RECOMENDACAO(
    p_nivel_humor_alvo IN tb_lst_recomendacao.nivel_humor_alvo%TYPE,
    p_titulo_recomendacao IN tb_lst_recomendacao.titulo_recomendacao%TYPE,
    p_descricao_recomendacao IN tb_lst_recomendacao.descricao_recomendacao%TYPE,
    p_tipo_acao IN tb_lst_recomendacao.tipo_acao%TYPE,
    p_link_acao IN tb_lst_recomendacao.link_acao%TYPE
  ) IS
    v_id tb_lst_recomendacao.id_recomendacao%TYPE;
  BEGIN
    INSERT INTO tb_lst_recomendacao(
      nivel_humor_alvo,
      titulo_recomendacao,
      descricao_recomendacao,
      tipo_acao,
      link_acao
    ) VALUES (
      p_nivel_humor_alvo,
      p_titulo_recomendacao,
      p_descricao_recomendacao,
      p_tipo_acao,
      p_link_acao
    ) RETURNING id_recomendacao INTO v_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('RECOMENDACAO inserida id=' || v_id);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro PKG_LST_RECOMENDACAO.PRC_INSERT_RECOMENDACAO: ' || SQLERRM);
      ROLLBACK;
  END PRC_INSERT_RECOMENDACAO;
END PKG_LST_RECOMENDACAO;
/


-- EMPACOTAMENTO PKG_ESTADO_RETORNO
CREATE OR REPLACE PACKAGE PKG_LST_ESTADO_RETORNO AS
  PROCEDURE PRC_INSERT_ESTADO_RETORNO(
    p_data_retorno IN tb_lst_estado_retorno.data_retorno%TYPE,
    p_eficacia_percebida IN tb_lst_estado_retorno.eficacia_percebida%TYPE,
    p_comentario IN tb_lst_estado_retorno.comentario%TYPE,
    p_acao_realizada IN tb_lst_estado_retorno.acao_realizada%TYPE
  );
END PKG_LST_ESTADO_RETORNO;
/

CREATE OR REPLACE PACKAGE BODY PKG_LST_ESTADO_RETORNO AS
  PROCEDURE PRC_INSERT_ESTADO_RETORNO(
    p_data_retorno IN tb_lst_estado_retorno.data_retorno%TYPE,
    p_eficacia_percebida IN tb_lst_estado_retorno.eficacia_percebida%TYPE,
    p_comentario IN tb_lst_estado_retorno.comentario%TYPE,
    p_acao_realizada IN tb_lst_estado_retorno.acao_realizada%TYPE
  ) IS
    v_id tb_lst_estado_retorno.id_retorno%TYPE;
  BEGIN
    INSERT INTO tb_lst_estado_retorno(
      data_retorno,
      eficacia_percebida,
      comentario,
      acao_realizada
    ) VALUES (
      p_data_retorno,
      p_eficacia_percebida,
      p_comentario,
      p_acao_realizada
    ) RETURNING id_retorno INTO v_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('ESTADO_RETORNO inserido id=' || v_id);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro PKG_LST_ESTADO_RETORNO.PRC_INSERT_ESTADO_RETORNO: ' || SQLERRM);
      ROLLBACK;
  END PRC_INSERT_ESTADO_RETORNO;
END PKG_LST_ESTADO_RETORNO;
/


-- EMPACOTAMENTO - PKG_EMPRESA
CREATE OR REPLACE PACKAGE PKG_LST_EMPRESA AS
  PROCEDURE PRC_INSERT_EMPRESA(
    p_cnpj IN tb_lst_empresa.cnpj%TYPE,
    p_nome_fantasia IN tb_lst_empresa.nome_fantasia%TYPE,
    p_razao_social IN tb_lst_empresa.razao_social%TYPE,
    p_telefone IN tb_lst_empresa.telefone%TYPE,
    p_email IN tb_lst_empresa.email%TYPE
  );
END PKG_LST_EMPRESA;
/

CREATE OR REPLACE PACKAGE BODY PKG_LST_EMPRESA AS
  PROCEDURE PRC_INSERT_EMPRESA(
    p_cnpj IN tb_lst_empresa.cnpj%TYPE,
    p_nome_fantasia IN tb_lst_empresa.nome_fantasia%TYPE,
    p_razao_social IN tb_lst_empresa.razao_social%TYPE,
    p_telefone IN tb_lst_empresa.telefone%TYPE,
    p_email IN tb_lst_empresa.email%TYPE
  ) IS
    v_id tb_lst_empresa.id_empresa%TYPE;
  BEGIN
    INSERT INTO tb_lst_empresa(
      cnpj,
      nome_fantasia,
      razao_social,
      telefone,
      email
    ) VALUES (
      p_cnpj,
      p_nome_fantasia,
      p_razao_social,
      p_telefone,
      p_email
    ) RETURNING id_empresa INTO v_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('EMPRESA inserida id=' || v_id);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro PKG_LST_EMPRESA.PRC_INSERT_EMPRESA: ' || SQLERRM);
      ROLLBACK;
  END PRC_INSERT_EMPRESA;
END PKG_LST_EMPRESA;
/

-- EMPACOTAMENTO - PKG_EMPREGO
CREATE OR REPLACE PACKAGE PKG_LST_EMPREGO AS
  PROCEDURE PRC_INSERT_EMPREGO(
    p_id_empresa IN tb_lst_emprego.id_empresa%TYPE,
    p_empresa IN tb_lst_emprego.empresa%TYPE,
    p_data_admissao IN tb_lst_emprego.data_admissao%TYPE,
    p_cargo IN tb_lst_emprego.cargo%TYPE,
    p_tipo_contrato IN tb_lst_emprego.tipo_contrato%TYPE,
    p_carga_horaria_semanal IN tb_lst_emprego.carga_horaria_semanal%TYPE,
    p_modelo_trabalho IN tb_lst_emprego.modelo_trabalho%TYPE,
    p_satisfacao_trabalho IN tb_lst_emprego.satisfacao_trabalho%TYPE
  );
  FUNCTION FN_CALC_COMPATIBILIDADE(p_id_usuario IN NUMBER, p_id_emprego IN NUMBER) RETURN CLOB;
END PKG_LST_EMPREGO;
/

CREATE OR REPLACE PACKAGE BODY PKG_LST_EMPREGO AS
  PROCEDURE PRC_INSERT_EMPREGO(
    p_id_empresa IN tb_lst_emprego.id_empresa%TYPE,
    p_empresa IN tb_lst_emprego.empresa%TYPE,
    p_data_admissao IN tb_lst_emprego.data_admissao%TYPE,
    p_cargo IN tb_lst_emprego.cargo%TYPE,
    p_tipo_contrato IN tb_lst_emprego.tipo_contrato%TYPE,
    p_carga_horaria_semanal IN tb_lst_emprego.carga_horaria_semanal%TYPE,
    p_modelo_trabalho IN tb_lst_emprego.modelo_trabalho%TYPE,
    p_satisfacao_trabalho IN tb_lst_emprego.satisfacao_trabalho%TYPE
  ) IS
    v_id tb_lst_emprego.id_emprego%TYPE;
  BEGIN
    INSERT INTO tb_lst_emprego(
      id_empresa,
      empresa,
      data_admissao,
      cargo,
      tipo_contrato,
      carga_horaria_semanal,
      modelo_trabalho,
      satisfacao_trabalho
    ) VALUES (
      p_id_empresa,
      p_empresa,
      p_data_admissao,
      p_cargo,
      p_tipo_contrato,
      p_carga_horaria_semanal,
      p_modelo_trabalho,
      p_satisfacao_trabalho
    ) RETURNING id_emprego INTO v_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('EMPREGO inserido id=' || v_id);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro PKG_LST_EMPREGO.PRC_INSERT_EMPREGO: ' || SQLERRM);
      ROLLBACK;
  END PRC_INSERT_EMPREGO;

  FUNCTION FN_CALC_COMPATIBILIDADE(p_id_usuario IN NUMBER, p_id_emprego IN NUMBER) RETURN CLOB IS
    v_json CLOB := TO_CLOB('');
    v_email tb_lst_usuario.email_usuario%TYPE;
    v_cpf tb_lst_usuario.cpf%TYPE;
    v_telefone VARCHAR2(50);
    v_id_perfil NUMBER;
    v_user_cargo tb_lst_emprego.cargo%TYPE;
    v_user_modelo tb_lst_emprego.modelo_trabalho%TYPE;
    v_target_cargo tb_lst_emprego.cargo%TYPE;
    v_target_modelo tb_lst_emprego.modelo_trabalho%TYPE;
    v_target_empresa_id NUMBER;
    v_perfil_score NUMBER := 0;
    v_cargo_score NUMBER := 0;
    v_competencias_score NUMBER := 0;
    v_matches NUMBER := 0;
    v_total_tokens NUMBER := 0;
    v_occ PLS_INTEGER := 1;
    v_token VARCHAR2(200);
    ex_validacao_falhou EXCEPTION;
  BEGIN
    SELECT u.email_usuario, u.cpf, TO_CHAR(u.telefone), u.id_perfil, ue.cargo, ue.modelo_trabalho, ue.id_empresa
      INTO v_email, v_cpf, v_telefone, v_id_perfil, v_user_cargo, v_user_modelo, v_target_empresa_id
      FROM tb_lst_usuario u LEFT JOIN tb_lst_emprego ue ON u.id_emprego = ue.id_emprego
     WHERE u.id_usuario = p_id_usuario;

    SELECT te.cargo, te.modelo_trabalho, te.id_empresa
      INTO v_target_cargo, v_target_modelo, v_target_empresa_id
      FROM tb_lst_emprego te
     WHERE te.id_emprego = p_id_emprego;

    IF v_email IS NULL OR v_cpf IS NULL OR v_telefone IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('ERRO: dados essenciais ausentes para usuario_id=' || p_id_usuario);
      RAISE ex_validacao_falhou;
    END IF;

    IF NOT PKG_LST_UTILS.FN_VALIDATE_CPF(v_cpf) THEN
      DBMS_OUTPUT.PUT_LINE('ERRO: CPF invalido para usuario_id=' || p_id_usuario || ' valor=' || v_cpf);
      RAISE ex_validacao_falhou;
    END IF;

    IF NOT PKG_LST_UTILS.FN_VALIDATE_EMAIL(v_email) THEN
      DBMS_OUTPUT.PUT_LINE('ERRO: Email invalido para usuario_id=' || p_id_usuario || ' valor=' || v_email);
      RAISE ex_validacao_falhou;
    END IF;

    IF NOT PKG_LST_UTILS.FN_VALIDATE_PHONE(v_telefone) THEN
      DBMS_OUTPUT.PUT_LINE('ERRO: Telefone invalido para usuario_id=' || p_id_usuario || ' valor=' || v_telefone);
      RAISE ex_validacao_falhou;
    END IF;

    IF v_id_perfil IS NULL THEN
      v_perfil_score := 0;
    ELSIF v_id_perfil = 2 THEN
      v_perfil_score := 100;
    ELSE
      v_perfil_score := 50;
    END IF;

    LOOP
      v_token := REGEXP_SUBSTR(NVL(v_target_cargo,''), '[^ ]+', 1, v_occ);
      EXIT WHEN v_token IS NULL;
      v_total_tokens := v_total_tokens + 1;
      IF INSTR(LOWER(NVL(v_user_cargo,'')), LOWER(v_token)) > 0 THEN
        v_matches := v_matches + 1;
      END IF;
      v_occ := v_occ + 1;
    END LOOP;

    IF v_total_tokens = 0 THEN
      v_cargo_score := 0;
    ELSE
      v_cargo_score := ROUND((v_matches / v_total_tokens) * 100);
    END IF;

    IF NVL(v_user_modelo,'X') = NVL(v_target_modelo,'Y') THEN
      v_competencias_score := 100;
    ELSE
      v_competencias_score := 0;
    END IF;

    v_competencias_score := ROUND((v_cargo_score + v_competencias_score) / 2);

    v_json := '{"usuario_id":' || p_id_usuario || ',"vaga_id":' || p_id_emprego ||
             ',"compatibilidade_percent":' || ROUND((v_perfil_score*0.4)+(v_cargo_score*0.3)+(v_competencias_score*0.3)) ||
             ',"detalhes":{"perfil_score":' || v_perfil_score || ',"cargo_score":' || v_cargo_score ||
             ',"competencias_score":' || v_competencias_score || '},"mensagem":"ok"}';

    RETURN v_json;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('ERRO: usuario ou vaga nao encontrados para ids ' || p_id_usuario || ' / ' || p_id_emprego);
      RETURN NULL;
    WHEN ex_validacao_falhou THEN
      DBMS_OUTPUT.PUT_LINE('ERRO: validacao falhou para usuario_id=' || p_id_usuario);
      RETURN NULL;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERRO PKG_LST_EMPREGO.FN_CALC_COMPATIBILIDADE desconhecido para usuario_id=' || p_id_usuario || ' vaga_id=' || p_id_emprego || ' - ' || SQLERRM);
      RETURN NULL;
  END FN_CALC_COMPATIBILIDADE;
END PKG_LST_EMPREGO;
/

-- EMPACOTAMENTO - PKG_USUARIO
CREATE OR REPLACE PACKAGE PKG_LST_USUARIO AS
  PROCEDURE PRC_INSERT_USUARIO(
    p_id_perfil IN tb_lst_usuario.id_perfil%TYPE,
    p_id_humor IN tb_lst_usuario.id_humor%TYPE,
    p_id_recomendacao IN tb_lst_usuario.id_recomendacao%TYPE,
    p_id_retorno IN tb_lst_usuario.id_retorno%TYPE,
    p_id_emprego IN tb_lst_usuario.id_emprego%TYPE,
    p_id_empresa IN tb_lst_usuario.id_empresa%TYPE,
    p_nome_usuario IN tb_lst_usuario.nome_usuario%TYPE,
    p_sobrenome IN tb_lst_usuario.sobrenome%TYPE,
    p_data_nasc IN tb_lst_usuario.data_nascimento%TYPE,
    p_cpf IN tb_lst_usuario.cpf%TYPE,
    p_telefone IN tb_lst_usuario.telefone%TYPE,
    p_email_usuario IN tb_lst_usuario.email_usuario%TYPE,
    p_senha IN tb_lst_usuario.senha%TYPE
  );
  FUNCTION FN_GENERATE_USUARIO_JSON(p_id_usuario IN NUMBER) RETURN CLOB;
END PKG_LST_USUARIO;
/

CREATE OR REPLACE PACKAGE BODY PKG_LST_USUARIO AS
  PROCEDURE PRC_INSERT_USUARIO(
    p_id_perfil IN tb_lst_usuario.id_perfil%TYPE,
    p_id_humor IN tb_lst_usuario.id_humor%TYPE,
    p_id_recomendacao IN tb_lst_usuario.id_recomendacao%TYPE,
    p_id_retorno IN tb_lst_usuario.id_retorno%TYPE,
    p_id_emprego IN tb_lst_usuario.id_emprego%TYPE,
    p_id_empresa IN tb_lst_usuario.id_empresa%TYPE,
    p_nome_usuario IN tb_lst_usuario.nome_usuario%TYPE,
    p_sobrenome IN tb_lst_usuario.sobrenome%TYPE,
    p_data_nasc IN tb_lst_usuario.data_nascimento%TYPE,
    p_cpf IN tb_lst_usuario.cpf%TYPE,
    p_telefone IN tb_lst_usuario.telefone%TYPE,
    p_email_usuario IN tb_lst_usuario.email_usuario%TYPE,
    p_senha IN tb_lst_usuario.senha%TYPE
  ) IS
    v_id tb_lst_usuario.id_usuario%TYPE;
  BEGIN
    INSERT INTO tb_lst_usuario(
      id_perfil,
      id_humor,
      id_recomendacao,
      id_retorno,
      id_emprego,
      id_empresa,
      nome_usuario,
      sobrenome,
      data_nascimento,
      cpf,
      telefone,
      email_usuario,
      senha
    ) VALUES (
      p_id_perfil,
      p_id_humor,
      p_id_recomendacao,
      p_id_retorno,
      p_id_emprego,
      p_id_empresa,
      p_nome_usuario,
      p_sobrenome,
      p_data_nasc,
      p_cpf,
      p_telefone,
      p_email_usuario,
      p_senha
    ) RETURNING id_usuario INTO v_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('USUARIO inserido id=' || v_id);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro PKG_LST_USUARIO.PRC_INSERT_USUARIO: ' || SQLERRM);
      ROLLBACK;
  END PRC_INSERT_USUARIO;

  FUNCTION FN_GENERATE_USUARIO_JSON(p_id_usuario IN NUMBER) RETURN CLOB IS
    v_json CLOB := TO_CLOB('');
    v_nome VARCHAR2(100);
    v_sobrenome VARCHAR2(100);
    v_data_nasc DATE;
    v_cpf VARCHAR2(25);
    v_telefone VARCHAR2(50);
    v_email VARCHAR2(150);
    v_empresa VARCHAR2(200);
    v_cargo VARCHAR2(200);
    v_admissao DATE;
    v_perfil VARCHAR2(100);
    v_humor VARCHAR2(100);
    v_nivel_humor INTEGER;
    v_recomendacao VARCHAR2(4000);
    v_retorno VARCHAR2(4000);
    v_escaped VARCHAR2(4000);
    ex_dados_incompletos EXCEPTION;
  BEGIN
    SELECT u.nome_usuario, u.sobrenome, u.data_nascimento, u.cpf, TO_CHAR(u.telefone), u.email_usuario, e.nome_fantasia, emp.cargo, emp.data_admissao, p.desc_perfil, h.emocao_palavra_chave, h.nivel_humor, r.titulo_recomendacao, ret.comentario
      INTO v_nome, v_sobrenome, v_data_nasc, v_cpf, v_telefone, v_email, v_empresa, v_cargo, v_admissao, v_perfil, v_humor, v_nivel_humor, v_recomendacao, v_retorno
      FROM tb_lst_usuario u
      LEFT JOIN tb_lst_emprego emp ON u.id_emprego = emp.id_emprego
      LEFT JOIN tb_lst_empresa e ON u.id_empresa = e.id_empresa
      LEFT JOIN tb_lst_perfil p ON u.id_perfil = p.id_perfil
      LEFT JOIN tb_lst_humor h ON u.id_humor = h.id_humor
      LEFT JOIN tb_lst_recomendacao r ON u.id_recomendacao = r.id_recomendacao
      LEFT JOIN tb_lst_estado_retorno ret ON u.id_retorno = ret.id_retorno
     WHERE u.id_usuario = p_id_usuario;

    IF v_nome IS NULL OR v_email IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('ERRO: dados essenciais ausentes para user_id=' || p_id_usuario);
      RAISE ex_dados_incompletos;
    END IF;

    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_nome);
    v_json := v_json || '{"usuario":{';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_nome);
    v_json := v_json || '"nome":"' || v_escaped || '",';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_sobrenome);
    v_json := v_json || '"sobrenome":"' || v_escaped || '",';
    v_json := v_json || '"data_nascimento":"' || NVL(TO_CHAR(v_data_nasc,'YYYY-MM-DD'),'') || '",';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_cpf);
    v_json := v_json || '"cpf":"' || v_escaped || '",';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_telefone);
    v_json := v_json || '"contato":{"telefone":"' || v_escaped || '",';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_email);
    v_json := v_json || '"email":"' || v_escaped || '"},';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_empresa);
    v_json := v_json || '"emprego":{"empresa":"' || v_escaped || '",';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_cargo);
    v_json := v_json || '"cargo":"' || v_escaped || '",';
    v_json := v_json || '"admissao":"' || NVL(TO_CHAR(v_admissao,'YYYY-MM-DD'),'') || '"},';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_perfil);
    v_json := v_json || '"perfil":"' || v_escaped || '",';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_humor);
    v_json := v_json || '"humor":{"descricao":"' || v_escaped || '","nivel":' || NVL(TO_CHAR(v_nivel_humor),'0') || '},';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_recomendacao);
    v_json := v_json || '"recomendacao":"' || v_escaped || '",';
    v_escaped := PKG_LST_UTILS.FN_ESCAPE_JSON(v_retorno);
    v_json := v_json || '"retorno":"' || v_escaped || '"';
    v_json := v_json || '}}';
    RETURN v_json;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('ERRO PKG_LST_USUARIO.FN_GENERATE_USUARIO_JSON: usuario nao encontrado id=' || p_id_usuario);
      RETURN NULL;
    WHEN ex_dados_incompletos THEN
      DBMS_OUTPUT.PUT_LINE('ERRO PKG_LST_USUARIO.FN_GENERATE_USUARIO_JSON: dados incompletos id=' || p_id_usuario);
      RETURN NULL;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERRO PKG_LST_USUARIO.FN_GENERATE_USUARIO_JSON desconhecido para id=' || p_id_usuario || ' - ' || SQLERRM);
      RETURN NULL;
  END FN_GENERATE_USUARIO_JSON;
END PKG_LST_USUARIO;
/

-- EMPACOTAMENTO - PKG_EXPORTACAO
CREATE OR REPLACE PACKAGE PKG_LST_EXPORTACAO AS
  FUNCTION FN_EXPORT_TABLE_JSON(p_table IN VARCHAR2) RETURN CLOB;
  PROCEDURE PRC_EXPORT_TABLE_TO_FILE(p_table IN VARCHAR2);
  PROCEDURE PRC_EXPORT_SCHEMA_JSON;
END PKG_LST_EXPORTACAO;
/

CREATE OR REPLACE PACKAGE BODY PKG_LST_EXPORTACAO AS
  FUNCTION FN_EXPORT_TABLE_JSON(p_table IN VARCHAR2) RETURN CLOB IS
    v_cur INTEGER;
    v_col_cnt INTEGER;
    v_desc DBMS_SQL.DESC_TAB2;
    v_col_val VARCHAR2(4000);
    v_json CLOB := TO_CLOB('');
    v_row_json VARCHAR2(32767);
    v_first_row PLS_INTEGER := 1;
    v_i PLS_INTEGER;
    v_col_name VARCHAR2(200);
    v_sql VARCHAR2(4000);
    ex_no_data EXCEPTION;
  BEGIN
    v_sql := 'SELECT * FROM ' || p_table;
    v_cur := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(v_cur, v_sql, DBMS_SQL.NATIVE);
    DBMS_SQL.DESCRIBE_COLUMNS2(v_cur, v_col_cnt, v_desc);
    FOR v_i IN 1 .. v_col_cnt LOOP
      DBMS_SQL.DEFINE_COLUMN(v_cur, v_i, v_col_val, 4000);
    END LOOP;
    DBMS_SQL.EXECUTE(v_cur);
    v_json := v_json || '{ "' || LOWER(p_table) || '": [';
    WHILE DBMS_SQL.FETCH_ROWS(v_cur) > 0 LOOP
      IF v_first_row = 0 THEN
        v_json := v_json || ',';
      END IF;
      v_row_json := '{';
      FOR v_i IN 1 .. v_col_cnt LOOP
        DBMS_SQL.COLUMN_VALUE(v_cur, v_i, v_col_val);
        v_col_name := v_desc(v_i).col_name;
        IF v_col_val IS NOT NULL THEN
          v_col_val := PKG_LST_UTILS.FN_ESCAPE_JSON(v_col_val);
          v_row_json := v_row_json || '"' || LOWER(v_col_name) || '":"' || v_col_val || '"';
        ELSE
          v_row_json := v_row_json || '"' || LOWER(v_col_name) || '":null';
        END IF;
        IF v_i < v_col_cnt THEN
          v_row_json := v_row_json || ',';
        END IF;
      END LOOP;
      v_row_json := v_row_json || '}';
      v_json := v_json || v_row_json;
      v_first_row := 0;
    END LOOP;
    v_json := v_json || '] }';
    DBMS_SQL.CLOSE_CURSOR(v_cur);
    IF v_first_row = 1 THEN
      RAISE ex_no_data;
    END IF;
    RETURN v_json;
  EXCEPTION
    WHEN ex_no_data THEN
      IF DBMS_SQL.IS_OPEN(v_cur) THEN
        DBMS_SQL.CLOSE_CURSOR(v_cur);
      END IF;
      DBMS_OUTPUT.PUT_LINE('AVISO PKG_LST_EXPORTACAO.FN_EXPORT_TABLE_JSON: tabela ' || p_table || ' vazia ou nao existe.');
      RETURN NULL;
    WHEN OTHERS THEN
      IF DBMS_SQL.IS_OPEN(v_cur) THEN
        DBMS_SQL.CLOSE_CURSOR(v_cur);
      END IF;
      DBMS_OUTPUT.PUT_LINE('ERRO PKG_LST_EXPORTACAO.FN_EXPORT_TABLE_JSON tabela ' || p_table || ' - ' || SQLERRM);
      RETURN NULL;
  END FN_EXPORT_TABLE_JSON;

  PROCEDURE PRC_EXPORT_TABLE_TO_FILE(p_table IN VARCHAR2) IS
    v_json CLOB;
    v_file UTL_FILE.FILE_TYPE;
    v_fname VARCHAR2(200);
  BEGIN
    v_json := FN_EXPORT_TABLE_JSON(p_table);
    IF v_json IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('Nenhum JSON gerado para tabela ' || p_table);
      RETURN;
    END IF;
    v_fname := LOWER(p_table) || '.json';
    v_file := UTL_FILE.FOPEN('RESULTS_JSON', v_fname, 'w', 32767);
    UTL_FILE.PUT_LINE(v_file, v_json);
    UTL_FILE.FCLOSE(v_file);
    DBMS_OUTPUT.PUT_LINE('Arquivo gerado: ' || v_fname);
  EXCEPTION
    WHEN UTL_FILE.INVALID_PATH THEN
      DBMS_OUTPUT.PUT_LINE('ERRO UTL_FILE: caminho invalido para RESULTS_JSON.');
    WHEN UTL_FILE.INVALID_MODE THEN
      DBMS_OUTPUT.PUT_LINE('ERRO UTL_FILE: modo invalido.');
    WHEN UTL_FILE.WRITE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('ERRO UTL_FILE: erro de escrita no arquivo.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERRO PKG_LST_EXPORTACAO.PRC_EXPORT_TABLE_TO_FILE: ' || SQLERRM);
  END PRC_EXPORT_TABLE_TO_FILE;

  PROCEDURE PRC_EXPORT_SCHEMA_JSON IS
    CURSOR cur_tables IS
      SELECT table_name FROM user_tables ORDER BY table_name;
    v_table VARCHAR2(200);
  BEGIN
    FOR rec IN cur_tables LOOP
      v_table := rec.table_name;
      PRC_EXPORT_TABLE_TO_FILE(v_table);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Exportacao do schema concluida.');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERRO PKG_LST_EXPORTACAO.PRC_EXPORT_SCHEMA_JSON: ' || SQLERRM);
  END PRC_EXPORT_SCHEMA_JSON;
END PKG_LST_EXPORTACAO;
/
