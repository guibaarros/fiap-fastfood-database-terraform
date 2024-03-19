# fiap-fastfood-database-terraform
Repositório para o desenvolvimento e documentação da base de dados utilizada nos Tech Challenges da Postech FIAP em Arquitetura de Software referente à aplicação fiat-fastfood-application

## Tecnologias utilizadas
- Postgres
- Gradle
- Flyway
- Java 17
- Terraform

## Diagrama de Tabelas
O diagrama pode ser visualizado [aqui](https://dbdocs.io/guilhermehr00/fiap-fastfood-postech?schema=public&view=relationships).

### Especificação das tabelas

#### Cliente
**Nome:** tb_client
**Descrição:** Tabela onde é armazenado o cadastro de clientes identificados no momento da criação do pedido. Os dados são buscados no Cognito através do API Gateway utilizando o token informado na requisição, caso o seja feito.
**Campos**

| Campo | Descrição |
|---|---|
| client_id | Chave primária da tabela, incrementada de forma automática |
| cpf | CPF do cliente |
| email | E-mail do cliente |
| name | Nome do cliente |
| last_visit | Data do último pedido feito pelo cliente |
| created_at | Data de criação do registro na base |

#### Produto
**Nome:** tb_product
**Descrição:** Tabela onde é armazenado o cadastro de Produtos. Faz relação 1:N com a tabela de imagem dos produtos e N:N com a tabela de Pedidos.
**Campos**

| Campo | Descrição |
|---|---|
| product_id | Chave primária da tabela, incrementada de forma automática |
| category | Categoria do produto, indica se o produto é um lanche, bebida, acompanhamento ou sobremesa |
| description | Descrição do produto detalhada |
| name | Nome do produto |
| price | Valor de venda do produto |
| created_at | Data de criação do registro na base |

**Nome:** tb_product_image
**Descrição:** Tabela onde são armazenadas as imagens do Produto quando são enviadas no momento do cadastro ou da atualização do produto.
**Campos**

| Campo | Descrição |
|---|---|
| product_image_id | Chave primária da tabela, incrementada de forma automática |
| content_type | Content Type do arquivo da imagem |
| image | Binário da imagem |
| name | Nome do arquivo da imagem |
| size | Tamanho do arquivo da imagem |
| product_id | Chave estrangeira relacionando o registro à tabela tb_product |

#### Pedido
**Nome:** tb_order
**Descrição:** Tabela onde são armazenados os pedidos feitos pelo cliente. Tem relação 1:N com a tabela de clientes para o caso do cliente ter se identificado e com N:N com a tabela de Produtos.
**Campos**

| Campo | Descrição |
|---|---|
| order_id | Chave primária da tabela, incrementada de forma automática |
| created_at | Data de criação do registro do pedido |
| finished_at | Data de finalização do pedido |
| number | Número do pedido exibido no painel |
| payment_status | Status do pagamento, indicando se está pendente, se foi aprovado ou cancelado |
| status | Status do pedido, utilizado no fluxo de produção, indica se o pedido está aguardando preparo, em preparo, aguardando retirada, retirado e finalizado |
| total_amount | Valor total do pedido, soma dos valores dos produtos do pedido no momento da criação |
| updated_at | Data da atualização do registro do pedido |
| payment_status_updated_at | Data da atualizção do statuso do pagamento |
| payment_qa_code_data | Dados do texto para montagem do QR Code de pagamento (Integração FAKE) |
| external_id | ID de identificação do sistema externo de pagamento (Integração FAKE) |
| client_id | Chave estrangeira relacionando o registro à tabela tb_client, quando cliente se identifica no momento da criação do pedido |

**Nome:** tb_order_products
**Descrição:** Tabela de relacionamento N:N entre Pedidos e Produtos, para identificar quais são os produtos de cada pedido.
**Campos**

| Campo | Descrição |
|---|---|
| order_id | Chave estrangeira relacionando o registro à tabela tb_order |
| product_id | Chave estrangeira relacionando o registro à tabela tb_product |

### Especificação do banco relacional
O banco relacional foi escolhido por conta das suas funcionalidades relacionadas à estruturação dos registros, possibilidade de relacionamento entre tabelas e integridade dos dados.
A integridade é importante devido à necessidade do acompanhamento do status do pedido durante a produção tal como também dos dados do pedido no momento do pagamento. Não podemos correr o risco de haver problemas de replicação ou alta latência entre os nós dos bancos não relacionais que poderiam causar a discrepância dos dados entre um nó e outro, sendo assim necessária a garantia da integridade.
Além disso, também precisamos manter o relacionamento entre clientes, pedidos e produtos, por conta da necessidade de eventualmente a identificação dos clientes podendo ser utilizada para criação de campanhas publicitárias direcionadas à diferentes públicos, ou promoções específicas para um ou mais clientes. Além disso, com esse relacionamento, também é possível projetar a criação de relatórios analíticos, como por exemplo: produtos mais vendidos, produtos mais lucrativos, produtos preferidos de cada cliente, frequência de visita de cada cliente, média de gastos de cada cliente, horário de maior público e média de gasto por horário durante o dia.
