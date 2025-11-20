--   GRUPO: Mont Clio
--   NOME PROJETO: The Last Eyes
--   TURMA: 2TDSPX
--   Integrantes e RM :     Leonardo Santos | 557541 
--                          Pedro Santos | 558243 
--                          Vitor Martins | 558244 

--DEFINIÇÃO: FUNÇÃO 1 - fn_gerar_json_usuario
CREATE OR REPLACE FUNCTION fn_gerar_json_usuario (
    p_id_usuario IN NUMBER
) RETURN CLOB
IS
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
    SELECT u.nome_usuario,
           u.sobrenome,
           u.data_nascimento,
           u.cpf,
           TO_CHAR(u.telefone),
           u.email_usuario,
           e.nome_fantasia,
           emp.cargo,
           emp.data_admissao,
           p.desc_perfil,
           h.emocao_palavra_chave,
           h.nivel_humor,
           r.titulo_recomendacao,
           ret.comentario
      INTO v_nome,
           v_sobrenome,
           v_data_nasc,
           v_cpf,
           v_telefone,
           v_email,
           v_empresa,
           v_cargo,
           v_admissao,
           v_perfil,
           v_humor,
           v_nivel_humor,
           v_recomendacao,
           v_retorno
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

    v_escaped := REPLACE(NVL(v_nome,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '{"usuario":{';
    v_json := v_json || '"nome":"' || v_escaped || '",';

    v_escaped := REPLACE(NVL(v_sobrenome,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '"sobrenome":"' || v_escaped || '",';

    v_json := v_json || '"data_nascimento":"' || NVL(TO_CHAR(v_data_nasc,'YYYY-MM-DD'),'') || '",';

    v_escaped := REPLACE(NVL(v_cpf,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '"cpf":"' || v_escaped || '",';

    v_escaped := REPLACE(NVL(v_telefone,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '"contato":{"telefone":"' || v_escaped || '",';

    v_escaped := REPLACE(NVL(v_email,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '"email":"' || v_escaped || '"},';

    v_escaped := REPLACE(NVL(v_empresa,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '"emprego":{"empresa":"' || v_escaped || '",';

    v_escaped := REPLACE(NVL(v_cargo,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '"cargo":"' || v_escaped || '",';

    v_json := v_json || '"admissao":"' || NVL(TO_CHAR(v_admissao,'YYYY-MM-DD'),'') || '"},';

    v_escaped := REPLACE(NVL(v_perfil,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '"perfil":"' || v_escaped || '",';

    v_escaped := REPLACE(NVL(v_humor,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '"humor":{"descricao":"' || v_escaped || '","nivel":' || NVL(TO_CHAR(v_nivel_humor),'0') || '},';

    v_escaped := REPLACE(NVL(v_recomendacao,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '"recomendacao":"' || v_escaped || '",';

    v_escaped := REPLACE(NVL(v_retorno,''), '\', '\\');
    v_escaped := REPLACE(v_escaped, '"', '\"');
    v_json := v_json || '"retorno":"' || v_escaped || '"';

    v_json := v_json || '}}';

    RETURN v_json;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: usuario nao encontrado para id=' || p_id_usuario);
        RETURN NULL;
    WHEN ex_dados_incompletos THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: dados incompletos para usuario id=' || p_id_usuario);
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO desconhecido ao gerar JSON para usuario id=' || p_id_usuario || ' - ' || SQLERRM);
        RETURN NULL;
END fn_gerar_json_usuario;
/

--CHAMADA FUNÇÃO: fn_gerar_json_usuario
SET SERVEROUTPUT ON;
DECLARE
    v_json CLOB;
BEGIN
    v_json := fn_gerar_json_usuario(1); 
    DBMS_OUTPUT.PUT_LINE(v_json);
END;
/

---------------------------------------------------------------------------------------------------------------------------------------------------
--DEFINIÇÃO: FUNÇÃO 2 - fn_calc_compatibilidade
CREATE OR REPLACE FUNCTION fn_calc_compatibilidade (
    p_id_usuario IN NUMBER,
    p_id_emprego IN NUMBER
) RETURN CLOB
IS
    v_json CLOB := TO_CLOB('');
    v_email tb_lst_usuario.email_usuario%TYPE;
    v_cpf_tb tb_lst_usuario.cpf%TYPE;
    v_telefone VARCHAR2(50);
    v_id_perfil NUMBER;
    v_user_cargo tb_lst_emprego.cargo%TYPE;
    v_user_modelo tb_lst_emprego.modelo_trabalho%TYPE;
    v_target_cargo tb_lst_emprego.cargo%TYPE;
    v_target_modelo tb_lst_emprego.modelo_trabalho%TYPE;
    v_target_empresa_id NUMBER;
    v_target_empresa_email tb_lst_empresa.email%TYPE;

    v_perfil_score    NUMBER := 0;
    v_cargo_score     NUMBER := 0;
    v_competencias_score NUMBER := 0;
    v_matches NUMBER := 0;
    v_total_tokens NUMBER := 0;
    v_token VARCHAR2(200);
    v_occ NUMBER := 1;
    v_compat_percent NUMBER := 0;

    ex_validacao_falhou EXCEPTION;
    ex_calculo_erro EXCEPTION;

BEGIN
    SELECT u.email_usuario,
           u.cpf,
           TO_CHAR(u.telefone),
           u.id_perfil,
           ue.cargo,
           ue.modelo_trabalho,
           ue.id_empresa
      INTO v_email,
           v_cpf_tb,
           v_telefone,
           v_id_perfil,
           v_user_cargo,
           v_user_modelo,
           v_target_empresa_id
      FROM tb_lst_usuario u
      LEFT JOIN tb_lst_emprego ue ON u.id_emprego = ue.id_emprego
     WHERE u.id_usuario = p_id_usuario;

    SELECT te.cargo,
           te.modelo_trabalho,
           te.id_empresa
      INTO v_target_cargo,
           v_target_modelo,
           v_target_empresa_id
      FROM tb_lst_emprego te
     WHERE te.id_emprego = p_id_emprego;

    SELECT email
      INTO v_target_empresa_email
      FROM tb_lst_empresa
     WHERE id_empresa = v_target_empresa_id;

    IF v_email IS NULL OR v_cpf_tb IS NULL OR v_telefone IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: dados essenciais ausentes para usuario_id=' || p_id_usuario);
        RAISE ex_validacao_falhou;
    END IF;

    IF NOT REGEXP_LIKE(v_cpf_tb, '^(\d{3}\.\d{3}\.\d{3}\-\d{2}|\d{11})$') THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: CPF com formato inválido para usuario_id=' || p_id_usuario || ' valor=' || v_cpf_tb);
        RAISE ex_validacao_falhou;
    END IF;

    IF NOT REGEXP_LIKE(v_email, '^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$') THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: Email com formato inválido para usuario_id=' || p_id_usuario || ' valor=' || v_email);
        RAISE ex_validacao_falhou;
    END IF;

    IF NOT REGEXP_LIKE(v_telefone, '^\d{10,13}$') THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: Telefone com formato inválido para usuario_id=' || p_id_usuario || ' valor=' || v_telefone);
        RAISE ex_validacao_falhou;
    END IF;

    IF v_id_perfil IS NULL THEN
        v_perfil_score := 0;
    ELSE
        IF v_id_perfil = 2 THEN
            v_perfil_score := 100;
        ELSE
            v_perfil_score := 50;
        END IF;
    END IF;

    v_matches := 0;
    v_total_tokens := 0;
    v_occ := 1;
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

    v_compat_percent := ROUND((v_perfil_score * 0.4) + (v_cargo_score * 0.3) + (v_competencias_score * 0.3));

    IF v_compat_percent >= 75 THEN
        v_json := '{"usuario_id":' || p_id_usuario ||
                  ',"vaga_id":' || p_id_emprego ||
                  ',"compatibilidade_percent":' || v_compat_percent ||
                  ',"detalhes":{"perfil_score":' || v_perfil_score ||
                  ',"cargo_score":' || v_cargo_score ||
                  ',"competencias_score":' || v_competencias_score || '},' ||
                  '"mensagem":"Alta compatibilidade"}';
    ELSIF v_compat_percent >= 50 THEN
        v_json := '{"usuario_id":' || p_id_usuario ||
                  ',"vaga_id":' || p_id_emprego ||
                  ',"compatibilidade_percent":' || v_compat_percent ||
                  ',"detalhes":{"perfil_score":' || v_perfil_score ||
                  ',"cargo_score":' || v_cargo_score ||
                  ',"competencias_score":' || v_competencias_score || '},' ||
                  '"mensagem":"Compatibilidade média"}';
    ELSE
        v_json := '{"usuario_id":' || p_id_usuario ||
                  ',"vaga_id":' || p_id_emprego ||
                  ',"compatibilidade_percent":' || v_compat_percent ||
                  ',"detalhes":{"perfil_score":' || v_perfil_score ||
                  ',"cargo_score":' || v_cargo_score ||
                  ',"competencias_score":' || v_competencias_score || '},' ||
                  '"mensagem":"Baixa compatibilidade"}';
    END IF;

    RETURN v_json;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: usuario ou vaga nao encontrados para ids ' || p_id_usuario || ' / ' || p_id_emprego);
        RETURN NULL;
    WHEN ex_validacao_falhou THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: validacao falhou para usuario_id=' || p_id_usuario);
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO desconhecido durante calculo para usuario_id=' || p_id_usuario || ' vaga_id=' || p_id_emprego || ' - ' || SQLERRM);
        RETURN NULL;
END fn_calc_compatibilidade;
/


--CHAMADA FUNÇÃO: fn_calc_compatibilidade
SET SERVEROUTPUT ON;
DECLARE
    v_out CLOB;
BEGIN
    v_out := fn_calc_compatibilidade(1, 1);
    DBMS_OUTPUT.PUT_LINE(v_out);
END;
/

