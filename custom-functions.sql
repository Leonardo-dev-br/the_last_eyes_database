
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
