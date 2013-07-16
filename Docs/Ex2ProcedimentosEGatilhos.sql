USE TrabFinalSI2

/* Alinea a) Inserir, actualizar e remover uma nova empresa ou �rea de interven��o. */
GO
CREATE PROCEDURE Insere_Empresa @NIPC INT, @designacao VARCHAR(100), @morada VARCHAR(500)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	INSERT INTO Empresa (NIPC,design,morada) VALUES (@NIPC,@designacao,@morada)
END

GO
CREATE PROCEDURE Actualiza_Empresa @NIPC INT, @designacao VARCHAR(100), @morada VARCHAR(500)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	UPDATE Empresa SET design=@designacao,morada=@morada WHERE NIPC=@NIPC
END

GO
CREATE PROCEDURE Apaga_Empresa  @NIPC INT
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	DELETE Empresa WHERE NIPC=@NIPC
END

GO
CREATE PROCEDURE Insere_AIntervencao @design VARCHAR(100), @descr VARCHAR(500)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	INSERT INTO AreaIntervencao (design,descr) VALUES (@design,@descr)
END

GO
CREATE PROCEDURE Actualiza_AIntervencao @cod INT, @design VARCHAR(100), @descr VARCHAR(500)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	UPDATE AreaIntervencao SET design=@design,descr=@morada WHERE cod=@cod
END

GO
CREATE PROCEDURE Apaga_AIntervencao @cod INT
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	DELETE AreaIntervencao WHERE cod=@cod
END

/* Alinea b) Reportar uma ocorr�ncia. */
GO
CREATE PROCEDURE Reporta_Ocorrencia 
	@entrada datetime,
	@estado int,
	@ultimaActualizacao datetime,
	@tipo int,
	@secInst int,
	@secPiso int,
	@secZona varchar(2)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	INSERT INTO Ocorrencia (entrada,estado,ultimaActualizacao,tipo,secInst,secPiso,secZona) VALUES (@entrada,@estado,@ultimaActualizacao,@tipo,@secInst,@secPiso,@secZona)
END

/* Alinea c) Cancelar uma ocorr�ncia. */
/**
Se por alguma razao entre o UPDATE e o PRINT o @@ROWCOUNT for modificado, a mensagem pode nao/aparecer erradamente
Pode ser resolvido de 2 formas. Obrigatoriamente ser� necess�rio recorrer a transac��es.
1-Guardar a actual subquery temporariamente, usa-la no UPDATE e voltar a confirmar antes de imprimir a mensagem.
2-Voltar a efectuar a mesma subquery antes de imprimir a mensagem
Utilizar nivel de isolamento REPEATABLE READ para evitar PHANTOMS(caso seja feita a subquery, entretanto outra transacao altere o campo 'concluido' do respectivo trabalho e depois se reavalie a subquery)
*/
GO
CREATE PROCEDURE Cancela_Ocurrencia 
	@id INT
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	UPDATE Ocorrencia SET estado=5,ultimaActualizacao=GETDATE() WHERE id=@id AND NOT EXISTS(SELECT * FROM Ocorrencia JOIN Afecto ON (id=trabOcorr) JOIN Trabalho ON (trabAI=codAInterv AND trabOcorr=idOcorr) WHERE id=@id AND concluido=0)
	if(@@ROWCOUNT!=0)
		PRINT 'Nao foi possivel cancelar';
END

/* Alinea d) Dar in�cio � resolu��o de uma ocorr�ncia em processamento. */
/*
O mesmo problema da alinea c)
*/
GO
CREATE PROCEDURE Resolve_Ocorrencia
	@id INT
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	UPDATE Ocorrencia SET estado=3,ultimaActualizacao=GETDATE() WHERE id=@id AND estado =2
	if(@@ROWCOUNT!=0)
		PRINT 'Nao foi possivel actualizar estado';
END
/*NOTA: A atribuicao de funcionarios e realizada no trigger */

/* Alinea e) Assinalar a finaliza��o da presta��o de servi�o numa �rea de interven��o de uma dada ocorr�ncia*/
GO
CREATE PROCEDURE Termina_Trabalho
	@idAI INT,
	@idOcorr INT
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	UPDATE Trabalho SET conlcuido=1 WHERE idAInterv=@idAI AND idOcorr=@idOcorr
	if(@@ROWCOUNT!=0)
		PRINT 'Nao foi possivel terminar o trabalho';
END

/* Alinea f) Apresentar, para cada empresa, o n�mero total de ocorr�ncias, organizadas por tipo. */
GO
CREATE PROCEDURE Ocorrencias_Por_Tipo
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SELECT design,nomeTipo,COUNT(*) AS NumeroDeOcorrencias FROM Empresa JOIN Instalacao ON(NIPC=empresa) JOIN Ocorrencia ON(cod=secInst) JOIN tipo ON(tipo=tipo.id) GROUP BY nomeTipo,design
END

/* Aliena g) Listar as ocorr�ncias em situa��o de incumprimento face ao prazo estabelecido para a sua resolu��o */
/* As interven��es do tipo �urgente� devem ser resolvidas no prazo m�ximo de 48 horas, as do tipo �cr�tico� devem ser resolvidas no prazo m�ximo de 12 horas. */
GO
CREATE PROCEDURE Listar_Ocorrencias_Atrasadas
AS
BEGIN
	SELECT * FROM Ocorrencia WHERE estado <=3 AND ((tipo=1 AND GETDATE()>DATEADD(hh,48,entrada)) OR (tipo=2 AND GETDATE()>DATEADD(hh,12,entrada)))
END

/* Alinea h) Indicar, para uma determinada �rea de interven��o, qual a empresa com maior n�mero de ocorr�ncias do tipo �cr�tico� que reportou ocorr�ncias nessa �rea. */
GO
CREATE PROCEDURE Listar_Ocorrencias_Atrasadas
AS
BEGIN
	SELECT * FROM Empresa JOIN Instalacao ON(NIPC=empresa)
END
SELECT * FROM Empresa JOIN Instalacao ON(NIPC=empresa) JOIN Sector ON(instalacao=cod) JOIN Ocorrencia ON(secInst=instalacao AND secPiso=piso AND secZona=zona)