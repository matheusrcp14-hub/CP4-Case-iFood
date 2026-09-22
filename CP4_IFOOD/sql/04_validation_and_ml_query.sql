-- =========================================================
-- CP4 - CASE IFOOD
-- VALIDACAO DA ESTRUTURA E DA CARGA
-- =========================================================


-- Quantidade total de registros
SELECT COUNT(*) AS TOTAL_REGISTROS
FROM IFOOD_CUSTOMERS;


-- Verificacao de IDs duplicados
SELECT ID, COUNT(*) AS QTD
FROM IFOOD_CUSTOMERS
GROUP BY ID
HAVING COUNT(*) > 1;


-- Quantidade explicita de IDs duplicados
-- Resultado esperado: IDS_DUPLICADOS = 0
SELECT COUNT(*) AS IDS_DUPLICADOS
FROM (
    SELECT ID
    FROM IFOOD_CUSTOMERS
    GROUP BY ID
    HAVING COUNT(*) > 1
);


-- Quantidade de valores nulos em INCOME
SELECT COUNT(*) AS INCOME_NULO
FROM IFOOD_CUSTOMERS
WHERE INCOME IS NULL;


-- Distribuicao da variavel alvo RESPONSE
SELECT RESPONSE, COUNT(*) AS QUANTIDADE
FROM IFOOD_CUSTOMERS
GROUP BY RESPONSE
ORDER BY RESPONSE;


-- Verificacao de valores negativos nas variaveis de gasto
SELECT COUNT(*) AS REGISTROS_COM_GASTO_NEGATIVO
FROM IFOOD_CUSTOMERS
WHERE MNTWINES < 0
   OR MNTFRUITS < 0
   OR MNTMEATPRODUCTS < 0
   OR MNTFISHPRODUCTS < 0
   OR MNTSWEETPRODUCTS < 0
   OR MNTGOLDPRODS < 0;


-- =========================================================
-- RESULTADOS OBTIDOS NA VALIDACAO
-- =========================================================
-- TOTAL_REGISTROS = 2240
-- INCOME_NULO = 24
-- IDS_DUPLICADOS = 0
-- GASTOS_NEGATIVOS = 0
-- RESPONSE = 0 -> 1906
-- RESPONSE = 1 -> 334


-- =========================================================
-- QUERY BASE PARA GERACAO DO DATAFRAME DE MACHINE LEARNING
-- =========================================================

SELECT
    ID,
    YEAR_BIRTH,
    EDUCATION,
    MARITAL_STATUS,
    INCOME,
    KIDHOME,
    TEENHOME,
    DT_CUSTOMER,
    RECENCY,
    MNTWINES,
    MNTFRUITS,
    MNTMEATPRODUCTS,
    MNTFISHPRODUCTS,
    MNTSWEETPRODUCTS,
    MNTGOLDPRODS,
    NUMDEALSPURCHASES,
    NUMWEBPURCHASES,
    NUMCATALOGPURCHASES,
    NUMSTOREPURCHASES,
    NUMWEBVISITSMONTH,
    ACCEPTEDCMP3,
    ACCEPTEDCMP4,
    ACCEPTEDCMP5,
    ACCEPTEDCMP1,
    ACCEPTEDCMP2,
    COMPLAIN,
    Z_COSTCONTACT,
    Z_REVENUE,
    RESPONSE
FROM IFOOD_CUSTOMERS;
