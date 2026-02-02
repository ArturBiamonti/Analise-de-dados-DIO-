create database mecanica;

use mecanica;

-- Tabela Cliente com identificação única
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    documento VARCHAR(14) UNIQUE NOT NULL,
    endereco VARCHAR(150),
    telefone VARCHAR(11)
);

CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa CHAR(7) UNIQUE NOT NULL, 
    modelo VARCHAR(50),
    marca VARCHAR(30), 
    ano INT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Equipe (
    id_equipe INT AUTO_INCREMENT PRIMARY KEY,
    nome_equipe VARCHAR(50) NOT NULL
);

CREATE TABLE Mecanico (
    codigo_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50),
    id_equipe INT,
    FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
);

-- Tabela de Referência de Serviços (Tabela de Preços)
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    valor_referencia DECIMAL(10,2) NOT NULL
);

-- Tabela de Referência de Peças (Catálogo)
CREATE TABLE Peca (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    valor_venda DECIMAL(10,2) NOT NULL
);

CREATE TABLE Ordem_Servico (
    numero_os INT AUTO_INCREMENT PRIMARY KEY,
    data_emissao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_conclusao DATETIME,
    data_entrega DATETIME,
    valor_total_os DECIMAL(10,2) DEFAULT 0,
    status ENUM('ABERTA', 'EM_ANALISE', 'AGUARDANDO_AUTORIZACAO', 'EM_EXECUCAO', 'CONCLUIDA', 'CANCELADA') DEFAULT 'ABERTA',
    id_veiculo INT NOT NULL,
    id_equipe INT NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
);

-- Relacionamento N:M para Serviços na OS
CREATE TABLE OS_Servico (
    numero_os INT,
    id_servico INT,
    quantidade INT DEFAULT 1,
    valor_unitario_aplicado DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (numero_os, id_servico),
    FOREIGN KEY (numero_os) REFERENCES Ordem_Servico(numero_os),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

-- Relacionamento N:M para Peças na OS
CREATE TABLE OS_Peca (
    numero_os INT,
    id_peca INT,
    quantidade INT NOT NULL,
    valor_unitario_aplicado DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (numero_os, id_peca),
    FOREIGN KEY (numero_os) REFERENCES Ordem_Servico(numero_os),
    FOREIGN KEY (id_peca) REFERENCES Peca(id_peca)
);