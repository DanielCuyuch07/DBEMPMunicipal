CREATE OR ALTER PROCEDURE dbo.SP_FAC_FacturaDetalle_INS
(
    @facturaId      INT,
    @conceptoId     INT,
    @descripcion    NVARCHAR(100),
    @cantidad       DECIMAL(12,3),
    @precioUnit     DECIMAL(12,4),
    @idFacturaDetalle INT OUTPUT,
    @subTotal         DECIMAL(12,2) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    -- Normalizaciones simples
    DECLARE @desc NVARCHAR(100) = LTRIM(RTRIM(@descripcion));

    -- Validaciones mínimas (ajusta a tu política: permitir 0 o no)
    IF (@facturaId IS NULL OR @facturaId <= 0)      RETURN 10;   -- facturaId inválido
    IF (@conceptoId IS NULL OR @conceptoId <= 0)    RETURN 11;   -- conceptoId inválido
    IF (@desc IS NULL OR @desc = N'')               RETURN 12;   -- descripción vacía
    IF (@cantidad IS NULL OR @cantidad < 0)         RETURN 13;   -- cantidad inválida
    IF (@precioUnit IS NULL OR @precioUnit < 0)     RETURN 14;   -- precio inválido

    -- Verificar existencia de FK (evita error por FK y te da códigos claros)
    IF NOT EXISTS (SELECT 1 FROM dbo.FAC_Factura WHERE idFactura = @facturaId)
        RETURN 20; -- factura no existe

    IF NOT EXISTS (SELECT 1 FROM dbo.CAT_Concepto WHERE idConcepto = @conceptoId)
        RETURN 21; -- concepto no existe

    -- Insert
    INSERT INTO dbo.FAC_FacturaDetalle (facturaId, conceptoId, descripcion, cantidad, precioUnit)
    VALUES (@facturaId, @conceptoId, @desc, @cantidad, @precioUnit);

    -- OUTPUTs
    SET @idFacturaDetalle = CAST(SCOPE_IDENTITY() AS INT);
    -- Como subtotal es columna calculada, puedes devolverlo calculándolo igual:
    SET @subTotal = ROUND(@cantidad * @precioUnit, 2);

    RETURN 0; -- éxito
END
GO
