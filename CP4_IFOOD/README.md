# CP4 — Case iFood  
### Cognitive Data Science + Machine Learning & Modelling

## 1. Objetivo

Este projeto tem como objetivo estruturar o dataset Case iFood no Oracle, validar a carga e a consistência dos dados, demonstrar comandos DDL e DML e desenvolver uma etapa de Machine Learning. A Parte 2 contempla análise exploratória, Feature Engineering, treinamento e otimização de uma Decision Tree, comparação entre os modelos baseline e otimizado e medidas para evitar data leakage.

## 2. Estrutura do projeto

```text
CP4_IFOOD/
├── data/
│   └── data.csv
├── sql/
│   ├── 01_create_table.sql
│   ├── 02_load_data.sql
│   ├── 03_ddl_dml.sql
│   └── 04_validation_and_ml_query.sql
├── notebook/
│   └── CP4_iFood_ML.ipynb
└── README.md
```

- `data/data.csv`: dataset original utilizado nas duas partes do projeto.
- `sql/01_create_table.sql`: criação e definição estrutural da tabela Oracle.
- `sql/02_load_data.sql`: conferências da carga e correção de consistência documentada.
- `sql/03_ddl_dml.sql`: demonstração de operações DDL e DML.
- `sql/04_validation_and_ml_query.sql`: validações finais e consulta de referência para Machine Learning.
- `notebook/CP4_iFood_ML.ipynb`: EDA, Feature Engineering, preparação dos dados e modelagem.
- `README.md`: documentação acadêmica e instruções de reprodução do projeto.

## 3. Dataset

- Dataset: Case iFood
- Registros: 2.240
- Colunas originais: 29
- Target: `Response`
- `Response = 0`: 1.906 registros
- `Response = 1`: 334 registros
- `Income`: 24 valores nulos

## 4. Parte 1 — Oracle / Cognitive Data Science

A Parte 1 organiza o dataset dentro do Oracle, valida sua consistência e demonstra operações DDL e DML.

### 4.1 Criação da tabela

Arquivo: `sql/01_create_table.sql`

O script define a tabela `IFOOD_CUSTOMERS`, seus tipos de dados, chave primária e constraints de domínio e consistência. O conteúdo integral do script permanece no arquivo SQL.

### 4.2 Carga dos dados

Arquivo: `sql/02_load_data.sql`

Os dados de `data/data.csv` são importados manualmente para a tabela Oracle por meio do SQL Developer. O arquivo `sql/02_load_data.sql` **não realiza a importação do CSV**: ele deve ser executado após a importação manual para validar a quantidade de registros, conferir amostras, corrigir o caso específico do ID 1295, confirmar os 24 valores nulos de `Income` e efetuar o `COMMIT`.

Configurações da importação:

| Configuração | Valor |
|---|---|
| Arquivo | `data/data.csv` |
| Delimitador | `,` |
| Cabeçalho | Sim |
| Quantidade de colunas | 29 |
| Campos vazios | `NULL` |
| Formato de `Dt_Customer` | `YYYY-MM-DD` |

Todas as 29 colunas do CSV devem ser mapeadas para as colunas correspondentes de `IFOOD_CUSTOMERS`. O script posterior à importação documenta a correção do registro de ID 1295, cujo campo `Income` deveria estar nulo de acordo com o CSV original.

#### Procedimento de carga no SQL Developer

1. Executar `sql/01_create_table.sql`.
2. Selecionar a tabela `IFOOD_CUSTOMERS`.
3. Utilizar a opção de importação de dados do SQL Developer.
4. Selecionar `data/data.csv`, com delimitador vírgula e a primeira linha como cabeçalho.
5. Conferir o mapeamento das 29 colunas para `IFOOD_CUSTOMERS` e configurar campos vazios como `NULL`.
6. Garantir que `Dt_Customer` seja importada como data no formato `YYYY-MM-DD`.
7. Concluir a importação.
8. Executar `sql/02_load_data.sql` para validação e correção.
9. Executar `COMMIT` quando necessário.

Após a importação, o total esperado antes das demonstrações DML é de 2.240 registros.

### 4.3 DDL e DML

Arquivo: `sql/03_ddl_dml.sql`

O script demonstra uma operação DDL com `ALTER TABLE` e operações DML com `INSERT`, `UPDATE` e `DELETE`. O registro criado para a demonstração é temporário e removido ao final, preservando os 2.240 registros originais.

### 4.4 Validação

Arquivo: `sql/04_validation_and_ml_query.sql`

Resultados esperados das validações:

| Validação | Resultado |
|---|---:|
| Total de registros | 2.240 |
| Valores nulos em `Income` | 24 |
| IDs duplicados | 0 |
| Registros com gastos negativos | 0 |
| `Response = 0` | 1.906 |
| `Response = 1` | 334 |

O arquivo também contém a consulta utilizada como referência para a seleção das colunas do dataset.

## 5. Parte 2 — Machine Learning & Modelling

Arquivo principal: `notebook/CP4_iFood_ML.ipynb`

O notebook reúne:

- carregamento dos dados;
- validação inicial;
- tratamento das datas;
- Feature Engineering;
- análise exploratória de dados;
- HoldOut estratificado;
- pipeline de pré-processamento;
- Decision Tree baseline;
- tuning com `GridSearchCV`;
- avaliação e comparação final.

## 6. Feature Engineering

As novas features foram criadas sem utilizar `Response` em suas definições:

| Feature | Finalidade |
|---|---|
| `Age` | Representar a idade aproximada do cliente a partir do ano de nascimento. |
| `Customer_Tenure_Days` | Representar o tempo de relacionamento do cliente com a empresa. |
| `Total_Children` | Agregar as quantidades de crianças e adolescentes no domicílio. |
| `Total_Spent` | Somar os gastos registrados nas diferentes categorias de produtos. |
| `Total_Purchases` | Agregar as compras realizadas pela web, catálogo e loja física. |
| `Accepted_Campaigns` | Representar a quantidade de campanhas anteriores aceitas. |
| `Average_Ticket` | Estimar o gasto médio por compra a partir de gasto e compras totais. |

## 7. Análise exploratória

Os principais achados confirmados no notebook foram:

- clientes com `Response = 1` apresentam rendas geralmente maiores;
- clientes com resposta positiva apresentam menor `Recency`;
- `Total_Spent` tende a ser maior na classe positiva;
- uma quantidade maior de campanhas anteriores aceitas está associada a maior ocorrência de `Response = 1`;
- clientes da classe positiva tendem a apresentar mais compras;
- `Accepted_Campaigns` apresentou a maior correlação numérica com `Response`, aproximadamente 0,426;
- foram identificados valores extremos em `Income`, `Age` e `Average_Ticket`;
- `Z_CostContact` e `Z_Revenue` são constantes.

Os valores extremos foram documentados, mas não removidos automaticamente.

## 8. Preparação dos dados

- Variável alvo: `Response`.
- Colunas removidas de `X`: `ID`, `Z_CostContact` e `Z_Revenue`.
- HoldOut: 80% para treino e 20% para teste.
- Estratificação: `stratify=y`.
- Reprodutibilidade: `random_state=42`.
- Treino: 1.792 registros.
- Teste: 448 registros.

`Dt_Customer` é utilizada para criar `Customer_Tenure_Days`, mas não é utilizada diretamente pela Decision Tree.

## 9. Pipeline

O pré-processamento é realizado com `Pipeline` e `ColumnTransformer`:

- variáveis numéricas: `SimpleImputer(strategy="median")`;
- variáveis categóricas: `SimpleImputer(strategy="most_frequent")` e `OneHotEncoder(handle_unknown="ignore")`.

Ao manter imputação e codificação dentro do pipeline, os parâmetros de pré-processamento são aprendidos nos dados de treino, reduzindo o risco de data leakage.

## 10. Decision Tree baseline

O modelo de referência interna anterior ao tuning foi:

```python
DecisionTreeClassifier(random_state=42)
```

| Modelo | Precision | Recall | F1-score | ROC AUC |
|---|---:|---:|---:|---:|
| Decision Tree Baseline | 0.515625 | 0.492537 | 0.503817 | 0.711776 |

## 11. Tuning

O tuning foi realizado com `GridSearchCV` e `StratifiedKFold` de 5 folds, usando `shuffle=True`, `random_state=42` e ROC AUC como métrica de seleção. A busca recebeu somente `X_train` e `y_train`.

Melhores parâmetros:

- `criterion = "entropy"`
- `max_depth = 4`
- `min_samples_leaf = 10`
- `min_samples_split = 2`
- `class_weight = None`

Melhor ROC AUC médio da validação cruzada: `0.815194`.

## 12. Resultado final

| Modelo | Precision | Recall | F1-score | ROC AUC |
|---|---:|---:|---:|---:|
| Decision Tree Baseline | 0.515625 | 0.492537 | 0.503817 | 0.711776 |
| Decision Tree Otimizada | 0.470588 | 0.238806 | 0.316832 | 0.783543 |

Melhoria absoluta do ROC AUC: `+0.071767`.

O ROC AUC aumentou, mas Precision, Recall e F1-score não melhoraram. Recall e F1-score diminuíram. A árvore otimizada apresentou melhor capacidade global de discriminação; entretanto, no limiar padrão de 0,5, tornou-se mais conservadora na identificação da classe positiva.

Matriz de confusão final:

| | Predito 0 | Predito 1 |
|---|---:|---:|
| Real 0 | 363 | 18 |
| Real 1 | 51 | 16 |

## 13. Data leakage

O projeto adotou as seguintes medidas para evitar vazamento de dados:

- o HoldOut foi realizado antes do ajuste do pré-processamento;
- imputadores e encoder estão dentro do pipeline;
- o `GridSearchCV` recebeu apenas os dados de treino;
- nenhuma feature utiliza `Response`;
- o conjunto de teste não foi utilizado para selecionar hiperparâmetros.

O conjunto de teste foi utilizado para avaliar o baseline e, posteriormente, o modelo otimizado. Entretanto, seus resultados não foram utilizados para selecionar hiperparâmetros.

## 14. Como reproduzir

### Oracle

1. Executar `sql/01_create_table.sql`.
2. Importar manualmente `data/data.csv` pelo SQL Developer, usando as configurações documentadas na seção 4.2.
3. Executar `sql/02_load_data.sql`.
4. Executar `sql/03_ddl_dml.sql`.
5. Executar `sql/04_validation_and_ml_query.sql`.

### Machine Learning

1. Instalar as dependências necessárias.
2. Abrir `notebook/CP4_iFood_ML.ipynb`.
3. Selecionar um ambiente Python compatível.
4. Executar as células em ordem.
5. Verificar os outputs e as métricas finais.

## 15. Tecnologias

- Oracle Database
- Oracle SQL Developer
- SQL
- Python
- pandas
- NumPy
- Matplotlib
- Seaborn
- scikit-learn
- Jupyter Notebook

## 16. Integrantes

- Nome — RM
- Nome — RM
- Nome — RM

<!-- Substituir pelos integrantes reais do grupo antes da entrega. -->

## 17. Observações finais

- O notebook deve ser entregue com os outputs salvos.
- Os scripts SQL permitem reproduzir a estrutura e as validações no Oracle.
- Os resultados podem variar caso o dataset, a divisão ou o `random_state` sejam alterados.
