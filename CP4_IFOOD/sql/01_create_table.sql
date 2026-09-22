-- =========================================================
-- CP4 - CASE IFOOD
-- PARTE 1 - COGNITIVE DATA SCIENCE
-- CRIACAO DA TABELA IFOOD_CUSTOMERS
-- =========================================================

CREATE TABLE IFOOD_CUSTOMERS (
    ID                  NUMBER(10)      NOT NULL,
    YEAR_BIRTH          NUMBER(4)       NOT NULL,
    EDUCATION           VARCHAR2(20)    NOT NULL,
    MARITAL_STATUS      VARCHAR2(30)    NOT NULL,
    INCOME              NUMBER(10,2),
    KIDHOME             NUMBER(1)       NOT NULL,
    TEENHOME            NUMBER(1)       NOT NULL,
    DT_CUSTOMER         DATE            NOT NULL,
    RECENCY             NUMBER(3)       NOT NULL,

    MNTWINES            NUMBER(10)      NOT NULL,
    MNTFRUITS           NUMBER(10)      NOT NULL,
    MNTMEATPRODUCTS     NUMBER(10)      NOT NULL,
    MNTFISHPRODUCTS     NUMBER(10)      NOT NULL,
    MNTSWEETPRODUCTS    NUMBER(10)      NOT NULL,
    MNTGOLDPRODS        NUMBER(10)      NOT NULL,

    NUMDEALSPURCHASES   NUMBER(3)       NOT NULL,
    NUMWEBPURCHASES     NUMBER(3)       NOT NULL,
    NUMCATALOGPURCHASES NUMBER(3)       NOT NULL,
    NUMSTOREPURCHASES   NUMBER(3)       NOT NULL,
    NUMWEBVISITSMONTH   NUMBER(3)       NOT NULL,

    ACCEPTEDCMP3        NUMBER(1)       NOT NULL,
    ACCEPTEDCMP4        NUMBER(1)       NOT NULL,
    ACCEPTEDCMP5        NUMBER(1)       NOT NULL,
    ACCEPTEDCMP1        NUMBER(1)       NOT NULL,
    ACCEPTEDCMP2        NUMBER(1)       NOT NULL,

    COMPLAIN            NUMBER(1)       NOT NULL,
    Z_COSTCONTACT       NUMBER(3)       NOT NULL,
    Z_REVENUE           NUMBER(3)       NOT NULL,
    RESPONSE            NUMBER(1)       NOT NULL,

    CONSTRAINT IFOOD_CUSTOMERS_PK
        PRIMARY KEY (ID),

    CONSTRAINT IFOOD_EDUCATION_CK
        CHECK (
            EDUCATION IN (
                'Graduation',
                'PhD',
                'Master',
                'Basic',
                '2n Cycle'
            )
        ),

    CONSTRAINT IFOOD_MARITAL_STATUS_CK
        CHECK (
            MARITAL_STATUS IN (
                'Married',
                'Together',
                'Single',
                'Divorced',
                'Widow',
                'Alone',
                'Absurd',
                'YOLO'
            )
        ),

    CONSTRAINT IFOOD_INCOME_CK
        CHECK (INCOME IS NULL OR INCOME >= 0),

    CONSTRAINT IFOOD_KIDHOME_CK
        CHECK (KIDHOME BETWEEN 0 AND 5),

    CONSTRAINT IFOOD_TEENHOME_CK
        CHECK (TEENHOME BETWEEN 0 AND 5),

    CONSTRAINT IFOOD_RECENCY_CK
        CHECK (RECENCY BETWEEN 0 AND 999),

    CONSTRAINT IFOOD_MNT_NONNEG_CK
        CHECK (
            MNTWINES >= 0
            AND MNTFRUITS >= 0
            AND MNTMEATPRODUCTS >= 0
            AND MNTFISHPRODUCTS >= 0
            AND MNTSWEETPRODUCTS >= 0
            AND MNTGOLDPRODS >= 0
        ),

    CONSTRAINT IFOOD_NUM_NONNEG_CK
        CHECK (
            NUMDEALSPURCHASES >= 0
            AND NUMWEBPURCHASES >= 0
            AND NUMCATALOGPURCHASES >= 0
            AND NUMSTOREPURCHASES >= 0
            AND NUMWEBVISITSMONTH >= 0
        ),

    CONSTRAINT IFOOD_CAMPANHAS_CK
        CHECK (
            ACCEPTEDCMP1 IN (0,1)
            AND ACCEPTEDCMP2 IN (0,1)
            AND ACCEPTEDCMP3 IN (0,1)
            AND ACCEPTEDCMP4 IN (0,1)
            AND ACCEPTEDCMP5 IN (0,1)
            AND COMPLAIN IN (0,1)
            AND RESPONSE IN (0,1)
        )
);
