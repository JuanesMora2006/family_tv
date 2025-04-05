CREATE TABLE Tutor (
    documento VARCHAR(20) PRIMARY KEY,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    fecha_nacimiento DATE NOT NULL,
    activo BOOLEAN NOT NULL,
    tipo_documento ENUM('CC', 'CE', 'TI', 'RC', 'PT', 'PP') NOT NULL
);

CREATE TABLE Usuario (
    documento VARCHAR(20) PRIMARY KEY,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    fecha_nacimiento DATE NOT NULL,
    activo BOOLEAN NOT NULL,
    tipo_documento ENUM('CC', 'CE', 'TI', 'RC', 'PT', 'PP') NOT NULL,
    tutor_documento VARCHAR(20) NOT NULL,
    relacion_con_tutor VARCHAR(20) NOT NULL, -- "Padre", "Madre", "Tutor Legal", etc.
    FOREIGN KEY (tutor_documento) REFERENCES Tutor(documento)
);

CREATE TABLE Usuario_Credenciales (
    usuario_id VARCHAR(20) PRIMARY KEY, -- Puede ser el documento del usuario o un ID único
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL, -- Almacenar contraseñas hasheadas (por ejemplo, con bcrypt)
    tipo_usuario ENUM('Tutor', 'Usuario') NOT NULL, -- Indica si es tutor o usuario
    FOREIGN KEY (usuario_id) REFERENCES Usuario(documento) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES Tutor(documento) ON DELETE CASCADE
);

CREATE TABLE Reporte (
    reporte_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_reportado VARCHAR(20) NOT NULL,
    usuario_reporta VARCHAR(20) NOT NULL,
    fecha_reporte DATETIME NOT NULL,
    descripcion TEXT NOT NULL,
    estado ENUM('Pendiente', 'En Proceso', 'Resuelto') NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (usuario_reportado) REFERENCES Usuario(documento),
    FOREIGN KEY (usuario_reporta) REFERENCES Usuario(documento)
);

CREATE TABLE Alerta (
    alerta_id INT AUTO_INCREMENT PRIMARY KEY,
    reporte_id INT NOT NULL,
    tutor_documento VARCHAR(20) NOT NULL,
    fecha_alerta DATETIME NOT NULL,
    mensaje TEXT NOT NULL,
    leido BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (reporte_id) REFERENCES Reporte(reporte_id),
    FOREIGN KEY (tutor_documento) REFERENCES Tutor(documento)
);

CREATE TABLE Amistad (
    usuario1_documento VARCHAR(20) NOT NULL,
    usuario2_documento VARCHAR(20) NOT NULL,
    fecha_amistad DATETIME NOT NULL,
    estado ENUM('Pendiente', 'Aceptada', 'Rechazada') NOT NULL DEFAULT 'Pendiente',
    PRIMARY KEY (usuario1_documento, usuario2_documento),
    FOREIGN KEY (usuario1_documento) REFERENCES Usuario(documento),
    FOREIGN KEY (usuario2_documento) REFERENCES Usuario(documento)
);
