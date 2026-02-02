-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- criando as tabelas

-- tabela cliente (Pai)

create table Cliente(
	idCliente int auto_increment primary key,
    Primeiro_nome varchar(20) NOT NULL,
    Inicial_nome_do_meio char(3),
    Sobrenome varchar(35) NOT NULL,
    endereco varchar(255),
    tipo_cliente ENUM( 'PF' , 'PJ' ) NOT NULL,
    check (tipo_cliente IN ( 'PF' , 'PJ' ))
);

-- tabela cliente PF (Filha)

create table Pf(
idCliente int primary key,
CPF char(11) NOT NULL UNIQUE,

constraint fk_pf_cliente
	foreign key (idCliente)
	references Cliente(idCliente)
    ON delete cascade
);

-- tabela cliente PJ (Filha)

create table Pj(
idCliente int primary key,
CNPJ char(14) NOT NULL UNIQUE,
razao_social varchar(100) NOT NULL,

constraint fk_pj_cliente
	foreign key (idCliente)
	references Cliente(idCliente)
    ON delete cascade
);

-- tabela Entrega

create table Entrega(
idEntrega int auto_increment primary key,
status_entrega ENUM('PENDENTE', 'EM_TRANSITO', 'ENTREGUE'),
codigo_rastreio varchar(50),
data_envio datetime
);

-- tabela Pedido

create table Pedido(
idPedido int auto_increment primary key,
status_pedido ENUM('CRIADO', 'PAGO', 'ENVIADO', 'CANCELADO'),
descricao varchar(255),
data_pedido datetime NOT NULL,

idCliente int NOT NULL,
idEntrega INT,

constraint fk_pedido_cliente
	foreign key (idCliente)
    references Cliente(idCliente),
    
constraint fk_pedido_entrega
	foreign key (idEntrega)
    references Entrega(idEntrega)
);

-- tabela Produto

create table Produto(
idProduto int auto_increment primary key,
nome_produto varchar(20),
categoria ENUM('Alimento', 'Eletrônico', 'Vestimenta', 'Brinquedo'),
valor decimal(10,2)

);
