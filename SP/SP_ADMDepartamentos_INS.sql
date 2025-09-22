USE DBEMPMunicipal 
GO

SET ANSI_NULLS ON; 
GO

CREATE PROCEDURE SP_ADMDepartamentos_INS(
	 @departamento	NVARCHAR(80)
)
AS 
BEGIN 

	SET NOCOUNT ON; 

	IF EXISTS (SELECT 1 FROM ADM_Departamento WHERE departamento = @departamento )
	BEGIN
		RAISERROR('EL DEPARTAMENTO YA EXISTE EN BASE DE DATOS. INTENTELO DE NUEVO.', 11, 1);
		RETURN 1;
	END

    BEGIN TRAN;
		INSERT INTO dbo.ADM_Departamento(departamento)
        VALUES (@departamento);
	COMMIT TRAN;
    RETURN 0;

END 