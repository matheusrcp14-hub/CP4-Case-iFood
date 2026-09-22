-- =========================================================
-- CP4 - CASE IFOOD
-- CARGA E CONFERENCIA INICIAL DOS DADOS
-- =========================================================
--
-- Este script NAO importa o CSV.
-- A importacao deve ser realizada previamente, de forma manual,
-- pelo Oracle SQL Developer.
--
-- Configuracoes utilizadas na importacao:
-- arquivo: data/data.csv
-- delimitador: virgula
-- primeira linha: cabecalho presente
-- campos vazios: tratar como NULL
-- DT_CUSTOMER: formato YYYY-MM-DD
--
-- Quantidade esperada de registros: 2240.
--
-- Durante a validacao foi identificada uma divergencia:
-- o registro ID = 1295 estava com INCOME = 50000 no Oracle,
-- enquanto no CSV original o campo INCOME estava vazio.
-- O valor foi corrigido para NULL para manter fidelidade
-- ao dataset original.
-- =========================================================


-- Conferencia da quantidade total de registros
SELECT COUNT(*) AS TOTAL_REGISTROS
FROM IFOOD_CUSTOMERS;


-- Visualizacao de uma amostra da carga
SELECT *
FROM IFOOD_CUSTOMERS
FETCH FIRST 5 ROWS ONLY;


-- Conferencia da estrutura da tabela
DESC IFOOD_CUSTOMERS;


-- Correcao de consistencia identificada na validacao
UPDATE IFOOD_CUSTOMERS
SET INCOME = NULL
WHERE ID = 1295;


COMMIT;


-- Conferencia da correcao
SELECT ID, INCOME
FROM IFOOD_CUSTOMERS
WHERE ID = 1295;


-- Quantidade esperada de valores nulos em INCOME: 24
SELECT COUNT(*) AS INCOME_NULO
FROM IFOOD_CUSTOMERS
WHERE INCOME IS NULL;
