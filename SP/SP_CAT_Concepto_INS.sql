USE DBEMPMunicipal; 
GO

SET ANSI_NULLS ON; 
GO


CREATE PROCEDURE SP_CAT_Concepto_INS(
	@nombre NVARCHAR(30),
	@tipo   NVARCHAR(30)
)
AS
BEGIN 

	SET NOCOUNT ON; 

	INSERT INTO CAT_Concepto(nombre,tipo)
	VALUES(@nombre,@tipo)

	return 0; 

END 