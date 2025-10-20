USE DBEMPMunicipal;
GO

SET ANSI_NULLS ON;
GO

CREATE OR ALTER PROCEDURE dbo.SP_FAC_Factura_INS
(
    @clienteId         INT,
    @periodoId         INT,
    @correlativo       NVARCHAR(20),
    @fechaEmision      DATE,
    @fechaVencimiento  DATE,
    @subTotal          DECIMAL(10,3),
    @impuesto          DECIMAL(12,2),
    @total             DECIMAL(12,2),
    @saldo             DECIMAL(12,2),
    @estado            NVARCHAR(20)
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    INSERT INTO dbo.FAC_Factura
        (clienteId, periodoId, correlativo, fechaEmision, fechaVencimiento, subTotal, impuesto, total, saldo, estado)
    VALUES
        (@clienteId, @periodoId, @correlativo, @fechaEmision, @fechaVencimiento, @subTotal, @impuesto, @total, @saldo, @estado);

    RETURN 0;
END
GO
