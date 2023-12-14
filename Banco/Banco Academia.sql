﻿USE MASTER
GO
ALTER DATABASE GestaoDeAcademia SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
DROP DATABASE GestaoDeAcademia
GO
CREATE DATABASE GestaoDeAcademia
GO

USE GestaoDeAcademia
GO

IF OBJECT_ID('Usuario', 'U') IS NULL
CREATE TABLE Usuario
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nome VARCHAR(100),
	NomeUsuario VARCHAR(50),
	Email VARCHAR(60),
	CPF VARCHAR(15),
	Ativo BIT,
	Senha VARCHAR(50)
)
GO

IF OBJECT_ID('GrupoUsuario', 'U') IS NULL
CREATE TABLE GrupoUsuario
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	NomeGrupo VARCHAR(150)
)
GO

IF OBJECT_ID('Permissao', 'U') IS NULL
CREATE TABLE Permissao
(
	Id INT PRIMARY KEY,
	Descricao VARCHAR(250)
)
GO

IF OBJECT_ID('UsuarioGrupoUsuario', 'U') IS NULL
CREATE TABLE UsuarioGrupoUsuario
(
	IdUsuario INT,
	IdGrupoUsuario INT,
	CONSTRAINT PK_UsuarioGrupoUsuario PRIMARY KEY (IdUsuario, IdGrupoUsuario)
)
GO

IF OBJECT_ID('PermissaoGrupoUsuario', 'U') IS NULL
CREATE TABLE PermissaoGrupoUsuario
(
	IdPermissao INT,
	IdGrupoUsuario INT,
	CONSTRAINT PK_PermissaoGrupoUsuario PRIMARY KEY (IdPermissao, IdGrupoUsuario)
)
GO
CREATE TABLE Cliente
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nome VARCHAR(100),
	Aluno BIT,
	CPF CHAR(14),
	Telefone CHAR(14),
	Email VARCHAR(60),
	Endereco VARCHAR(100),
	DataCadastro DATETIME
)
GO
CREATE TABLE Fornecedor
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nome VARCHAR(100),
	CpfCnpj VARCHAR(15),
	Email VARCHAR(200),
	Telefone CHAR(14),
	Endereco VARCHAR(100),
	Descricao VARCHAR(150)
)
GO
CREATE TABLE CompraProduto
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FornecedorId INT,
	FormaPagamentoId INT,
	ValorTotal FLOAT,
	FreteTotal Float 
)
GO
CREATE TABLE ItensCompra
(
	Id Int Primary key identity(1,1),
	CompraProdutoId INT,
	ProdutoId int,
	Marca VARCHAR(100),
	Quantidade INT,
	ValorFrete Float,
	ValorUnitario FLOAT,
	ValorTotal FLOAT
)
GO
CREATE TABLE Produto
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nome Varchar(150),
	Marca VARCHAR(100),
	Preco FLOAT,
	QuantidadeEstoque int,
	CodigoDeBarras VARCHAR(20)
)
GO
CREATE TABLE Venda
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FuncionarioId INT,
	FormaPagamentoId INT,
	ClienteId INT,
	DataVenda DATETIME,
	TotalVenda FLOAT
)
GO
CREATE TABLE ItensVenda
(
	VendaId INT,
	ProdutoId INT,
	Quantidade INT,
	PrecoUnitario FLOAT,
	PrecoTotal FLOAT
)
GO
CREATE TABLE Financas
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	NumeroDoDocumento INT,
	FornecedorId INT,
	FormaPagamentoId INT,
	ValorTransacao FLOAT,
	Descricao VARCHAR(200),
	DataFinanca DATETIME,
	ImpostosPagos FLOAT,
	RetencaoDeImposto FLOAT,
	Conta FLOAT,
	Saldo FLOAT
)
GO
CREATE TABLE ControleDebito
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	ClienteId INT,
	FormaPagamentoId INT,
	ValorDebito FLOAT,
	DataLancamento DATETIME,
	DataVencimento DATETIME,
	DataPagamento DATETIME,
	Juros FLOAT,
	Desconto FLOAT,
	Acrescimo FLOAT	
)
GO
CREATE TABLE FormaPagamento
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Descricao VARCHAR(200)
)
GO
CREATE TABLE Exercicios
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nome Varchar(20)
)
GO
CREATE TABLE PlanoAssinatura
(
 Id INT PRIMARY KEY IDENTITY(1,1),
 TipoPlano VARCHAR(15),
 ValorPlano FLOAT,
 Desconto FLOAT
)
GO
CREATE TABLE PagamentoAluno
(
 Id INT PRIMARY KEY IDENTITY(1,1),
 AlunoId INT,
 PlanoAssinaturaId INT,
 FormaPagamentoId INT,
 Debitado BIT
)
GO
CREATE TABLE PagamentoFuncionario
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FuncionarioId Int,
	FormaPagamentoId INT,
	Valor FLOAT,
	Desconto FLOAT,
	HoraExtra INT
)
GO
CREATE TABLE Funcionario
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nome VARCHAR(100),
	CPF CHAR(14),
	Cargo Varchar(20),
	Telefone CHAR(14),
	Email VARCHAR(60),
	Endereco VARCHAR(100),
)

CREATE TABLE DadosBancarios
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	TipoDeMoedaId INT,
	TipoContaId INT,
	FornecedorId INT,
	NomeBanco VARCHAR(50),
	NumeroAgencia VARCHAR(6),
	NumeroConta VARCHAR(21),
	ChavePix VARCHAR(32),
	NomeTitular VARCHAR(100),
	CpfCnpj VARCHAR(15),
	Telefone VARCHAR(15),
	Email VARCHAR(100),
	Iban VARCHAR(34),
	Obs VARCHAR(100)
)
GO

CREATE TABLE TipoDeConta
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Descricao VARCHAR(20)
)
GO

SELECT * FROM DadosBancarios

CREATE  TABLE TipoDeMoeda
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	TipoMoeda VARCHAR(10)
)

GO
ALTER TABLE DadosBancarios
ADD CONSTRAINT FK_DadosBancarios_TipoDeMoeda
FOREIGN KEY (TipoDeMoedaId)
REFERENCES TipoDeMoeda(Id)
GO

ALTER TABLE DadosBancarios
ADD CONSTRAINT FK_DadosBancarios_TipoDeConta
FOREIGN KEY (TipoContaId)
REFERENCES TipoDeConta(Id)
GO

ALTER TABLE Venda
ADD CONSTRAINT FK_Venda_FormaPagamento
FOREIGN KEY (FormaPagamentoId)
REFERENCES FormaPagamento(Id);
GO

ALTER TABLE Financas
ADD CONSTRAINT FK_Financas_FormaPagamento 
FOREIGN KEY (FormaPagamentoId)
REFERENCES FormaPagamento(Id);
GO

ALTER TABLE PagamentoAluno
ADD CONSTRAINT FK_PagamentoAluno_FormaPagamento
FOREIGN KEY (FormaPagamentoId)
REFERENCES FormaPagamento(Id);
GO

ALTER TABLE PagamentoFuncionario
ADD CONSTRAINT FK_PagamentoFuncionario_FormaPagamento
FOREIGN KEY (FormaPagamentoId)
REFERENCES FormaPagamento(Id);
GO

ALTER TABLE ControleDebito
ADD CONSTRAINT FK_ControleDebito_FormaPagamento
FOREIGN KEY (FormaPagamentoId)
REFERENCES FormaPagamento(Id);
GO

ALTER TABLE ControleDebito
ADD CONSTRAINT FK_ControleDebito_Cliente
FOREIGN KEY (ClienteId)
REFERENCES Cliente(Id);
GO

ALTER TABLE CompraProduto
ADD CONSTRAINT FK_Compra_FormaPagamento
FOREIGN KEY (FormaPagamentoId)
REFERENCES FormaPagamento(Id);
GO

ALTER TABLE CompraProduto
ADD CONSTRAINT FK_Fornecedor_CompraProduto
FOREIGN KEY (FornecedorId)
REFERENCES Fornecedor(Id);
GO
ALTER TABLE ItensCompra
ADD CONSTRAINT FK_ItensCompra_Produto
FOREIGN KEY (ProdutoId)
REFERENCES Produto(Id);
GO
ALTER TABLE ItensCompra
ADD CONSTRAINT FK_ItensCompra_CompraProduto
FOREIGN KEY (CompraProdutoId)
REFERENCES CompraProduto(Id);
GO

ALTER TABLE Financas
ADD CONSTRAINT FK_Fornecedor_Financas
FOREIGN KEY (FornecedorId)
REFERENCES Fornecedor(ID)
GO

ALTER TABLE Venda
ADD CONSTRAINT FK_Venda_Funcionario
FOREIGN KEY (FuncionarioId)
REFERENCES Funcionario(Id);
GO

ALTER TABLE Venda
ADD CONSTRAINT FK_Venda_Cliente
FOREIGN KEY (ClienteId)
REFERENCES Cliente(Id);
GO

ALTER TABLE ItensVenda
ADD CONSTRAINT FK_ItensVenda_Venda
FOREIGN KEY (VendaId)
REFERENCES Venda(Id);

ALTER TABLE ItensVenda
ADD CONSTRAINT FK_ItensVenda_Produto
FOREIGN KEY (ProdutoId)
REFERENCES Produto(Id);
GO

ALTER TABLE PagamentoAluno
ADD CONSTRAINT FK_PagamentoAluno_Aluno
FOREIGN KEY (AlunoId)
REFERENCES Cliente(Id);
GO

ALTER TABLE PagamentoAluno
ADD CONSTRAINT FK_PagamentoAluno_PlanoAssinatura
FOREIGN KEY (PlanoAssinaturaId)
REFERENCES PlanoAssinatura(Id);
GO

ALTER TABLE PagamentoFuncionario
ADD CONSTRAINT FK_PagamentoFuncionario_Funcionario
FOREIGN KEY (FuncionarioId)
REFERENCES Funcionario(Id);
GO

select*from DadosBancarios
GO

ALTER TABLE Fornecedor
ADD Rua VARCHAR(100)
GO

ALTER TABLE Fornecedor
ADD CEP VARCHAR(100)
GO

ALTER TABLE Fornecedor
ADD Bairro VARCHAR(100)
GO

ALTER TABLE Fornecedor
ADD Complemento VARCHAR(100)
GO

ALTER TABLE Fornecedor
ADD NumeroCasa INT
GO

ALTER TABLE Fornecedor
DROP COLUMN Endereco
GO

--

select*from Funcionario
GO

ALTER TABLE Funcionario
ADD Rua VARCHAR(100)
GO

ALTER TABLE Funcionario
ADD CEP VARCHAR(100)
GO

ALTER TABLE Funcionario
ADD Bairro VARCHAR(100)
GO

ALTER TABLE Funcionario
ADD Complemento VARCHAR(100)
GO

ALTER TABLE Funcionario
ADD NumeroCasa INT
GO

ALTER TABLE Funcionario
DROP COLUMN Endereco
GO

--

select*from Cliente
GO

ALTER TABLE Cliente
ADD Rua VARCHAR(100)
GO

ALTER TABLE Cliente
ADD CEP VARCHAR(100)
GO

ALTER TABLE Cliente
ADD Bairro VARCHAR(100)
GO

ALTER TABLE Cliente
ADD Complemento VARCHAR(100)
GO

ALTER TABLE Cliente
ADD NumeroCasa INT
GO

ALTER TABLE Cliente
DROP COLUMN Endereco
GO

ALTER TABLE Funcionario
ALTER COLUMN CEP VARCHAR(9)
GO

ALTER TABLE Cliente
ALTER COLUMN CEP VARCHAR(9)
GO

ALTER TABLE Fornecedor
ALTER COLUMN CEP VARCHAR(9)
GO

--

ALTER TABLE Cliente
ADD Pais VARCHAR(50)
GO

ALTER TABLE Cliente
ADD Cidade VARCHAR(50)
GO

ALTER TABLE Cliente
ADD Estado VARCHAR(100)
GO

--

ALTER TABLE Fornecedor
ADD Pais VARCHAR(50)
GO

ALTER TABLE Fornecedor
ADD Cidade VARCHAR(50)
GO

ALTER TABLE Fornecedor
ADD Estado VARCHAR(100)
GO

--

ALTER TABLE Funcionario
ADD Pais VARCHAR(50)
GO

ALTER TABLE Funcionario
ADD Cidade VARCHAR(50)
GO

ALTER TABLE Funcionario
ADD Estado VARCHAR(100)
GO

--

ALTER TABLE Fornecedor
ALTER COLUMN Estado VARCHAR(50)
GO

ALTER TABLE Funcionario
ALTER COLUMN Estado VARCHAR(50)
GO

ALTER TABLE Cliente
ALTER COLUMN Estado VARCHAR(50)
GO

ALTER TABLE ControleDebito
ADD Descricao VARCHAR(200)
GO


ALTER TABLE FormaPagamento
ADD QuantidadeParcelas INT
GO


ALTER TABLE Venda
ADD Desconto FLOAT
GO
Alter Table ItensCompra
Drop column Frete 
GO
ALter table CompraProduto
ADD ValorTotalNota Float
Go


IF NOT EXISTS (SELECT 1 FROM SYS.INDEXES WHERE object_id = OBJECT_ID('Usuario') AND IS_PRIMARY_KEY = 1)
ALTER TABLE Usuario ADD CONSTRAINT PK_Usuario PRIMARY KEY (Id)

GO
IF NOT EXISTS (SELECT 1 FROM SYS.INDEXES WHERE object_id = OBJECT_ID('PermissaoGrupoUsuario') AND IS_PRIMARY_KEY = 1)
ALTER TABLE PermissaoGrupoUsuario ADD CONSTRAINT PK_PermissaoGrupoUsuario PRIMARY KEY (IdPermissao, IdGrupoUsuario)

GO

IF NOT EXISTS (SELECT 1 FROM SYS.FOREIGN_KEYS WHERE PARENT_OBJECT_ID = OBJECT_ID('UsuarioGrupoUsuario') AND name = 'FK_UsuarioGrupoUsuario_Usuario')
ALTER TABLE UsuarioGrupoUsuario
ADD CONSTRAINT FK_UsuarioGrupoUsuario_Usuario
FOREIGN KEY (IdUsuario) REFERENCES Usuario(Id)

GO

IF NOT EXISTS (SELECT 1 FROM SYS.FOREIGN_KEYS WHERE PARENT_OBJECT_ID = OBJECT_ID('UsuarioGrupoUsuario') AND name = 'FK_UsuarioGrupoUsuario_GrupoUsuario')
ALTER TABLE UsuarioGrupoUsuario
ADD CONSTRAINT FK_UsuarioGrupoUsuario_GrupoUsuario
FOREIGN KEY (IdGrupoUsuario) REFERENCES GrupoUsuario(Id)

GO

IF NOT EXISTS (SELECT 1 FROM SYS.FOREIGN_KEYS WHERE PARENT_OBJECT_ID = OBJECT_ID('PermissaoGrupoUsuario') AND name = 'FK_PermissaoGrupoUsuario_Permissao')
ALTER TABLE PermissaoGrupoUsuario
ADD CONSTRAINT FK_PermissaoGrupoUsuario_Permissao
FOREIGN KEY (IdPermissao) REFERENCES Permissao(Id)

GO

IF NOT EXISTS (SELECT 1 FROM SYS.FOREIGN_KEYS WHERE PARENT_OBJECT_ID = OBJECT_ID('PermissaoGrupoUsuario') AND name = 'FK_PermissaoGrupoUsuario_GrupoUsuario')
ALTER TABLE PermissaoGrupoUsuario
ADD CONSTRAINT FK_PermissaoGrupoUsuario_GrupoUsuario
FOREIGN KEY (IdGrupoUsuario) REFERENCES GrupoUsuario(Id)

GO

IF COL_LENGTH('Usuario', 'DataCadastro') IS NULL
ALTER TABLE Usuario ADD DataCadastro DATETIME DEFAULT GETDATE()

GO

IF(NOT EXISTS(SELECT 1 FROM Permissao WHERE Id = 1))INSERT INTO Permissao(Id, Descricao)VALUES(1,'Visualizar usu�rio')
IF(NOT EXISTS(SELECT 1 FROM Permissao WHERE Id = 2))INSERT INTO Permissao(Id, Descricao)VALUES(2,'Cadastrar usu�rio')
IF(NOT EXISTS(SELECT 1 FROM Permissao WHERE Id = 3))INSERT INTO Permissao(Id, Descricao)VALUES(3,'Alterar usu�rio')
IF(NOT EXISTS(SELECT 1 FROM Permissao WHERE Id = 4))INSERT INTO Permissao(Id, Descricao)VALUES(4,'Excluir usu�rio')
IF(NOT EXISTS(SELECT 1 FROM Permissao WHERE Id = 5))INSERT INTO Permissao(Id, Descricao)VALUES(5,'Visualizar grupo de usu�rio')
IF(NOT EXISTS(SELECT 1 FROM Permissao WHERE Id = 6))INSERT INTO Permissao(Id, Descricao)VALUES(6,'Cadastrar grupo de usu�rio')
IF(NOT EXISTS(SELECT 1 FROM Permissao WHERE Id = 7))INSERT INTO Permissao(Id, Descricao)VALUES(7,'Alterar grupo de usu�rio')
IF(NOT EXISTS(SELECT 1 FROM Permissao WHERE Id = 8))INSERT INTO Permissao(Id, Descricao)VALUES(8,'Excluir grupo de usu�rio')
IF(NOT EXISTS(SELECT 1 FROM Permissao WHERE Id = 9))INSERT INTO Permissao(Id, Descricao)VALUES(9,'Adicionar permiss�o a um grupo de usu�rio')
IF(NOT EXISTS(SELECT 1 FROM Permissao WHERE Id = 10))INSERT INTO Permissao(Id, Descricao)VALUES(10,'Adicionar grupo de usu�rio a um usu�rio')
GO

IF(NOT EXISTS(SELECT 1 FROM Usuario WHERE NomeUsuario = 'Adm'))INSERT INTO Usuario(Nome, NomeUsuario, Senha, Ativo)VALUES('Administrador da Silva', 'Adm', '123', 1)
IF(NOT EXISTS(SELECT 1 FROM Usuario WHERE NomeUsuario = 'Geno'))INSERT INTO Usuario(Nome, NomeUsuario, Senha, Ativo)VALUES('Genoveva', 'Geno', '123', 1)
IF(NOT EXISTS(SELECT 1 FROM Usuario WHERE NomeUsuario = 'Dag'))INSERT INTO Usuario(Nome, NomeUsuario, Senha, Ativo)VALUES('Dagorlina', 'Dag', '123', 1)
GO

INSERT INTO GrupoUsuario(NomeGrupo)VALUES('Gerente')
INSERT INTO GrupoUsuario(NomeGrupo)VALUES('Vendedor')
INSERT INTO GrupoUsuario(NomeGrupo)VALUES('Fiscal de caixa')
INSERT INTO GrupoUsuario(NomeGrupo)VALUES('Estoquista')
INSERT INTO GrupoUsuario(NomeGrupo)VALUES('Operador de caixa')

GO
INSERT INTO UsuarioGrupoUsuario VALUES(2,1)
INSERT INTO UsuarioGrupoUsuario VALUES(1,2)
GO

INSERT INTO PermissaoGrupoUsuario(IdGrupoUsuario, IdPermissao) VALUES(3,1)
INSERT INTO PermissaoGrupoUsuario(IdGrupoUsuario, IdPermissao) VALUES(3,2)
INSERT INTO PermissaoGrupoUsuario(IdGrupoUsuario, IdPermissao) VALUES(3,5)
INSERT INTO PermissaoGrupoUsuario(IdGrupoUsuario, IdPermissao) VALUES(4,2)
INSERT INTO PermissaoGrupoUsuario(IdGrupoUsuario, IdPermissao) VALUES(4,1)
INSERT INTO PermissaoGrupoUsuario(IdGrupoUsuario, IdPermissao) VALUES(4,5)
GO

INSERT INTO PermissaoGrupoUsuario (IdGrupoUsuario, IdPermissao)(SELECT 1, Id FROM Permissao)
GO
INSERT INTO PermissaoGrupoUsuario (IdGrupoUsuario, IdPermissao)VALUES(2, 1)
INSERT INTO PermissaoGrupoUsuario (IdGrupoUsuario, IdPermissao)VALUES(2, 2)
INSERT INTO PermissaoGrupoUsuario (IdGrupoUsuario, IdPermissao)VALUES(2, 3)
GO
INSERT INTO Cliente VALUES('Genilsom',1, '07790087655','(63)99124-9261','genism355@gmail.com',GETDATE(),'Magman','0987654','Lipídios',null,'107','Brasil', 'São Juares', 'Mato Fino')
INSERT INTO Cliente VALUES('Cloves',1, '012309371231','(63)99124-8899','clovis90@gmail.com',GETDATE(),'Milan','09665554','ragnar',null,'097','França', 'Rumiehe', 'Bonjuk')
SELECT*FROM FormaPagamento
SELECT*FROM Cliente
SELECT*FROM ControleDebito