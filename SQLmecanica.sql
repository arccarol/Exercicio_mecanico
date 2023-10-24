USE master 
DROP DATABASE mecanica

CREATE DATABASE mecanica 
GO
USE mecanica

CREATE TABLE cliente(
id_cli INT NOT NULL IDENTITY(3401,15),
nome VARCHAR(100) NOT NULL,
logradouro VARCHAR(200) NOT NULL, 
numero INT NOT NULL CHECK (numero> 0),
cep CHAR(08) NOT NULL CHECK (cep = 08),
complemento VARCHAR(255) NOT NULL
PRIMARY KEY (id_cli)
)
GO 
CREATE TABLE veiculo(
placa CHAR(07) NOT NULL CHECK (LEN(placa) = 7),
marca VARCHAR(30) NOT NULL,
modelo VARCHAR(30) NOT NULL CHECK (modelo> 1997),
cor VARCHAR(15) NOT NULL,
ano_fabri INT NOT NULL CHECK (ano_fabri > 1997),
ano_modelo INT NOT NULL,
data_aquisicao DATE NOT NULL,
id_cli INT NOT NULL IDENTITY(3401,15)
PRIMARY KEY (placa)
FOREIGN KEY(id_cli) REFERENCES cliente(id_cli),
CONSTRAINT mod_fabri CHECK(ano_modelo = ano_fabri OR ano_modelo = ano_fabri + 1)
)
GO 
CREATE TABLE peça (
id INT NOT NULL IDENTITY(3411,7),
nome VARCHAR(20) NOT NULL  UNIQUE,
preco DECIMAL(4,2) NOT NULL  CHECK (preco> 0),
estoque INT NOT NULL CHECK (estoque >= 10)
PRIMARY KEY (id)
)
GO
CREATE TABLE categoria (
id_cat INT NOT NULL IDENTITY(1,1),
categoria VARCHAR(10) NOT NULL,
valor_hora DECIMAL(4,2) NOT NULL  CHECK (valor_hora > 0),
PRIMARY KEY (id_cat),
CONSTRAINT cat_func CHECK((UPPER(categoria) = 'ESTAGIO' AND valor_hora = 15)
							OR (UPPER(categoria) = 'NIVEL 1' AND  valor_hora = 25)
							OR (UPPER(categoria) = 'NIVEL 2' AND valor_hora = 35)
							OR (UPPER(categoria) = 'NIVEL 3' AND valor_hora = 50))
)
GO
CREATE TABLE funcionario (
id INT NOT NULL IDENTITY(101,1),
nome VARCHAR(100) NOT NULL,
logradouro VARCHAR(200) NOT NULL,
numero INT NOT NULL CHECK (numero> 0),
telefone CHAR(11) NOT NULL CHECK (LEN(telefone) = 10 OR LEN(telefone) = 11),
categoria_habilitacao VARCHAR(02) NOT NULL CHECK (categoria_habilitacao IN ('A', 'B', 'C', 'D', 'E')),
id_cat INT NOT NULL
PRIMARY KEY(id)
FOREIGN KEY(id_cat) REFERENCES categoria(id_cat)
)
GO
CREATE TABLE telefone_cliente(
telefone VARCHAR(11) NOT NULL CHECK (LEN(telefone) = 10 OR LEN(telefone) = 11),
id_cli INT NOT NULL
PRIMARY KEY (telefone)
FOREIGN KEY(id_cli) REFERENCES cliente(id_cli)
)
GO 
CREATE TABLE reparo(
data_reparo DATE NOT NULL DEFAULT GETDATE(),
custo_total DECIMAL(4,2) NOT NULL  CHECK (custo_total> 0),
tempo INT NOT NULL  CHECK (tempo > 0),
placa CHAR(07) NOT NULL,
id INT NOT NULL,
id_cli INT NOT NULL
PRIMARY KEY(data_reparo)
FOREIGN KEY(id_cli) REFERENCES cliente(id_cli),
FOREIGN KEY(id) REFERENCES funcionario(id),
FOREIGN KEY(placa) REFERENCES veiculo(placa)
)






