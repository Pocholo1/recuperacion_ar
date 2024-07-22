CREATE TABLE Profesor (
    P CHAR(2) PRIMARY KEY,
    Nomp VARCHAR(30),
    Desp INT
);

CREATE TABLE Asistencia (
    P CHAR(2),
    A CHAR(2),
    C CHAR(2),
    PRIMARY KEY (P, A, C),
    FOREIGN KEY (P) REFERENCES Profesor(P)
);

CREATE TABLE Asignatura (
    A CHAR(2) PRIMARY KEY,
    Noma VARCHAR(30)
);

CREATE TABLE Clases (
    C CHAR(2) PRIMARY KEY,
    Piso INT,
    Bloque INT
);

-- Tabla Profesor
INSERT INTO Profesor (P, Nomp, Desp) VALUES
('P1', 'RAUL', 105),
('P2', 'SIMON', 103),
('P3', 'ROSA', 107),
('P4', 'ADRIAN', 107);

-- Tabla Asistencia
INSERT INTO Asistencia (P, A, C) VALUES
('P1', 'A1', 'C1'),
('P2', 'A2', 'C3'),
('P3', 'A3', 'C1'),
('P4', 'A4', 'C2'),
('P1', 'A3', 'C3'),
('P2', 'A4', 'C1'),
('P3', 'A2', 'C2'),
('P4', 'A1', 'C3'),
('P2', 'A1', 'C2'),
('P3', 'A4', 'C3');

-- Tabla Asignatura
INSERT INTO Asignatura (A, Noma) VALUES
('A1', 'FISICA'),
('A2', 'QUIMICA'),
('A3', 'DIBUJO'),
('A4', 'MATEMAT.');

-- Tabla Clases
INSERT INTO Clases (C, Piso, Bloque) VALUES
('C1', 1, 1),
('C2', 1, 2),
('C3', 2, 1);

SELECT * FROM Clases;

SELECT * FROM Clases
WHERE Piso = 1;

SELECT Profesor.P
FROM Profesor
JOIN Asistencia ON Profesor.P = Asistencia.P
WHERE Asistencia.C = 'C1';

SELECT Clases.Piso, Clases.Bloque
FROM Clases
JOIN Asistencia ON Clases.C = Asistencia.C
WHERE Asistencia.P = 'P1';

SELECT Profesor.P
FROM Profesor
JOIN Asistencia ON Profesor.P = Asistencia.P
JOIN Asignatura ON Asistencia.A = Asignatura.A
WHERE Asistencia.C = 'C1' AND Asignatura.Noma = 'FISICA';

SELECT DISTINCT P
FROM Asistencia
WHERE C = 'C1'
INTERSECT
SELECT DISTINCT P
FROM Asistencia
WHERE C = 'C2';

SELECT DISTINCT Profesor.Nomp
FROM Profesor
JOIN Asistencia ON Profesor.P = Asistencia.P
WHERE Asistencia.C = 'C1'
INTERSECT
SELECT DISTINCT Profesor.Nomp
FROM Profesor
JOIN Asistencia ON Profesor.P = Asistencia.P
WHERE Asistencia.C = 'C2';

SELECT DISTINCT Profesor.Nomp
FROM Profesor
JOIN Asistencia ON Profesor.P = Asistencia.P
JOIN Clases ON Asistencia.C = Clases.C
WHERE Clases.Bloque = 1
AND Profesor.P NOT IN (
    SELECT Profesor.P
    FROM Profesor
    JOIN Asistencia ON Profesor.P = Asistencia.P
    JOIN Clases ON Asistencia.C = Clases.C
    WHERE Clases.Bloque <> 1
);

SELECT DISTINCT Profesor.Nomp
FROM Profesor
WHERE NOT EXISTS (
    SELECT Clases.C
    FROM Clases
    WHERE Clases.Bloque = 1
    AND Clases.C NOT IN (
        SELECT Asistencia.C
        FROM Asistencia
        WHERE Asistencia.P = Profesor.P
    )
);

SELECT Clases.C
FROM Clases
WHERE NOT EXISTS (
    SELECT Asignatura.A
    FROM Asignatura
    WHERE Asignatura.A NOT IN (
        SELECT Asistencia.A
        FROM Asistencia
        WHERE Asistencia.C = Clases.C
    )
);


