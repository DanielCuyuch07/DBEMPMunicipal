USE DBEMPMunicipal;
GO

SET ANSI_NULLS ON
GO

CREATE PROCEDURE Sp_Estructura_DEL
(
	@IdaEliminar INT 
)
AS
BEGIN 
	SET NOCOUNT ON; 
	BEGIN TRY 
		BEGIN TRAN

		--IF NOT EXISTS(SELECT 1 FROM SeleccionDeTabla where id = @IdaEliminar)
		--BEGIN 
		--	RAISERROR('No existe el registro a eliminar',16,1)
		--	RETURN
		--END

		--DELETE FROM SeleccionDeTabla WHERE ID = @IdaEliminar;

		COMMIT TRAN 
	END TRY 
	BEGIN CATCH

	END CATCH
END 