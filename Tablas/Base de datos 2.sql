use DBEMPMunicipal; 

-- Proposito : Catalogo general de los tipos de cobros que pueden aparecer en una factura (agua,alcantarillado,mora,reconexion)

CREATE TABLE CAT_Concepto(
	idConcepto INT IDENTITY(1,1) primary key, 
	nombre NVARCHAR(30) NOT NULL,
	tipo nvarchar(30) not null, 
	activo BIT NOT NULL DEFAULT(1), 
);

-- Proposito : Define el conjunto de precios que aplican a ciertos servicios o tipos de cliente

CREATE TABLE FAC_Tarifa(
	idTarifa INT IDENTITY(1,1) PRIMARY KEY, 
	nombre NVARCHAR(50) not null, 
	activo BIT NOT NULL DEFAULT(1)
);

-- Proposito : Define los rangos de consumo (por m3) y su precio unitario dentro de una tarifa 

CREATE TABLE FAC_TarifaRango(
	idRango INT IDENTITY(1,1) PRIMARY KEY , 
	desdeM3 DECIMAL(10,3) NOT NULL, 
	hastaM3 DECIMAL(10,3) NOT NULL, 
	precioM3 DECIMAL(12,2) NOT NULL, 
	tarifaId INT, 
	CONSTRAINT FK_FAC_TarifaRango_ foreign key (tarifaId) references FAC_Tarifa(idTarifa)
);

CREATE TABLE FAC_Factura(
	idFactura INT IDENTITY(1,1) PRIMARY KEY, 
	clienteId int, 
	periodoId int, 
	correlativo NVARCHAR(20) NOT NULL, 
	fechaEmision DATE NOT NULL DEFAULT (GETDATE()),
	fechaVencimiento DATE NOT NULL, 
	subTotal DECIMAL(12,2) NOT NULL DEFAULT(0),
	impuesto DECIMAL(12,2) NOT NULL DEFAULT(0),
	total decimal(12,2) NOT NULL DEFAULT(0),
	saldo decimal(12,2) not null default(0),
	estado nvarchar(20) not null,
	CONSTRAINT FK_FACFactura_ADMClientes FOREIGN KEY (clienteId) REFERENCES ADM_CLientes(idCliente),
	CONSTRAINT FK_FACFactura_FACPeriodo	 FOREIGN KEY (periodoId) REFERENCES FAC_Periodo(idPeriodo)
);

CREATE TABLE FAC_FacturaDetalle(
	idFacturaDetalle INT IDENTITY(1,1) PRIMARY KEY,
	facturaId INT NOT NULL, 
	conceptoId INT NOT NULL, 
	descripcion NVARCHAR(100) NOT NULL, 
	cantidad DECIMAL(12,3) NOT NULL, 
	precioUnit DECIMAL(12,4) NOT NULL, 
	subTotal AS (ROUND(cantidad * precioUnit, 2)) PERSISTED,
	CONSTRAINT FK_FACFacturaDetalle_Factura FOREIGN KEY (facturaId) REFERENCES FAC_Factura(idFactura),
	CONSTRAINT FK_FACFacturaDetalle_Concepto FOREIGN KEY (conceptoId) REFERENCES CAT_Concepto(idConcepto)
);

