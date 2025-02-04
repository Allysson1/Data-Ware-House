USE [Biblioteca]
GO
/****** Object:  Table [dbo].[Autores]    Script Date: 23/03/2022 19:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Autores](
	[CodigoAutor] [int] NOT NULL,
	[NomeAutor] [varchar](40) NOT NULL,
	[SexoAutor] [char](1) NULL,
	[DAtaNascimentoAutor] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[CodigoAutor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Autores2]    Script Date: 23/03/2022 19:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Autores2](
	[CodigoAutor] [int] NOT NULL,
	[NomeAutor] [varchar](40) NOT NULL,
	[SexoAutor] [char](1) NULL,
	[DAtaNascimentoAutor] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[CodigoAutor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 23/03/2022 19:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[CodigoCliente] [int] NOT NULL,
	[NomeCliente] [varchar](100) NULL,
 CONSTRAINT [PK_Clientes_CodigoCliente] PRIMARY KEY CLUSTERED 
(
	[CodigoCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Editoras]    Script Date: 23/03/2022 19:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Editoras](
	[CodigoEditora] [int] NOT NULL,
	[NomeEditora] [varchar](30) NOT NULL,
	[DescricaoEditora] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[CodigoEditora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funcionarios]    Script Date: 23/03/2022 19:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funcionarios](
	[CodigoFuncionario] [int] NOT NULL,
	[NomeFuncionario] [varchar](60) NOT NULL,
	[DataNascimentoFuncionario] [date] NOT NULL,
	[EmailFuncionario] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodigoFuncionario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Livros]    Script Date: 23/03/2022 19:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Livros](
	[CodigoLivro] [int] NOT NULL,
	[CodigoEditora] [int] NOT NULL,
	[CodigoAutor] [int] NOT NULL,
	[NomeLivro] [varchar](80) NOT NULL,
	[DescricaoLivro] [varchar](60) NOT NULL,
	[ISBN] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodigoLivro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Socios]    Script Date: 23/03/2022 19:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Socios](
	[CodigoSocio] [int] NOT NULL,
	[NomeSocio] [varchar](60) NOT NULL,
	[DataNascimento] [date] NOT NULL,
	[Email] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Socios_CodigoSocio] PRIMARY KEY CLUSTERED 
(
	[CodigoSocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Autores] ([CodigoAutor], [NomeAutor], [SexoAutor], [DAtaNascimentoAutor]) VALUES (1, N'Autor A', N'M', CAST(N'1980-04-06' AS Date))
INSERT [dbo].[Autores] ([CodigoAutor], [NomeAutor], [SexoAutor], [DAtaNascimentoAutor]) VALUES (2, N'Autor B', N'F', CAST(N'1980-05-08' AS Date))
INSERT [dbo].[Autores] ([CodigoAutor], [NomeAutor], [SexoAutor], [DAtaNascimentoAutor]) VALUES (3, N'Autor C', N'F', CAST(N'1980-06-18' AS Date))
GO
INSERT [dbo].[Editoras] ([CodigoEditora], [NomeEditora], [DescricaoEditora]) VALUES (1, N'Editora Azul', N'Blue')
INSERT [dbo].[Editoras] ([CodigoEditora], [NomeEditora], [DescricaoEditora]) VALUES (2, N'Editora Amarela', N'Yellow')
GO
