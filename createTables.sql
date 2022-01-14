-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-10-03 11:30:27.972

-- tables
-- Table: Administrador
CREATE TABLE Administrador (
    DNI varchar(9)  NOT NULL,
    turno char(1)  NOT NULL,
    horas_extra int  NOT NULL,
    CONSTRAINT Administrador_pk PRIMARY KEY (DNI)
);

-- Table: Caracteristicas
CREATE TABLE Caracteristicas (
    codigoM varchar(20)  NOT NULL,
    caracteristica varchar(40)  NOT NULL,
    CONSTRAINT Caracteristicas_pk PRIMARY KEY (codigoM)
);

-- Table: Estado
CREATE TYPE nombre_estado AS ENUM (
 'NUEVA',
   'REUTILIZABLE',
   'OBSOLETA'
);;

CREATE TABLE Estado (
    codigo varchar(9)  NOT NULL,
    f_ini date	NOT NULL,
    f_fin date	NULL,
    nombre nombre_estado  NOT NULL,
    CONSTRAINT Estado_pk PRIMARY KEY (codigo,f_ini)
);

-- Table: Formada
CREATE TABLE Formada (
    cod_maquina varchar(20)  NOT NULL,
    cod_pieza varchar(9)  NOT NULL,
    fecha date  NOT NULL,
    CONSTRAINT Formada_pk PRIMARY KEY (cod_maquina,cod_pieza)
);

-- Table: Incompatible_maquina
CREATE TABLE Incompatible_maquina (
    cod_maquina varchar(20)  NOT NULL,
    cod_pieza varchar(9)  NOT NULL,
    CONSTRAINT Incompatible_maquina_pk PRIMARY KEY (cod_maquina,cod_pieza)
);

-- Table: Incompatible_pieza
CREATE TABLE Incompatible_pieza (
    codigoP varchar(9)  NOT NULL,
    codigoP_2 varchar(9)  NOT NULL,
    CONSTRAINT CHK_equals CHECK (codigoP != codigoP_2) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT Incompatible_pieza_pk PRIMARY KEY (codigoP,codigoP_2)
);

-- Table: Linea_produccion
CREATE TABLE Linea_produccion (
    codigo varchar(20)  NOT NULL,
    nombre varchar(20)  NOT NULL,
    sector int  NOT NULL,
    prod_semanal int  NOT NULL,
    planta_id varchar(20)  NOT NULL,
    CONSTRAINT plantaId_nombre UNIQUE (nombre, planta_id) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT Linea_produccion_pk PRIMARY KEY (codigo)
);

-- Table: Maneja
CREATE TYPE turno AS ENUM (
    'M',
   'T'
);

CREATE TABLE Maneja (
    operario_DNI varchar(9)  NOT NULL,
    cod_maquina varchar(20)  NOT NULL,
    turno turno  NOT NULL,
    f_ini date	NOT NULL,
    horas int  NOT NULL,
    f_fin date	NULL,
    CONSTRAINT fechas CHECK (f_ini < f_fin) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT Maneja_pk PRIMARY KEY (cod_maquina,turno,f_ini)
);

-- Table: Mantiene_Pieza
CREATE TABLE Mantiene_Pieza (
    DNI varchar(9)  NOT NULL,
    cod_pieza varchar(9)  NOT NULL,
    CONSTRAINT Mantiene_Pieza_pk PRIMARY KEY (DNI,cod_pieza)
);

-- Table: Mantiene_maquina
CREATE TABLE Mantiene_maquina (
    codigo varchar(20)  NOT NULL,
    cod_tecnico varchar(9)  NOT NULL,
    CONSTRAINT Mantiene_maquina_pk PRIMARY KEY (codigo,cod_tecnico)
);

-- Table: Maquina
CREATE TABLE Maquina (
    codigo varchar(20)  NOT NULL,
    nivel varchar(1)  NOT NULL,
    f_compra date  NOT NULL,
    nombre varchar(20)  NOT NULL,
    posicion_linea int  NOT NULL,
    codlinea	VARCHAR(20)	NOT NULL,
    CONSTRAINT Maquina_pk PRIMARY KEY (codigo)
);

-- Table: Modelo
CREATE TABLE Modelo (
    codigo varchar(20)  NOT NULL,
    tipo int  NOT NULL,
    caracteristica varchar(40)  NOT NULL,
    codigo_linea_produccion varchar(20)  NOT NULL,
    CONSTRAINT Modelo_pk PRIMARY KEY (codigo)
);

-- Table: Movil
CREATE TABLE Movil (
    imei int  NOT NULL,
    nSerie int  NOT NULL,
    color varchar(40)  NOT NULL,
    cod_modelo varchar(20)  NOT NULL,
    CONSTRAINT nSerie UNIQUE (nSerie) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT Movil_pk PRIMARY KEY (imei)
);

-- Table: Nivel
CREATE TABLE Nivel (
    cod_nivel varchar(1)  NOT NULL,
    nombre varchar(10)  NOT NULL,
    CONSTRAINT Nivel_pk PRIMARY KEY (cod_nivel)
);

-- Table: Operario
CREATE TABLE Operario (
    DNI varchar(9)  NOT NULL,
    antiguedad int  NOT NULL,
    horas_max int  NOT NULL,
    nivel varchar(1)  NOT NULL,
    fecha_responsable date  NULL,
    cod_linea_responsable varchar(20)  NULL,
    CONSTRAINT Operario_pk PRIMARY KEY (DNI)
);

-- Table: Otorga
CREATE TABLE Otorga (
    cod_titulacion varchar(9)  NOT NULL,
    cod_nivel varchar(1)  NOT NULL,
    CONSTRAINT Otorga_pk PRIMARY KEY (cod_nivel,cod_titulacion)
);

-- Table: Pieza
CREATE TABLE Pieza (
    codigo varchar(9)  NOT NULL,
    f_compra date  NOT NULL,
    CONSTRAINT Pieza_pk PRIMARY KEY (codigo)
);

-- Table: Planta
CREATE TABLE Planta (
    id varchar(20)  NOT NULL,
    nombre varchar(50)  NOT NULL,
    estado boolean  NOT NULL,
    calle varchar(20)  NOT NULL,
    numero int  NOT NULL,
    cod_postal int  NOT NULL,
    Trabajador_DNI varchar(9)  NOT NULL,
    CONSTRAINT Planta_pk PRIMARY KEY (id)
);

-- Table: Procesado
CREATE TABLE Procesado (
    imei int  NOT NULL,
    cod_maquina varchar(20)  NOT NULL,
    fecha date  NOT NULL,
    CONSTRAINT Procesado_pk PRIMARY KEY (imei,cod_maquina)
);

-- Table: Tecnico_especialista
CREATE TABLE Tecnico_especialista (
    DNI varchar(9)  NOT NULL,
    horas_experiencia int  NOT NULL,
    CONSTRAINT Tecnico_especialista_pk PRIMARY KEY (DNI)
);

-- Table: Tecnico_mantenimiento
CREATE TABLE Tecnico_mantenimiento (
    DNI varchar(9)  NOT NULL,
    CONSTRAINT Tecnico_mantenimiento_pk PRIMARY KEY (DNI)
);

-- Table: Telefono
CREATE TABLE Telefono (
    DNI varchar(9)  NOT NULL,
    telefono int  NOT NULL,
    CONSTRAINT Telefono_pk PRIMARY KEY (telefono,DNI)
);

-- Table: Tiene
CREATE TABLE Tiene (
    DNI varchar(9)  NOT NULL,
    cod_titulacion varchar(9)  NOT NULL,
    CONSTRAINT Tiene_pk PRIMARY KEY (DNI,cod_titulacion)
);

-- Table: Titulacion
CREATE TABLE Titulacion (
    nombre varchar(20)  NOT NULL,
    cod_titulacion varchar(9)  NOT NULL,
    CONSTRAINT Titulacion_pk PRIMARY KEY (cod_titulacion)
);

-- Table: Trabajador
CREATE TABLE Trabajador (
    DNI varchar(9)  NOT NULL,
    nombre varchar(20)  NOT NULL,
    apellidos varchar(40)  NOT NULL,
    cod_postal varchar(5)  NOT NULL,
    calle varchar(50)  NOT NULL,
    numero int  NOT NULL,
    correo_e varchar(20)  NOT NULL,
    salario int  NOT NULL,
    CONSTRAINT Trabajador_pk PRIMARY KEY (DNI)
);

-- Table: mayor_igual_que
CREATE TABLE mayor_igual_que (
    cod_nivel varchar(1)  NOT NULL,
    cod_nivel_2 varchar(1)  NOT NULL,
    CONSTRAINT mayor_igual_que_pk PRIMARY KEY (cod_nivel,cod_nivel_2)
);

-- foreign keys
-- Reference: Administrador_Trabajador (table: Administrador)
ALTER TABLE Administrador ADD CONSTRAINT Administrador_Trabajador
    FOREIGN KEY (DNI)
    REFERENCES Trabajador (DNI)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Caracteristicas_Modelo (table: Caracteristicas)
ALTER TABLE Caracteristicas ADD CONSTRAINT Caracteristicas_Modelo
    FOREIGN KEY (codigoM)
    REFERENCES Modelo (codigo)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Estado_Pieza (table: Estado)
ALTER TABLE Estado ADD CONSTRAINT Estado_Pieza
    FOREIGN KEY (codigo)
    REFERENCES Pieza (codigo)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Formada_Maquina (table: Formada)
ALTER TABLE Formada ADD CONSTRAINT Formada_Maquina
    FOREIGN KEY (cod_maquina)
    REFERENCES Maquina (codigo)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Formada_Pieza (table: Formada)
ALTER TABLE Formada ADD CONSTRAINT Formada_Pieza
    FOREIGN KEY (cod_pieza)
    REFERENCES Pieza (codigo)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Incompatible_maquina_Maquina (table: Incompatible_maquina)
ALTER TABLE Incompatible_maquina ADD CONSTRAINT Incompatible_maquina_Maquina
    FOREIGN KEY (cod_maquina)
    REFERENCES Maquina (codigo)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Incompatible_maquina_Pieza (table: Incompatible_maquina)
ALTER TABLE Incompatible_maquina ADD CONSTRAINT Incompatible_maquina_Pieza
    FOREIGN KEY (cod_pieza)
    REFERENCES Pieza (codigo)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Incompatible_pieza_Pieza (table: Incompatible_pieza)
ALTER TABLE Incompatible_pieza ADD CONSTRAINT Incompatible_pieza_Pieza
    FOREIGN KEY (codigoP)
    REFERENCES Pieza (codigo)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Incompatible_pieza_Pieza_2 (table: Incompatible_pieza)
ALTER TABLE Incompatible_pieza ADD CONSTRAINT Incompatible_pieza_Pieza_2
    FOREIGN KEY (codigoP_2)
    REFERENCES Pieza (codigo)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Linea_produccion_Modelo (table: Modelo)
ALTER TABLE Modelo ADD CONSTRAINT Linea_produccion_Modelo
    FOREIGN KEY (codigo_linea_produccion)
    REFERENCES Linea_produccion (codigo)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Linea_produccion_Planta (table: Linea_produccion)
ALTER TABLE Linea_produccion ADD CONSTRAINT Linea_produccion_Planta
    FOREIGN KEY (planta_id)
    REFERENCES Planta (id)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Maneja_Maquina (table: Maneja)
ALTER TABLE Maneja ADD CONSTRAINT Maneja_Maquina
    FOREIGN KEY (cod_maquina)
    REFERENCES Maquina (codigo)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Maneja_Operario (table: Maneja)
ALTER TABLE Maneja ADD CONSTRAINT Maneja_Operario
    FOREIGN KEY (operario_DNI)
    REFERENCES Operario (DNI)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Mantiene_Pieza_Tecnico_especialista (table: Mantiene_Pieza)
ALTER TABLE Mantiene_Pieza ADD CONSTRAINT Mantiene_Pieza_Tecnico_especialista
    FOREIGN KEY (DNI)
    REFERENCES Tecnico_especialista (DNI)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Mantiene_maquina_Maquina (table: Mantiene_maquina)
ALTER TABLE Mantiene_maquina ADD CONSTRAINT Mantiene_maquina_Maquina
    FOREIGN KEY (codigo)
    REFERENCES Maquina (codigo)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Mantiene_maquina_Tecnico_mantenimiento (table: Mantiene_maquina)
ALTER TABLE Mantiene_maquina ADD CONSTRAINT Mantiene_maquina_Tecnico_mantenimiento
    FOREIGN KEY (cod_tecnico)
    REFERENCES Tecnico_mantenimiento (DNI)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Maquina_Procesado (table: Procesado)
ALTER TABLE Procesado ADD CONSTRAINT Maquina_Procesado
    FOREIGN KEY (cod_maquina)
    REFERENCES Maquina (codigo)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Movil_Modelo (table: Movil)
ALTER TABLE Movil ADD CONSTRAINT Movil_Modelo
    FOREIGN KEY (cod_modelo)
    REFERENCES Modelo (codigo)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Nivel_Maquina (table: Maquina)
ALTER TABLE Maquina ADD CONSTRAINT Nivel_Maquina
    FOREIGN KEY (nivel)
    REFERENCES Nivel (cod_nivel)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Nivel_Operario (table: Operario)
ALTER TABLE Operario ADD CONSTRAINT Nivel_Operario
    FOREIGN KEY (nivel)
    REFERENCES Nivel (cod_nivel)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Operario_Trabajador (table: Operario)
ALTER TABLE Operario ADD CONSTRAINT Operario_Trabajador
    FOREIGN KEY (DNI)
    REFERENCES Trabajador (DNI)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Pieza_Mantiene_Pieza (table: Mantiene_Pieza)
ALTER TABLE Mantiene_Pieza ADD CONSTRAINT Pieza_Mantiene_Pieza
    FOREIGN KEY (cod_pieza)
    REFERENCES Pieza (codigo)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Planta_Trabajador (table: Planta)
ALTER TABLE Planta ADD CONSTRAINT Planta_Trabajador
    FOREIGN KEY (Trabajador_DNI)
    REFERENCES Trabajador (DNI)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Procesado_Movil (table: Procesado)
ALTER TABLE Procesado ADD CONSTRAINT Procesado_Movil
    FOREIGN KEY (imei)
    REFERENCES Movil (imei)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Responsable (table: Operario)
ALTER TABLE Operario ADD CONSTRAINT Responsable
    FOREIGN KEY (cod_linea_responsable)
    REFERENCES Linea_produccion (codigo)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Table_22_Nivel (table: Otorga)
ALTER TABLE Otorga ADD CONSTRAINT Table_22_Nivel
    FOREIGN KEY (cod_nivel)
    REFERENCES Nivel (cod_nivel)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Table_22_Titulacion (table: Otorga)
ALTER TABLE Otorga ADD CONSTRAINT Table_22_Titulacion
    FOREIGN KEY (cod_titulacion)
    REFERENCES Titulacion (cod_titulacion)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Tecnico_especialista_Tecnico_mantenimiento (table: Tecnico_especialista)
ALTER TABLE Tecnico_especialista ADD CONSTRAINT Tecnico_especialista_Tecnico_mantenimiento
    FOREIGN KEY (DNI)
    REFERENCES Tecnico_mantenimiento (DNI)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Tecnico_mantenimiento_Trabajador (table: Tecnico_mantenimiento)
ALTER TABLE Tecnico_mantenimiento ADD CONSTRAINT Tecnico_mantenimiento_Trabajador
    FOREIGN KEY (DNI)
    REFERENCES Trabajador (DNI)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Tiene (table: Telefono)
ALTER TABLE Telefono ADD CONSTRAINT Tiene
    FOREIGN KEY (DNI)
    REFERENCES Trabajador (DNI)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Tiene_Tecnico_mantenimiento (table: Tiene)
ALTER TABLE Tiene ADD CONSTRAINT Tiene_Tecnico_mantenimiento
    FOREIGN KEY (DNI)
    REFERENCES Tecnico_mantenimiento (DNI)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Titulacion_Tiene (table: Tiene)
ALTER TABLE Tiene ADD CONSTRAINT Titulacion_Tiene
    FOREIGN KEY (cod_titulacion)
    REFERENCES Titulacion (cod_titulacion)
    ON DELETE  RESTRICT 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: mayor_igual_que_Nivel (table: mayor_igual_que)
ALTER TABLE mayor_igual_que ADD CONSTRAINT mayor_igual_que_Nivel
    FOREIGN KEY (cod_nivel_2)
    REFERENCES Nivel (cod_nivel)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: mayor_igual_que_Nivel_2 (table: mayor_igual_que)
ALTER TABLE mayor_igual_que ADD CONSTRAINT mayor_igual_que_Nivel_2
    FOREIGN KEY (cod_nivel)
    REFERENCES Nivel (cod_nivel)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE maquina ADD CONSTRAINT codline_maquina
    FOREIGN KEY (codlinea)
    REFERENCES linea_produccion (codigo)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;


-- End of file.

