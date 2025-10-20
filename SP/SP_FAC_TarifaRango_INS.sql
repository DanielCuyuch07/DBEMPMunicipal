USE DBEMPMunicipal; 
GO

SET ANSI_NULLS ON; 
GO


CREATE PROCEDURE SP_FAC_TarifaRango_INS(
	@desdeM3   DECIMAL(10,3),
	@hastaM3   DECIMAL(10,3),
	@precioM3  DECIMAL(10,3),
	@tarifaId  INT
)
AS
BEGIN 

	SET NOCOUNT ON; 

	INSERT INTO FAC_TarifaRango(desdeM3,hastaM3,precioM3,tarifaId)
	VALUES(@desdeM3, @hastaM3, @precioM3,@tarifaId)

	return 0; 

END 