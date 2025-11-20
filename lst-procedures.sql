--DEFINIÇÃO: inserir_tb_lst_perfil
CREATE OR REPLACE PROCEDURE inserir_tb_lst_perfil (
    p_desc_perfil IN tb_lst_perfil.desc_perfil%TYPE
)
IS
BEGIN
    INSERT INTO tb_lst_perfil (desc_perfil)
    VALUES (p_desc_perfil);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Registro inserido na TB_LST_PERFIL com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir registro na TB_LST_PERFIL: ' || SQLERRM);
        ROLLBACK;
END inserir_tb_lst_perfil;
/


--CHAMADA: inserir_tb_lst_perfil
BEGIN
    inserir_tb_lst_perfil('ADM');
END;
/

BEGIN
    inserir_tb_lst_perfil('COLABORADOR');
END;
/
----------------------------------------------------------------------------------------------

--DEFINIÇÃO: inserir_tb_lst_humor
CREATE OR REPLACE PROCEDURE inserir_tb_lst_humor (
    p_data_registro        IN tb_lst_humor.data_registro%TYPE,
    p_emocao_palavra_chave IN tb_lst_humor.emocao_palavra_chave%TYPE,
    p_nivel_humor          IN tb_lst_humor.nivel_humor%TYPE,
    p_cometario            IN tb_lst_humor.cometario%TYPE
)
IS
BEGIN
    INSERT INTO tb_lst_humor (
        data_registro,
        emocao_palavra_chave,
        nivel_humor,
        cometario
    )
    VALUES (
        p_data_registro,
        p_emocao_palavra_chave,
        p_nivel_humor,
        p_cometario
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Registro inserido na TB_LST_HUMOR com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir registro na TB_LST_HUMOR: ' || SQLERRM);
        ROLLBACK;
END inserir_tb_lst_humor;
/

--CHAMADA: inserir_tb_lst_humor
BEGIN inserir_tb_lst_humor(DATE '1931-01-25', 'estressado',      3, 'Dia muito tenso no trabalho'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1943-10-31', 'deprimido',       2, 'Sentindo falta de energia'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1945-12-23', 'cansado',         4, 'Dormiu pouco hoje'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1946-12-08', 'ansioso',         5, 'Preocupação com prazos'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1948-12-05', 'calmo',           7, 'Manhã tranquila e produtiva'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1953-12-06', 'motivado',        8, 'Conseguiu avançar em metas'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1970-12-20', 'irritado',        3, 'Pequenos problemas acumulados'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1971-06-27', 'preocupado',      4, 'Questões pessoais em mente'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1985-12-22', 'frustrado',       3, 'Resultados abaixo do esperado'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1991-12-08', 'entediado',       5, 'Dia sem grandes novidades'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1992-12-13', 'inspirado',       9, 'Ideias criativas surgiram'); END;
/
BEGIN inserir_tb_lst_humor(DATE '1993-12-15', 'exausto',         2, 'Semana muito pesada'); END;
/
BEGIN inserir_tb_lst_humor(DATE '2005-12-18', 'sobrecarregado',  3, 'Muitas demandas simultâneas'); END;
/
BEGIN inserir_tb_lst_humor(DATE '2006-12-17', 'confiante',       8, 'Sentindo progresso e clareza'); END;
/
BEGIN inserir_tb_lst_humor(DATE '2007-12-02', 'tranquilo',        7, 'Fim de tarde equilibrado'); END;
/

----------------------------------------------------------------------------------------------

--DEFINIÇÃO: inserir_tb_lst_estado_retorno
CREATE OR REPLACE PROCEDURE inserir_tb_lst_estado_retorno (
    p_data_retorno       IN tb_lst_estado_retorno.data_retorno%TYPE,
    p_eficacia_percebida IN tb_lst_estado_retorno.eficacia_percebida%TYPE,
    p_comentario         IN tb_lst_estado_retorno.comentario%TYPE,
    p_acao_realizada     IN tb_lst_estado_retorno.acao_realizada%TYPE
)
IS
BEGIN
    INSERT INTO tb_lst_estado_retorno (
        data_retorno,
        eficacia_percebida,
        comentario,
        acao_realizada
    )
    VALUES (
        p_data_retorno,
        p_eficacia_percebida,
        p_comentario,
        p_acao_realizada
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Registro inserido na TB_LST_ESTADO_RETORNO com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'Erro ao inserir registro na TB_LST_ESTADO_RETORNO: ' || SQLERRM
        );
        ROLLBACK;
END inserir_tb_lst_estado_retorno;
/

--CHAMADA: inserir_tb_lst_estado_retorno
BEGIN inserir_tb_lst_estado_retorno(DATE '1931-01-26', 7, 'Praticou respiração guiada e reduziu o estresse.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1943-11-01', 8, 'Seguiu rotina sugerida e relatou mais esperança.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1945-12-24', 6, 'Descansou conforme indicado e se sente melhor.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1946-12-09', 7, 'Exercício de foco ajudou a reduzir a ansiedade.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1948-12-06', 8, 'Prática de meditação manteve o estado calmo.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1953-12-07', 9, 'Planejamento diário aumentou a motivação.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1970-12-21', 6, 'Fez pausa orientada e reduziu irritação.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1971-06-28', 7, 'Aplicou técnica sugerida e ficou menos preocupado.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1985-12-23', 7, 'Leitura indicada diminuiu a frustração.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1991-12-09', 6, 'Atividade leve ajudou a lidar com o tédio.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1992-12-14', 9, 'Exercício criativo reforçou o sentimento de inspiração.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '1993-12-16', 8, 'Seguiu recomendação e reduziu bastante o cansaço extremo.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '2005-12-19', 7, 'Organizou tarefas e reduziu a sobrecarga.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '2006-12-18', 9, 'Aplicou técnica de mentalização e se sente mais confiante.', 'S'); END;
/
BEGIN inserir_tb_lst_estado_retorno(DATE '2007-12-03', 8, 'Sessão de relaxamento manteve sensação de tranquilidade.', 'S'); END;
/

----------------------------------------------------------------------------------------------

--DEFINIÇÃO: inserir_tb_lst_recomendacao_procedure
CREATE OR REPLACE PROCEDURE inserir_tb_lst_recomendacao_procedure (
    p_nivel_humor_alvo       IN tb_lst_recomendacao.nivel_humor_alvo%TYPE,
    p_titulo_recomendacao    IN tb_lst_recomendacao.titulo_recomendacao%TYPE,
    p_descricao_recomendacao IN tb_lst_recomendacao.descricao_recomendacao%TYPE,
    p_tipo_acao              IN tb_lst_recomendacao.tipo_acao%TYPE,
    p_link_acao              IN tb_lst_recomendacao.link_acao%TYPE
)
IS
    -- variável local para armazenar o novo ID (gerado pelo trigger)
    v_new_id tb_lst_recomendacao.id_recomendacao%TYPE;

BEGIN
    INSERT INTO tb_lst_recomendacao (
        nivel_humor_alvo,
        titulo_recomendacao,
        descricao_recomendacao,
        tipo_acao,
        link_acao
    )
    VALUES (
        p_nivel_humor_alvo,
        p_titulo_recomendacao,
        p_descricao_recomendacao,
        p_tipo_acao,
        p_link_acao
    )
    RETURNING id_recomendacao INTO v_new_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Registro inserido com sucesso!');
    DBMS_OUTPUT.PUT_LINE('Novo ID gerado: ' || v_new_id);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir na tb_lst_recomendacao: ' || SQLERRM);
END inserir_tb_lst_recomendacao_procedure;
/

--CHAMADA: inserir_tb_lst_recomendacao_procedure
BEGIN
    inserir_tb_lst_recomendacao_procedure(1, 'Falar com alguém de confiança',
        'Conversar ajuda a aliviar emoções intensas.', 'CONVERSA', NULL);
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(1, 'Praticar respiração profunda',
        'Técnica para diminuir estresse e tristeza.', 'EXERCICIO', 'https://youtu.be/respiracao');
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(2, 'Realizar caminhada leve',
        'Atividade física leve reduz ansiedade e tensão.', 'EXERCICIO', NULL);
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(2, 'Ouvir música relaxante',
        'Playlist de músicas para acalmar a mente.', 'MUSICA', 'https://open.spotify.com/relax');
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(3, 'Fazer alongamentos rápidos',
        'Alongar ajuda a reduzir dores e cansaço acumulado.', 'EXERCICIO', NULL);
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(3, 'Fazer pausa de 5 minutos',
        'Pequenas pausas recuperam energia e foco.', 'PAUSA', NULL);
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(4, 'Organizar tarefas do dia',
        'Organizar a rotina reduz sensação de sobrecarga.', 'ORGANIZACAO', NULL);
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(4, 'Tomar água e respirar',
        'Hidratação afeta diretamente disposição e humor.', 'HABITO', NULL);
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(5, 'Manter atividade física regular',
        'Cuida do corpo e mantém o humor estável.', 'EXERCICIO', NULL);
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(5, 'Registrar pequenos progressos',
        'Reforça sensação de realização e motivação.', 'REFLEXAO', NULL);
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(1, 'Tentar breve meditação guiada',
        'Auxilia em momentos de tristeza e falta de energia.', 'MEDITACAO', 'https://youtu.be/meditacao');
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(2, 'Tomar banho quente relaxante',
        'Reduz tensão física e mental.', 'HABITO', NULL);
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(3, 'Revisar metas do dia',
        'Traz clareza em momentos de estresse.', 'ORGANIZACAO', NULL);
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(4, 'Praticar respiração box breathing',
        'Técnica eficiente para controlar estados de estresse.', 'EXERCICIO', 'https://youtu.be/boxbreathing');
END;
/

BEGIN
    inserir_tb_lst_recomendacao_procedure(5, 'Escrever algo positivo sobre o dia',
        'Reforço emocional mantém equilíbrio e motivação.', 'REFLEXAO', NULL);
END;
/

----------------------------------------------------------------------------------------------

--DEFINIÇÃO: inserir_tb_lst_empresa_procedure
CREATE OR REPLACE PROCEDURE inserir_tb_lst_empresa_procedure (
    p_cnpj          IN INTEGER,
    p_nome_fantasia IN VARCHAR2,
    p_razao_social  IN VARCHAR2,
    p_telefone      IN INTEGER,
    p_email         IN VARCHAR2
) AS
    v_msg_erro VARCHAR2(200);
BEGIN
    INSERT INTO tb_lst_empresa (
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
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Registro inserido com sucesso em tb_lst_empresa!');
EXCEPTION
    WHEN OTHERS THEN
        v_msg_erro := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir na tb_lst_empresa: ' || v_msg_erro);
END;
/

--CHAMADA: inserir_tb_lst_empresa_procedure
BEGIN
    inserir_tb_lst_empresa_procedure(
        12345678000101,
        'TechNova Solutions',
        'TechNova Soluções Tecnológicas LTDA',
        1133557799,
        'contato@technova.com'
    );
END;
/

BEGIN
    inserir_tb_lst_empresa_procedure(
        99887766000155,
        'HumanFocus RH',
        'HumanFocus Gestão de Pessoas LTDA',
        1122003300,
        'suporte@humanfocus.com'
    );
END;
/

BEGIN
    inserir_tb_lst_empresa_procedure(
        55443322000199,
        'GreenMind Sustentabilidade',
        'GreenMind Consultoria Ambiental LTDA',
        1144556677,
        'contato@greenmind.com'
    );
END;
/

BEGIN
    inserir_tb_lst_empresa_procedure(
        77665544000122,
        'VisionAI Corp',
        'VisionAI Inteligência Artificial S.A.',
        11988776655,
        'info@visionai.com'
    );
END;
/

BEGIN
    inserir_tb_lst_empresa_procedure(
        11223344000188,
        'HealthConnect',
        'HealthConnect Serviços de Bem-Estar LTDA',
        1188776655,
        'hello@healthconnect.com'
    );
END;
/

----------------------------------------------------------------------------------------------

--DEFINIÇÃO: inserir_tb_lst_emprego_procedure
CREATE OR REPLACE PROCEDURE inserir_tb_lst_emprego_procedure (
    p_id_empresa            IN INTEGER,
    p_empresa               IN VARCHAR2,
    p_data_admissao         IN DATE,
    p_cargo                 IN VARCHAR2,
    p_tipo_contrato         IN VARCHAR2,
    p_carga_horaria_semanal IN INTEGER,
    p_modelo_trabalho       IN VARCHAR2,
    p_satisfacao_trabalho   IN INTEGER
) AS
    v_msg_erro VARCHAR2(300);
BEGIN
    INSERT INTO tb_lst_emprego (
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
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Registro inserido com sucesso em tb_lst_emprego!');
EXCEPTION
    WHEN OTHERS THEN
        v_msg_erro := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir na tb_lst_emprego: ' || v_msg_erro);
END;
/

--CHAMADA: inserir_tb_lst_emprego_procedure
BEGIN
    inserir_tb_lst_emprego_procedure(
        1,
        'TechNova Solutions',
        DATE '2022-03-10',
        'Desenvolvedor Full Stack',
        'CLT',
        40,
        'Híbrido',
        4
    );
END;
/

BEGIN
    inserir_tb_lst_emprego_procedure(
        2,
        'HumanFocus RH',
        DATE '2021-11-05',
        'Analista de Recursos Humanos',
        'CLT',
        44,
        'Presencial',
        3
    );
END;
/

BEGIN
    inserir_tb_lst_emprego_procedure(
        3,
        'GreenMind Sustentabilidade',
        DATE '2023-02-14',
        'Consultor Ambiental Pleno',
        'PJ',
        30,
        'Remoto',
        5
    );
END;
/

BEGIN
    inserir_tb_lst_emprego_procedure(
        4,
        'VisionAI Corp',
        DATE '2024-01-08',
        'Engenheiro de IA',
        'CLT',
        40,
        'Híbrido',
        5
    );
END;
/

BEGIN
    inserir_tb_lst_emprego_procedure(
        5,
        'HealthConnect',
        DATE '2020-09-21',
        'Especialista em Bem-Estar Corporativo',
        'CLT',
        36,
        'Remoto',
        4
    );
END;
/

----------------------------------------------------------------------------------------------

--DEFINIÇÃO: inserir_tb_lst_usuario_procedure
CREATE OR REPLACE PROCEDURE inserir_tb_lst_usuario_procedure (
    p_id_perfil       IN INTEGER,
    p_id_humor        IN INTEGER,
    p_id_recomendacao IN INTEGER,
    p_id_retorno      IN INTEGER,
    p_id_emprego      IN INTEGER,
    p_id_empresa      IN INTEGER,
    p_nome_usuario    IN VARCHAR2,
    p_sobrenome       IN VARCHAR2,
    p_data_nasc       IN DATE,
    p_cpf             IN VARCHAR2,
    p_telefone        IN INTEGER,
    p_email_usuario   IN VARCHAR2,
    p_senha           IN VARCHAR2
) AS
    v_msg_erro VARCHAR2(300);
BEGIN
    INSERT INTO tb_lst_usuario (
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
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Usuário inserido com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        v_msg_erro := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir na tb_lst_usuario: ' || v_msg_erro);
END;
/

--CHAMADA: inserir_tb_lst_perfil
BEGIN
    inserir_tb_lst_usuario_procedure(
        1,                     -- ADM
        3,                     -- Humor: "cansado"
        3,                     -- Recom.: pausa ativa
        3,                     -- Retorno coerente
        1,                     -- Emprego na TechNova
        1,                     -- Empresa TechNova
        'Lucas',
        'Ferreira',
        DATE '1990-04-12',
        '123.456.789-01',
        11987654321,
        'lucas.ferreira@technova.com',
        'SenhaAdm123'
    );
END;
/

BEGIN
    inserir_tb_lst_usuario_procedure(
        2,
        5,                    -- Humor: triste
        1,                    -- Recom.: mindfulness
        1,                    -- Retorno: sentiu melhora
        2,                    -- Emprego HumanFocus
        2,
        'Mariana',
        'Santos',
        DATE '1987-09-03',
        '987.654.321-00',
        11966554433,
        'mariana.santos@humanfocus.com',
        'Focus2024'
    );
END;
/

BEGIN
    inserir_tb_lst_usuario_procedure(
        2,
        7,                     -- Humor: desanimado
        4,                     -- Recom.: atividade leve
        4,
        3,                     -- GreenMind
        3,
        'Eduardo',
        'Menezes',
        DATE '1994-07-21',
        '456.789.123-55',
        11999887766,
        'edu.menezes@greenmind.com',
        'EcoLife#92'
    );
END;
/

BEGIN
    inserir_tb_lst_usuario_procedure(
        2,
        10,                    -- Humor: sobrecarregado
        5,                     -- Recom.: alongamento guiado
        5,
        4,                     -- VisionAI
        4,
        'Beatriz',
        'Lima',
        DATE '1996-12-10',
        '789.123.456-44',
        11955334422,
        'beatriz.lima@visionai.com',
        'IAvision2025'
    );
END;
/

BEGIN
    inserir_tb_lst_usuario_procedure(
        2,
        12,                     -- Humor: desmotivado
        8,                      -- Recom.: conversa com mentor
        8,
        5,                      -- HealthConnect
        5,
        'Carolina',
        'Dias',
        DATE '1989-02-18',
        '159.753.468-90',
        11944556677,
        'carolina.dias@healthconnect.com',
        'BemEstar#2025'
    );
END;
/


----------------------------------------------------------------------------------------------