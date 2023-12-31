USE [master]
GO
/****** Object:  Database [BDMG_Vendas]    Script Date: 18/08/2023 16:46:45 ******/
CREATE DATABASE [BDMG_Vendas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BDMG_Vendas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BDMG_Vendas.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BDMG_Vendas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BDMG_Vendas_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BDMG_Vendas] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BDMG_Vendas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BDMG_Vendas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET ARITHABORT OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BDMG_Vendas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BDMG_Vendas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BDMG_Vendas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BDMG_Vendas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BDMG_Vendas] SET  MULTI_USER 
GO
ALTER DATABASE [BDMG_Vendas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BDMG_Vendas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BDMG_Vendas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BDMG_Vendas] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BDMG_Vendas] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BDMG_Vendas] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BDMG_Vendas] SET QUERY_STORE = OFF
GO
USE [BDMG_Vendas]
GO
/****** Object:  User [BDMG_User]    Script Date: 18/08/2023 16:46:45 ******/
CREATE USER [BDMG_User] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BDMG]    Script Date: 18/08/2023 16:46:45 ******/
CREATE USER [BDMG] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [BDMG_User]
GO
ALTER ROLE [db_owner] ADD MEMBER [BDMG]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 18/08/2023 16:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NULL,
	[CPF] [varchar](50) NULL,
	[Status] [bit] NULL,
	[DataNascimento] [date] NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fornecedores]    Script Date: 18/08/2023 16:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fornecedores](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[NomeFantasia] [varchar](100) NULL,
	[RazaoSocial] [varchar](100) NULL,
	[CNPJ] [varchar](50) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Fornecedores] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produtos]    Script Date: 18/08/2023 16:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produtos](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Descricao] [varchar](100) NULL,
	[PrecoUnitario] [float] NOT NULL,
	[CodigoFornecedor] [int] NOT NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Produtos] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProdutosVendidos]    Script Date: 18/08/2023 16:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProdutosVendidos](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Descricao] [varchar](100) NOT NULL,
	[PrecoUnitario] [float] NOT NULL,
	[QuantidadeVendida] [int] NOT NULL,
	[ValorTotal] [float] NOT NULL,
	[CodigoCliente] [int] NOT NULL,
	[CodigoProduto] [int] NOT NULL,
	[CodigoNumeroVenda] [int] NOT NULL,
 CONSTRAINT [PK_ProdutosVendidos] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendas]    Script Date: 18/08/2023 16:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendas](
	[NumeroVenda] [int] IDENTITY(1,1) NOT NULL,
	[CodigoCliente] [int] NULL,
	[DataHora] [datetime] NULL,
	[ValorTotal] [float] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Produtos_Vendidos] PRIMARY KEY CLUSTERED 
(
	[NumeroVenda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (31, N'Charles da Silva Rocha', N'07239415724', 1, CAST(N'1976-07-12' AS Date))
INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (32, N'Aryna Martins', N'76552651600', 1, CAST(N'1993-04-25' AS Date))
INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (33, N'Pinkerton Rocha', N'17579814030', 1, CAST(N'1976-07-12' AS Date))
INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (34, N'Ánique Rocha', N'36024653069', 1, CAST(N'2003-05-25' AS Date))
INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (35, N'Alicia Martins Rocha', N'52182283382', 1, CAST(N'2001-07-30' AS Date))
INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (36, N'Daysha Martins', N'52539386806', 0, CAST(N'1986-09-29' AS Date))
INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (37, N'Acirion da Silva', N'23037616709', 0, CAST(N'1983-01-27' AS Date))
INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (38, N'Sharon Silva', N'68552726491', 0, CAST(N'2005-02-04' AS Date))
INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (39, N'Danisha Silva Rocha', N'77604026354', 1, CAST(N'2010-08-08' AS Date))
INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (40, N'Nichayla Martins', N'33506566504', 1, CAST(N'2000-12-14' AS Date))
INSERT [dbo].[Clientes] ([Codigo], [Nome], [CPF], [Status], [DataNascimento]) VALUES (41, N'Ágnes Rocha', N'13360314506', 0, CAST(N'2018-07-16' AS Date))
SET IDENTITY_INSERT [dbo].[Clientes] OFF
GO
SET IDENTITY_INSERT [dbo].[Fornecedores] ON 

INSERT [dbo].[Fornecedores] ([Codigo], [NomeFantasia], [RazaoSocial], [CNPJ], [Status]) VALUES (8, N'Kabum Eletrônicos S.A.', N'Kabum Comércio Eletrônico', N'05570714000159', 1)
INSERT [dbo].[Fornecedores] ([Codigo], [NomeFantasia], [RazaoSocial], [CNPJ], [Status]) VALUES (9, N'Mercado Livre', N'Mercado Livre LTDA', N'54987241000103', 0)
INSERT [dbo].[Fornecedores] ([Codigo], [NomeFantasia], [RazaoSocial], [CNPJ], [Status]) VALUES (10, N'Mercado Livre Eletrônico', N'Mercado Livre LTDA', N'62483483000180', 1)
INSERT [dbo].[Fornecedores] ([Codigo], [NomeFantasia], [RazaoSocial], [CNPJ], [Status]) VALUES (11, N'Pichau Informática', N'Pichau Informática LTDA', N'09376495000122', 1)
INSERT [dbo].[Fornecedores] ([Codigo], [NomeFantasia], [RazaoSocial], [CNPJ], [Status]) VALUES (14, N'Fas Shop Informática', N'Fas Shop Informática LTDA', N'02491536000182', 1)
INSERT [dbo].[Fornecedores] ([Codigo], [NomeFantasia], [RazaoSocial], [CNPJ], [Status]) VALUES (15, N'Zinzara Informática', N'Zinzara Informática LTDA', N'81408332000101', 0)
INSERT [dbo].[Fornecedores] ([Codigo], [NomeFantasia], [RazaoSocial], [CNPJ], [Status]) VALUES (16, N'Amazon Eletrônicos', N'Amazon Eletrônicos S.A.', N'24264831000139', 1)
SET IDENTITY_INSERT [dbo].[Fornecedores] OFF
GO
SET IDENTITY_INSERT [dbo].[Produtos] ON 

INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (16, N'Adaptador DVI Macho x VGA Fêmea', 55.9, 8, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (17, N'Cadeira Gamer Thunder X3', 899.99, 8, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (18, N'Fonte Corsair RMX Series RM850X Full Modular', 929.99, 11, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (19, N'Gabinete Gamer Corsair Series Spec', 55.09, 11, 0)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (20, N'Gabinete Lian Li', 1299.99, 11, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (21, N'Memória Corsair 2x8Gb DDDR3', 699.89, 10, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (22, N'Monitor Gamer Samsung Odyssey 27"', 1479.5, 14, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (23, N'Gabinete PC-O11 Dynamic XL ROG', 1100.4, 14, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (24, N'Placa de Vídeo NVidia GeForce RTX 3070 Ti', 4590.5, 10, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (25, N'Placa Mãe ASUS PRIME Z790-A WI-FI', 3280.6, 14, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (26, N'Placa Mãe Gigabyte Z690 Aero D', 3699.9, 8, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (27, N'Processador Intel i9-13900K 13th', 4999, 11, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (28, N'SSD Corsair MP600 Pro XT 4TB', 4599.99, 8, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (29, N'Teclado Mecânico Corsair', 635, 8, 0)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (30, N'Teclado Mecânico Gamer Corsair K70 MK.2, RGB', 1250.35, 8, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (31, N'Water Cooler Master Liquid', 679.8, 14, 0)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (32, N'Water Cooler Corsair Icue H170i Elite, RGB, 420mm', 1333.12, 11, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (33, N'Fonte Corsair RM650x - 650W, 80 Plus Gold, Modular', 1307.14, 16, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (34, N'Fonte Corsair HX Series Modular HX1000 1000W 80 Plus Platinum', 1780.86, 16, 1)
INSERT [dbo].[Produtos] ([Codigo], [Descricao], [PrecoUnitario], [CodigoFornecedor], [Status]) VALUES (35, N'Gabinete PC-O11 Dynamic XL ROG Certified Full Tower Vidro Temperado', 2065.5, 16, 1)
SET IDENTITY_INSERT [dbo].[Produtos] OFF
GO
SET IDENTITY_INSERT [dbo].[ProdutosVendidos] ON 

INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (90, N'Gabinete Lian Li', 1299.99, 1, 1299.99, 31, 20, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (91, N'Cadeira Gamer Thunder X3', 899.99, 1, 899.99, 31, 17, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (92, N'Monitor Gamer Samsung Odyssey 27"', 1479.5, 1, 1479.5, 31, 22, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (93, N'Memória Corsair 2x8Gb DDDR3', 699.89, 2, 1399.78, 31, 21, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (100, N'Adaptador DVI Macho x VGA Fêmea', 55.9, 2, 111.8, 32, 16, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (101, N'Gabinete PC-O11 Dynamic XL ROG', 1100.4, 1, 1100.4, 32, 23, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (102, N'Monitor Gamer Samsung Odyssey 27"', 1479.5, 1, 1479.5, 33, 22, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (103, N'Placa Mãe ASUS PRIME Z790-A WI-FI', 3280.6, 1, 3280.6, 33, 25, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (104, N'Processador Intel i9-13900K 13th', 4999, 1, 4999, 33, 27, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (105, N'Teclado Mecânico Gamer Corsair K70 MK.2, RGB', 1250.35, 1, 1250.35, 33, 30, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (106, N'Memória Corsair 2x8Gb DDDR3', 699.89, 2, 1399.78, 33, 21, 9)
INSERT [dbo].[ProdutosVendidos] ([Codigo], [Descricao], [PrecoUnitario], [QuantidadeVendida], [ValorTotal], [CodigoCliente], [CodigoProduto], [CodigoNumeroVenda]) VALUES (107, N'Water Cooler Corsair Icue H170i Elite, RGB, 420mm', 1333.12, 1, 1333.12, 33, 32, 9)
SET IDENTITY_INSERT [dbo].[ProdutosVendidos] OFF
GO
SET IDENTITY_INSERT [dbo].[Vendas] ON 

INSERT [dbo].[Vendas] ([NumeroVenda], [CodigoCliente], [DataHora], [ValorTotal], [Status]) VALUES (9, 31, CAST(N'2023-08-18T16:17:50.000' AS DateTime), 5079.26, 1)
INSERT [dbo].[Vendas] ([NumeroVenda], [CodigoCliente], [DataHora], [ValorTotal], [Status]) VALUES (14, 32, CAST(N'2023-08-18T16:36:00.000' AS DateTime), 1212.2, 0)
INSERT [dbo].[Vendas] ([NumeroVenda], [CodigoCliente], [DataHora], [ValorTotal], [Status]) VALUES (15, 33, CAST(N'2023-08-18T16:41:37.000' AS DateTime), 13742.35, 0)
SET IDENTITY_INSERT [dbo].[Vendas] OFF
GO
ALTER TABLE [dbo].[Produtos]  WITH CHECK ADD  CONSTRAINT [FK_Produtos_Fornecedor] FOREIGN KEY([CodigoFornecedor])
REFERENCES [dbo].[Fornecedores] ([Codigo])
GO
ALTER TABLE [dbo].[Produtos] CHECK CONSTRAINT [FK_Produtos_Fornecedor]
GO
ALTER TABLE [dbo].[ProdutosVendidos]  WITH CHECK ADD  CONSTRAINT [FK_ProdutosVendidos_Clientes] FOREIGN KEY([CodigoCliente])
REFERENCES [dbo].[Clientes] ([Codigo])
GO
ALTER TABLE [dbo].[ProdutosVendidos] CHECK CONSTRAINT [FK_ProdutosVendidos_Clientes]
GO
ALTER TABLE [dbo].[ProdutosVendidos]  WITH CHECK ADD  CONSTRAINT [FK_ProdutosVendidos_Produtos] FOREIGN KEY([CodigoProduto])
REFERENCES [dbo].[Produtos] ([Codigo])
GO
ALTER TABLE [dbo].[ProdutosVendidos] CHECK CONSTRAINT [FK_ProdutosVendidos_Produtos]
GO
ALTER TABLE [dbo].[ProdutosVendidos]  WITH CHECK ADD  CONSTRAINT [FK_ProdutosVendidos_Vendas] FOREIGN KEY([CodigoNumeroVenda])
REFERENCES [dbo].[Vendas] ([NumeroVenda])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProdutosVendidos] CHECK CONSTRAINT [FK_ProdutosVendidos_Vendas]
GO
ALTER TABLE [dbo].[Vendas]  WITH CHECK ADD  CONSTRAINT [FK_Vendas_Clientes] FOREIGN KEY([CodigoCliente])
REFERENCES [dbo].[Clientes] ([Codigo])
GO
ALTER TABLE [dbo].[Vendas] CHECK CONSTRAINT [FK_Vendas_Clientes]
GO
USE [master]
GO
ALTER DATABASE [BDMG_Vendas] SET  READ_WRITE 
GO
