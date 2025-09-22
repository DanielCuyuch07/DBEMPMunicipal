USE DBEMPMunicipal;
GO

SET ANSI_NULLS ON;
GO

CREATE OR ALTER PROCEDURE dbo.SP_ADMCLientes_INS
(
    @nombre           NVARCHAR(80),
    @apellido         NVARCHAR(80),
    @dpi              NVARCHAR(13),   -- recomendado: 13
    @nit              NVARCHAR(12) = NULL,   -- recomendado: 12
    @numeroTelefono   NVARCHAR(15) = NULL,   -- recomendado: 8..15
    @usuarioId        INT,
    @comunidadId      INT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    -- Normalizar entradas clave
    DECLARE @dpiNorm NVARCHAR(13) = LTRIM(RTRIM(@dpi));
    DECLARE @nitNorm NVARCHAR(12) = NULLIF(LTRIM(RTRIM(@nit)), '');
    DECLARE @idCliente INT;  -- ¡sin coma!

    -- 1) Validar FKs correctas
    IF NOT EXISTS (SELECT 1 FROM dbo.ADM_Usuarios  WHERE idUsuarios  = @usuarioId)
    BEGIN
        RAISERROR('EL USUARIO NO EXISTE EN BASE DE DATOS. INTENTELO DE NUEVO.', 11, 1);
        RETURN 10;
    END

    IF NOT EXISTS (SELECT 1 FROM dbo.ADM_Comunidad WHERE idComunidad = @comunidadId)
    BEGIN
        RAISERROR('LA COMUNIDAD NO EXISTE EN BASE DE DATOS. INTENTELO DE NUEVO.', 11, 1);
        RETURN 11;
    END

    -- 2) Evitar duplicados por DPI/NIT
    IF EXISTS (SELECT 1 FROM dbo.ADM_Clientes WHERE dpi = @dpiNorm)
    BEGIN
        RAISERROR('Ya existe un cliente con ese DPI.', 11, 1);
        RETURN 20;
    END

    IF @nitNorm IS NOT NULL
       AND EXISTS (SELECT 1 FROM dbo.ADM_Clientes WHERE nit = @nitNorm)
    BEGIN
        RAISERROR('Ya existe un cliente con ese NIT.', 11, 1);
        RETURN 21;
    END

    BEGIN TRAN;

        INSERT dbo.ADM_Clientes
            (fechaDeRegistro, nombre, apellido, dpi, nit, numeroTelefono, usuarioId, comunidadId, activo)
        VALUES
            (SYSDATETIME(), @nombre, @apellido, @dpiNorm, @nitNorm,
             NULLIF(LTRIM(RTRIM(@numeroTelefono)), ''), @usuarioId, @comunidadId, 1);

        SET @idCliente = SCOPE_IDENTITY();

    COMMIT TRAN;

    RETURN 0;
END
GO
