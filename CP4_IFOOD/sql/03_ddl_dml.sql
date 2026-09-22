-- =========================================================
-- CP4 - CASE IFOOD
-- DEMONSTRACAO DE DDL E DML
-- =========================================================


-- ---------------------------------------------------------
-- DDL - ALTER TABLE
-- Aumenta o tamanho da coluna EDUCATION
-- de VARCHAR2(20) para VARCHAR2(30)
-- ---------------------------------------------------------

ALTER TABLE IFOOD_CUSTOMERS
MODIFY EDUCATION VARCHAR2(30);


-- Conferencia da alteracao
DESC IFOOD_CUSTOMERS;


-- ---------------------------------------------------------
-- DML - INSERT
-- Registro ficticio criado apenas para demonstracao
-- ---------------------------------------------------------

-- Verificacao defensiva do ID temporario.
-- O resultado esperado e nenhuma linha, confirmando
-- que o ID esta livre para a demonstracao.
SELECT ID
FROM IFOOD_CUSTOMERS
WHERE ID = 999999;

INSERT INTO IFOOD_CUSTOMERS (
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
)
VALUES (
    999999,
    1995,
    'Graduation',
    'Single',
    50000,
    0,
    0,
    TO_DATE('21/09/2026','DD/MM/YYYY'),
    20,
    100,
    20,
    150,
    30,
    10,
    40,
    1,
    3,
    2,
    4,
    5,
    0,
    0,
    0,
    0,
    0,
    0,
    3,
    11,
    0
);


-- Prova do INSERT
SELECT *
FROM IFOOD_CUSTOMERS
WHERE ID = 999999;


-- ---------------------------------------------------------
-- DML - UPDATE
-- Alteracao da renda do registro ficticio
-- ---------------------------------------------------------

UPDATE IFOOD_CUSTOMERS
SET INCOME = 52000
WHERE ID = 999999;


-- Prova do UPDATE
SELECT ID, INCOME
FROM IFOOD_CUSTOMERS
WHERE ID = 999999;


-- ---------------------------------------------------------
-- DML - DELETE
-- Exclusao do registro ficticio
-- ---------------------------------------------------------

DELETE FROM IFOOD_CUSTOMERS
WHERE ID = 999999;


-- Prova do DELETE
-- O resultado esperado e nenhuma linha.
SELECT *
FROM IFOOD_CUSTOMERS
WHERE ID = 999999;


COMMIT;


-- Confirmacao de que o dataset permaneceu
-- com os 2240 registros originais
SELECT COUNT(*) AS TOTAL_REGISTROS
FROM IFOOD_CUSTOMERS;
