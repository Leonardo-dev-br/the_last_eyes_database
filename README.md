# README — Projeto The Last Eyes

## **Turma:** 2TDSPX  
## **Grupo:** Mont Clio  
## **Integrantes:**  
- **Leonardo Santos — RM557541**  
- **Pedro Henrique Lima — RM558243**  
- **Vitor Gomes — RM558244**

---

## 🎯 Desafio / Problema
Imagine o futuro do trabalho em um cenário onde tecnologia, bem-estar e relações humanas se conectam profundamente. O desafio é propor soluções inovadoras, inclusivas e sustentáveis que melhorem a vida das pessoas, apoiem organizações em novos modelos de trabalho e utilizem IA como parceira para criar ambientes mais humanos e saudáveis.

---

## 💡 Nossa Solução — *The Last Eyes*
The Last Eyes é uma solução inteligente que utiliza modelos de IA para monitorar padrões emocionais críticos entre colaboradores, identificando sinais de estresse, exaustão ou queda de bem-estar. O sistema recomenda ações assertivas e personalizadas, auxiliando na prevenção de problemas mais graves.

---

## 🗂️ Estrutura do Banco de Dados (Oracle)

### 📌 Principais Tabelas
- **tb_lst_emprego** — Registro de empregos, modelos de trabalho, tipo de contrato e satisfação.
- **tb_lst_empresa** — Informações das empresas vinculadas aos empregos.
- **tb_lst_estado_retorno** — Registros de retorno emocional / eficácia percebida.
- **tb_lst_humor** — Registros diários de humor e sentimentos.
- **tb_lst_perfil** — Perfis de usuários (ex: padrão, administrador).
- **tb_lst_recomendacao** — Recomendações geradas pela IA conforme humor.
- **tb_lst_usuario** — Usuários completos, com vínculos a humor, emprego, empresa e recomendações.

---

## 🔗 Relacionamentos
- Usuário → Perfil (**N:1**)  
- Usuário → Humor (**N:1**)  
- Usuário → Emprego (**N:1**)  
- Emprego → Empresa (**N:1**)  
- Usuário → Recomendação (**N:1**)  
- Usuário → Estado de Retorno (**N:1**)

Cada entidade é conectada para permitir análise profunda do bem-estar emocional com contexto profissional.

---

## 📦 Empacotamentos (Packages)
Os packages organizam regras, validações e operações de manipulação de dados.

### Objetivos
- Modularidade  
- Reutilização de código  
- Padronização (p_, v_, c_, cur_)  
- Uso facilitado em aplicações externas (Java, C#, Mobile)

### Execução
```sql
EXEC nome_do_package.nome_da_procedure(param1, param2);
```

---

## 📤 Exportação JSON (Para o MongoDB)
A pasta `results-json` contém um arquivo `.json` para cada tabela do Oracle.

---

## 🍃 Importação no MongoDB Compass
1. Abra o Compass  
2. Crie um database: **the-last-eyes**  
3. Para cada `.json`:  
   - Import Data  
   - Escolha JSON  
   - Coleção criada automaticamente  

---

# 🚀 Scripts de Automação MongoDB

## docker-compose.yml
```yaml
version: "3.8"
services:
  mongo:
    image: mongo:latest
    container_name: the_last_eyes_mongo
    restart: always
    ports:
      - "27017:27017"
    volumes:
      - ./results-json:/data/json
      - mongo_data:/data/db
    command: >
      bash -c "
        mkdir -p /docker-entrypoint-initdb.d &&         cp /data/json/*.json /docker-entrypoint-initdb.d/ &&         mongod --bind_ip_all
      "

volumes:
  mongo_data:
```

## mongoimport.sh
```bash
#!/bin/bash
DB_NAME="the-last-eyes"
JSON_DIR="./results-json"

for file in $JSON_DIR/*.json; do
  COLLECTION=$(basename "$file" .json)
  echo "Importando $COLLECTION..."
  mongoimport --db "$DB_NAME" --collection "$COLLECTION" --file "$file" --jsonArray
  echo "OK"
  echo "---------------------"
done

echo "Importação finalizada!"
```

---

## 🎥 Vídeo de Demonstração
*(https://www.youtube.com/watch?v=9DkOHJLRiJU)*
