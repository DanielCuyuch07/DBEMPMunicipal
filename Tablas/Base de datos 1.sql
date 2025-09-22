USE DBEMPMunicipal;

CREATE TABLE ADM_Departamento(
	idDepartamento	int identity(1,1) PRIMARY KEY, 
	fechaDeRegistro DATETIME NOT NULL DEFAULT GETDATE(),  
	departamento	nvarchar(50) not null,
	activo			BIT NOT NULL DEFAULT 1
)

CREATE TABLE ADM_Municipio(
	idMunicipio		int identity(1,1) primary key, 
	nombreMunicipio nvarchar(80),
	departamentoId	INT ,
	activo			BIT NOT NULL DEFAULT 1, 
	CONSTRAINT FK_ADMMunipio_ADMDepartamento FOREIGN KEY (departamentoId) REFERENCES ADM_Departamento(idDepartamento)
)

CREATE TABLE ADM_Comunidad(
	idComunidad		INT IDENTITY(1,1) PRIMARY KEY, 
	nombreColonia	nvarchar(60) not null,
	municipioId		INT, 
	activo			BIT NOT NULL DEFAULT 1,
	CONSTRAINT FK_ADM_Comunidad_ADMMunicipio FOREIGN KEY (municipioId) REFERENCES ADM_Municipio(idMunicipio)
)

CREATE TABLE ADM_CLientes(
	idCliente		int identity(1,1) primary key, 
	fechaDeRegistro DATETIME NOT NULL DEFAULT GETDATE(),  
	nombre			NVARCHAR(80) not null, 
	apellido		NVARCHAR(80) not null,
	dpi				nvarchar(13) not null, 
	nit				nvarchar(12), 
	numeroTelefono	nvarchar(8), 
	usuarioId		INT, 
	comunidadId		INT, 
	activo			BIT NOT NULL DEFAULT 1, 
	CONSTRAINT FK_ADMCliente_ADMUsuario FOREIGN KEY (usuarioId) REFERENCES ADM_Usuarios(idUsuarios),
	CONSTRAINT FK_ADMCliente_ADMComunidad FOREIGN KEY (comunidadId) references ADM_Comunidad(idComunidad)

)

CREATE TABLE SER_Servicio(
	idServicio		INT IDENTITY(1,1) PRIMARY KEY,
	clienteID		int, 
	fechaAlta		dateTime, 
	fechaBaja		datetime, 
	estado			BIT not null default 1, 
	constraint FK_SERServicio_ADMCLientes FOREIGN KEY (clienteID) REFERENCES ADM_CLientes(idCliente)
)


CREATE TABLE SER_Contador(
	idContador	INT IDENTITY(1,1) PRIMARY KEY,
	numeroSerie nvarchar(20), 
	modelo		nvarchar(40), 
	estado		BIT not null default 1, 
)


CREATE TABLE SER_ServicioContador(
	idServidorContador  INT identity(1,1) primary key, 
	servicioId			INT, 
	contadorId			INT,
	fechaInstalacion	datetime, 
	fechaRegistro		datetime NOT NULL DEFAULT GETDATE(),
	fechaDeRetiro		datetime,
	observaciones		nvarchar(100)
	constraint FK_SERServicioContador_SERServicio foreign key (servicioId) references SER_Servicio(idServicio),
	constraint FK_SERServicioContador_SER_Contador FOREIGN KEY (contadorId) REFERENCES SER_Contador(idContador)
)

CREATE TABLE FAC_Periodo (
    idPeriodo                INT IDENTITY(1,1) PRIMARY KEY,
    anio                     SMALLINT      NOT NULL,         -- ej. 2025
    mes                      TINYINT       NOT NULL,         -- 1..12
    CONSTRAINT UQ_FAC_Periodo_AnioMes UNIQUE (anio, mes),
    fechaInicio              DATE          NOT NULL,         -- ej. 2025-03-01
    fechaFin                 DATE          NOT NULL,         -- ej. 2025-03-31
    CONSTRAINT CK_FAC_Periodo_Rango CHECK (fechaFin >= fechaInicio),
    fechaGeneracion          DATE          NULL,             -- cuándo se generaron las facturas del periodo
    fechaVencimiento         DATE          NULL,             -- vencimiento de facturas emitidas en este periodo
    diasGraciaMora           TINYINT       NOT NULL DEFAULT 10,  -- del requisito (pago con 10 días)r)
    estadoPeriodo            TINYINT       NOT NULL DEFAULT 1,
    creadoEn                 DATETIME2(0)  NOT NULL DEFAULT SYSDATETIME(),
    creadoPor                INT           NULL,
    modificadoEn             DATETIME2(0)  NULL,
    modificadoPor            INT           NULL,
    cerradoEn                DATETIME2(0)  NULL,
    cerradoPor               INT           NULL,
    CONSTRAINT CK_FAC_Periodo_Mes CHECK (mes BETWEEN 1 AND 12)
);

CREATE TABLE LEC_Lectura(
    idLectura            INT IDENTITY(1,1) PRIMARY KEY,
    servicioId           INT           NOT NULL,
    periodoId            INT           NOT NULL,  -- FK a FAC_Periodo (mes/año)
    servicioContadorId   INT           NOT NULL,  -- FK al historial del medidor
    fechaLectura         DATETIME2(0)  NOT NULL,
    lecturaAnterior      DECIMAL(12,2) NOT NULL,
    lecturaActual        DECIMAL(12,2) NOT NULL,
    consumoCalculado     DECIMAL(12,2) NULL,      -- o lo calculas al cerrar
    esEstimada           BIT           NOT NULL DEFAULT 0,
    estadoLectura        TINYINT       NOT NULL DEFAULT 1,  -- 1=Registrada,2=Validada,3=Cerrada,4=Anulada
    observacion          NVARCHAR(200) NULL,
    creadoPor            INT           NULL,
    creadoEn             DATETIME2(0)  NOT NULL DEFAULT SYSDATETIME(),
    modificadoPor        INT           NULL,
    modificadoEn         DATETIME2(0)  NULL,
    rv                   ROWVERSION,

    CONSTRAINT FK_LEC_Servicio
        FOREIGN KEY (servicioId) REFERENCES SER_Servicio(idServicio),

    CONSTRAINT FK_LEC_Periodo
        FOREIGN KEY (periodoId) REFERENCES FAC_Periodo(idPeriodo),

    CONSTRAINT FK_LEC_ServicioContador
        FOREIGN KEY (servicioContadorId) REFERENCES SER_ServicioContador(idServidorContador),

    CONSTRAINT UQ_LEC_Servicio_Periodo UNIQUE (servicioId, periodoId),

    CONSTRAINT CK_LEC_Lecturas_Orden CHECK (lecturaActual >= lecturaAnterior)
);










