USE TrabFinalSI2

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Empresa'))
BEGIN
	INSERT INTO Empresa (NIPC,design,morada) VALUES (123456789,'XPTO Ldt','Rua Irrelevante Nº0, Cascos de Rolha')
	INSERT INTO Empresa (NIPC,design,morada) VALUES (123654987,'Empresa Guilherme','Rua D.Afonso Henriques Nº2, Sintra')
	INSERT INTO Empresa (NIPC,design,morada) VALUES (123456987,'ISEL','Rua Conselheiro Emidio Navarro Nº58, Chelas')
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Instalacao'))
BEGIN
	INSERT INTO Instalacao (descr,morada,geo,empresa) VALUES('Instituto','Rua Conselheiro Emidio Navarro Nº58, Chelas','GEO1011654',123456987)
	INSERT INTO Instalacao (descr,morada,geo,empresa) VALUES('Descampado','Rua Conselheiro Emidio Navarro Nº50, Chelas','GEO1013655',123456987)
	INSERT INTO Instalacao (descr,morada,geo,empresa) VALUES('Escritorios','Rua D.Afonso Henriques Nº2, Sintra','GEO9562113',123654987)
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Sector'))
BEGIN
	INSERT INTO Sector (piso,zona,instalacao,descr,extintor) VALUES (0,1,1,'Centro de Calculo',1)
	INSERT INTO Sector (piso,zona,instalacao,descr,extintor) VALUES (0,2,1,'Cantina',0)
	INSERT INTO Sector (piso,zona,instalacao,descr,extintor) VALUES (1,3,1,'Departamento Civil',1)
	INSERT INTO Sector (piso,zona,instalacao,descr,extintor) VALUES (1,4,1,'Dormitorios',0)
	INSERT INTO Sector (piso,zona,instalacao,descr,extintor) VALUES (0,1,2,'Zona Norte',0)
	INSERT INTO Sector (piso,zona,instalacao,descr,extintor) VALUES (0,2,2,'Zona Sul',0)
	INSERT INTO Sector (piso,zona,instalacao,descr,extintor) VALUES (1,1,3,'Escritorios de Atendimento',1)
	INSERT INTO Sector (piso,zona,instalacao,descr,extintor) VALUES (2,1,3,'Backoffice',1)
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='AreaIntervencao'))
BEGIN
	INSERT INTO AreaIntervencao (design,descr) VALUES ('designacao1','descricao1')
	INSERT INTO AreaIntervencao (design,descr) VALUES ('designacao2','descricao2')
	INSERT INTO AreaIntervencao (design,descr) VALUES ('designacao3','descricao3')
	INSERT INTO AreaIntervencao (design,descr) VALUES ('designacao4','descricao4')
	INSERT INTO AreaIntervencao (design,descr) VALUES ('designacao5','descricao5')
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='estadoFunc'))
BEGIN
	INSERT INTO estadoFunc (nomeEstado) VALUES ('activo')
	INSERT INTO estadoFunc (nomeEstado) VALUES ('baixa médica')
	INSERT INTO estadoFunc (nomeEstado) VALUES ('férias')
	INSERT INTO estadoFunc (nomeEstado) VALUES ('falecido')
	INSERT INTO estadoFunc (nomeEstado) VALUES ('demitido')
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Funcionario'))
BEGIN
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Zeca Afonso','1945-11-23',1)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Roberto Leal','1955-02-11',1)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Marta Câmara','1992-05-12',1)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Mafalda Nascimento','1965-03-01',1)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Amanda Guerreiro','1995-12-25',2)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Amilcar Bonifesto','1939-04-17',3)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Carlos Pinheiro','1978-09-06',2)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('David Jones','1966-10-02',4)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Robbie Williams','1976-05-15',4)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Patricia Martim','1995-03-20',5)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Bill Gates','1964-10-05',5)
	INSERT INTO Funcionario (nome, dataNasc,estado) VALUES ('Jeronimo de Sousa','1965-01-01',5)
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Coordenador'))
BEGIN
	INSERT INTO Coordenador (numFunc) VALUES (1)
	INSERT INTO Coordenador (numFunc) VALUES (5)
	INSERT INTO Coordenador (numFunc) VALUES (6)
	INSERT INTO Coordenador (numFunc) VALUES (12)
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='estadoOcorr'))
BEGIN
	INSERT INTO estadoOcorr (nomeEstado) VALUES ('inicial')
	INSERT INTO estadoOcorr (nomeEstado) VALUES ('em processamento')
	INSERT INTO estadoOcorr (nomeEstado) VALUES ('em resolucao')
	INSERT INTO estadoOcorr (nomeEstado) VALUES ('recusado')
	INSERT INTO estadoOcorr (nomeEstado) VALUES ('cancelado')
	INSERT INTO estadoOcorr (nomeEstado) VALUES ('concluido')
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='tipo'))
BEGIN
	INSERT INTO tipo (nomeTipo) VALUES ('urgente')
	INSERT INTO tipo (nomeTipo) VALUES ('crítico')
	INSERT INTO tipo (nomeTipo) VALUES ('trivial')
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Ocorrencia'))
BEGIN
	INSERT INTO Ocorrencia (entrada,estado,ultimaActualizacao,tipo,secPiso,secZona,secInst) VALUES ('2013-06-19 21:05',1,'2013-06-19 13:00',1,0,1,1)
	INSERT INTO Ocorrencia (entrada,estado,ultimaActualizacao,tipo,secPiso,secZona,secInst) VALUES ('2013-06-17 22:06',2,'2013-06-19 12:00',2,0,2,1)
	INSERT INTO Ocorrencia (entrada,estado,ultimaActualizacao,tipo,secPiso,secZona,secInst) VALUES ('2013-06-10 23:07',3,'2013-06-19 10:00',3,1,3,1)
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Afecto'))
BEGIN
	INSERT INTO Afecto (trabOcorr,trabAI,funcionario) VALUES (1,1,1)
	INSERT INTO Afecto (trabOcorr,trabAI,funcionario) VALUES (2,2,1)
	INSERT INTO Afecto (trabOcorr,trabAI,funcionario) VALUES (3,3,1)
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Habilitado'))
BEGIN
	INSERT INTO Habilitado (areaInterv,func,dataHab) VALUES (1,1,'1968-07-15')
	INSERT INTO Habilitado (areaInterv,func,dataHab) VALUES (2,2,'1985-02-11')
	INSERT INTO Habilitado (areaInterv,func,dataHab) VALUES (3,3,'2012-10-22')
	INSERT INTO Habilitado (areaInterv,func,dataHab) VALUES (3,4,'1995-01-17')
	INSERT INTO Habilitado (areaInterv,func,dataHab) VALUES (3,5,'1995-12-25')
	INSERT INTO Habilitado (areaInterv,func,dataHab) VALUES (3,6,'1941-07-10')
	INSERT INTO Habilitado (areaInterv,func,dataHab) VALUES (3,7,'1998-12-22')
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Trabalho'))
BEGIN
	INSERT INTO Trabalho (idOcorr,codAInterv,descTrabalho,concluido,coordenador) VALUES (1,1,'Apagar Fogo',1,1)
	INSERT INTO Trabalho (idOcorr,codAInterv,descTrabalho,concluido,coordenador) VALUES (2,2,'Des-Ratizar',0,5)
	INSERT INTO Trabalho (idOcorr,codAInterv,descTrabalho,concluido,coordenador) VALUES (3,3,'Investigar Assalto',0,5)
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Admin'))
BEGIN
	INSERT INTO Admin (numFunc) VALUES (2)
	INSERT INTO Admin (numFunc) VALUES (4)
	INSERT INTO Admin (numFunc) VALUES (5)
END

IF(EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Relatorio'))
BEGIN
	INSERT INTO Relatorio (func,categoriaAutor,dataEmissao,tipo,dataPrevista,documento) VALUES (1,'Lazer','2013-06-06','final',NULL,NULL)
	INSERT INTO Relatorio (func,categoriaAutor,dataEmissao,tipo,dataPrevista,documento) VALUES (1,'Lazer','2013-06-07','final',NULL,NULL)
	INSERT INTO Relatorio (func,categoriaAutor,dataEmissao,tipo,dataPrevista,documento) VALUES (1,'Lazer','2013-06-08','parcial',NULL,NULL)
END