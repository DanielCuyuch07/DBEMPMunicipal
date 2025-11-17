USE DBEMPMunicipal;
go


SET ANSI_NULLS ON 
GO 


CREATE PROCEDURE SP_Estructura_UPD
(
	@IdaEditar	INT 
)
AS
BEGIN 
	SET NOCOUNT ON; 
	BEGIN TRY 
		BEGIN TRAN 

		-- VALIDAMOS QUE EL REGISTRO EXISTA 
		--IF NOT EXISTS(SELECT 1 FROM TablaEditar where id = @IdaEditar)
		--BEGIN 
		--	RAISERROR('No existe registro con Id = %d en TablaEditar.', 16, 1)
		--	ROLLBACK TRAN;
  --          RETURN;
		--END 

		---- 
		--UPDATE SeleccionDeTabla 
		--SET 
		--	Campo1 = @Campo1, 
		--	Campo2 = @Campo2 
		--where id = @IdaEditar

		COMMIT TRAN 
	END TRY
	BEGIN CATCH

	END CATCH
END 