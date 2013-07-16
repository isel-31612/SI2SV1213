USE TrabFinalSI2

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Empresa'))
	create table Empresa(
		NIPC int primary key,
		design varchar(100) not null,
		morada varchar(500) not null
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Instalacao'))
	create table Instalacao(
		cod int primary key IDENTITY,
		descr varchar(100),
		morada varchar(500) not null,
		geo varchar(10) not null,
		empresa int not null REFERENCES Empresa(NIPC)
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Sector'))
	create table Sector(
		piso int not null,
		zona varchar(2) not null,							/*View para codigo unico*/
		instalacao int not null REFERENCES Instalacao(cod),
		descr varchar(100) not null,
		extintor bit not null,
		primary key(instalacao,piso,zona)
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='AreaIntervencao'))
	create table AreaIntervencao(
		cod int primary key IDENTITY,
		design varchar(100) not null,
		descr varchar(500)
	)
	
IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='estadoFunc'))
	create table estadoFunc(
		id int primary key IDENTITY,
		nomeEstado varchar(12) not null unique /*"activo”, “baixa médica”, “férias”, “falecido” e “demitido”*/
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Funcionario'))
	create table Funcionario(/*Nao pode ser removido*//*apenas ve as ocorrencias para as quais esta habilitado*/
		num int primary key IDENTITY,
		nome varchar (100) not null,
		dataNasc date not null,			/*View para idade*/
		estado int not null REFERENCES estadoFunc(id)
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Coordenador'))
	create table Coordenador(
		numFunc int primary key REFERENCES Funcionario(num)
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='estadoOcorr'))
	create table estadoOcorr(
		id int primary key IDENTITY,
		nomeEstado varchar(16) not null unique /*inicial, em processamento, em resolução, recusado, cancelado ou concluído*/
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='tipo'))
	create table tipo(
		id int primary key IDENTITY,
		nomeTipo varchar(15) not null unique/*“urgente”, “crítico” ou “trivial”*/
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Ocorrencia'))
	create table Ocorrencia( /*Nao podem ser eliminados*/
		id int primary key IDENTITY,
		entrada datetime not null,
		estado int not null DEFAULT 1 REFERENCES estadoOcorr(id), /*ao entrar em resolucao apenas um coordenador por alterar*//* Uma ocorrência não pode ser cancelada se, para alguma das suas área de intervenção, já estiver concluído o trabalho.*/
		ultimaActualizacao datetime not null, 
		tipo int not null REFERENCES tipo(id),
		secInst int null,
		secPiso int null,
		secZona varchar(2) null,
		CONSTRAINT FK_OcorrencioNoSector FOREIGN KEY (secInst,secPiso,secZona) REFERENCES Sector(instalacao,piso,zona) ON DELETE SET NULL ON UPDATE CASCADE
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Afecto'))
	create table Afecto(
		trabOcorr int REFERENCES Ocorrencia(id),
		trabAI int REFERENCES AreaIntervencao(cod),
		funcionario int REFERENCES Funcionario(num),
		primary key (trabOcorr,trabAI,funcionario),
		/*CONSTRAINT CK_FuncMaxOcorr10 CHECK ( (SELECT COUNT(*) FROM Afecto JOIN Ocorrencia ON (trabOcorr=id) WHERE estado<=2 GROUP BY funcionario) <= 10), /*E preciso testar*/
		CONSTRAINT CK_AIMax3 CHECK ( (SELECT COUNT(*) FROM Afecto GROUP BY funcionario,trabOcorr) <= 3) /*E preciso testar*/
	*/)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Habilitado'))
	create table Habilitado(
		areaInterv int not null REFERENCES AreaIntervencao(cod),
		func int not null REFERENCES Funcionario(num),
		dataHab date not null,
		primary key (areaInterv, func)
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Trabalho'))
	create table Trabalho(
		idOcorr int not null REFERENCES Ocorrencia(id),
		codAInterv int not null REFERENCES AreaIntervencao(cod),
		descTrabalho varchar(500) not null,
		concluido bit not null,
		coordenador int not null REFERENCES Coordenador(numFunc),/*Automatico ao habilitado com menos ocurrencias*/
		primary key (idOcorr,codAInterv)
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Admin'))
	create table Admin(
		numFunc int primary key REFERENCES Funcionario(num)
		/*Apenas um administrador ordem de entrada em resolução de uma ocorrência, de a recusar ou cancelar.*/
	)

IF(NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Relatorio'))
	create table Relatorio(
		id int primary key IDENTITY,
		func INT NOT NULL REFERENCES Funcionario(num),
		categoriaAutor NVARCHAR(100),
		dataEmissao DATE NOT NULL,
		tipo NVARCHAR(7) NOT NULL CHECK (tipo='parcial' OR tipo='final'),
		dataPrevista DATE NULL,
		documento NVARCHAR(500) NULL,
		CONSTRAINT CK_EmissaoAntesPrevista CHECK( dataPrevista!=NULL AND dataPrevista > dataEmissao)
	)