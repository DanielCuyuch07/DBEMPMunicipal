USE DBEMPMunicipal
GO

SET ANSI_NULLS ON 
GO 

CREATE PROCEDURE SP_ADM_Municipio_INS (
	@nombreMunicipio nvarchar(80),
	@departamentoId	INT
)
AS
BEGIN

	SET NOCOUNT ON; 
	
	IF @nombreMunicipio IS NULL OR LEN(LTRIM(RTRIM(@nombreMunicipio))) = 0
    BEGIN
        RAISERROR('El nombre de municipio es obligatorio.', 11, 1);
        RETURN 5;
    END

	IF NOT EXISTS (SELECT 1 FROM dbo.ADM_Departamento WHERE idDepartamento = @departamentoId)
    BEGIN
         RAISERROR('NO EXISTE EL DEPARTEMENTO EN LA DB', 11, 1);
         RETURN 10; 
    END

	IF EXISTS (SELECT 1 FROM ADM_Municipio WHERE nombreMunicipio = @nombreMunicipio)
	BEGIN
		RAISERROR('EL MUNICIPIO YA EXISTE EN BASE DE DATOS. INTENTELO DE NUEVO.', 11, 1);
		RETURN 1;	
	END 

	BEGIN TRAN;
		INSERT INTO ADM_Municipio(nombreMunicipio,departamentoId)
		VALUES(@nombreMunicipio,@departamentoId)
	COMMIT TRAN;
	        
	RETURN 0; -- éxito
END 