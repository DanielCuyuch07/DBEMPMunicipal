USE DBEMPMunicipal
GO


SET ANSI_NULLS ON 
GO 


CREATE PROCEDURE SP_Estructura_INS
(
	 @campo1	NVARCHAR(100), -- NVARCHAR LO PONEMOS DE EJEMPLO
	 @campo2	NVARCHAR(100),
	 @campo3	NVARCHAR(100),
	 @campo4	NVARCHAR(100),
	 @campo5	NVARCHAR(100)

)
AS 
BEGIN

	SET NOCOUNT ON; 
	BEGIN TRY
		BEGIN TRAN
	
			--INSERT INTO nombreDeLaTabla(campos1,campos1,campos2,campos3,campos4,campos5)
			--VALUES (@campo1,@campo2,@campo3,@campo4,@campo5)
			
			--DECLARE @NuevoId int =  SCOPE_IDENTITY();

		COMMIT TRAN; 

		 --SELECT @NuevoId AS IdGenerado; 
	END TRY	
	BEGIN CATCH

	END CATCH;
END