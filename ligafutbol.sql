CREATE DATABASE LigaFutbol;
USE LigaFutbol;

CREATE TABLE Equipos (
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50),
    estadio VARCHAR(50)
);

-- Insertar algunos equipos
INSERT INTO Equipos (nombre, ciudad, estadio)
VALUES 
('Real Madrid', 'Madrid', 'Santiago Bernabéu'),
('Barcelona', 'Barcelona', 'Camp Nou'),
('Atlético de Madrid', 'Madrid', 'Wanda Metropolitano'),
('Sevilla', 'Sevilla', 'Ramón Sánchez-Pizjuán');
CREATE TABLE Partidos (
    id_partido INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    equipo_local INT NOT NULL,
    equipo_visitante INT NOT NULL,
    goles_local INT DEFAULT 0,
    goles_visitante INT DEFAULT 0,
    FOREIGN KEY (equipo_local) REFERENCES Equipos(id_equipo),
    FOREIGN KEY (equipo_visitante) REFERENCES Equipos(id_equipo)
);

-- Insertar algunos partidos
INSERT INTO Partidos (fecha, equipo_local, equipo_visitante, goles_local, goles_visitante)
VALUES 
('2024-11-01', 1, 2, 2, 1), -- Real Madrid 2 - 1 Barcelona
('2024-11-05', 3, 4, 1, 1), -- Atlético de Madrid 1 - 1 Sevilla
('2024-11-10', 2, 3, 0, 2), -- Barcelona 0 - 2 Atlético de Madrid
('2024-11-15', 4, 1, 3, 3); -- Sevilla 3 - 3 Real Madrid
SELECT 
    e.id_equipo AS ID,
    e.nombre AS Equipo,
    COUNT(CASE WHEN p.equipo_local = e.id_equipo THEN 1 
               WHEN p.equipo_visitante = e.id_equipo THEN 1 END) AS Partidos_Jugados,
    SUM(CASE WHEN p.equipo_local = e.id_equipo AND p.goles_local > p.goles_visitante THEN 3
             WHEN p.equipo_visitante = e.id_equipo AND p.goles_visitante > p.goles_local THEN 3
             WHEN (p.equipo_local = e.id_equipo OR p.equipo_visitante = e.id_equipo) AND p.goles_local = p.goles_visitante THEN 1
             ELSE 0 END) AS Puntos,
    SUM(CASE WHEN p.equipo_local = e.id_equipo THEN p.goles_local
             WHEN p.equipo_visitante = e.id_equipo THEN p.goles_visitante END) AS Goles_Favor,
    SUM(CASE WHEN p.equipo_local = e.id_equipo THEN p.goles_visitante
             WHEN p.equipo_visitante = e.id_equipo THEN p.goles_local END) AS Goles_Contra,
    (SUM(CASE WHEN p.equipo_local = e.id_equipo THEN p.goles_local
              WHEN p.equipo_visitante = e.id_equipo THEN p.goles_visitante END) -
     SUM(CASE WHEN p.equipo_local = e.id_equipo THEN p.goles_visitante
              WHEN p.equipo_visitante = e.id_equipo THEN p.goles_local END)) AS Diferencia_Goles
FROM Equipos e
LEFT JOIN Partidos p ON e.id_equipo = p.equipo_local OR e.id_equipo = p.equipo_visitante
GROUP BY e.id_equipo
ORDER BY Puntos DESC, Diferencia_Goles DESC, Goles_Favor DESC;
