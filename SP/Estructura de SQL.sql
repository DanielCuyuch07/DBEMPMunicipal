

-- BETWEEN 
-- SELECCIONA RANGOS 

		SELECT *
		FROM Empleados
		WHERE FechaNacimiento BETWEEN '1990-01-01' AND '2000-12-31'


-- IN
-- SELECCIONA SI UN VALOR ESTA DENTRO DE UNA LISTA 

		SELECT *
		FROM Empleados
		WHERE Departamento IN ('Contabilidad', 'Sistemas', 'Ventas');


-- LIKE 
-- busca patrones usando % 

		SELECT *
		FROM Empleados
		WHERE Nombre LIKE 'Ana%';

-- ORDER BY
-- Ordena por una o varias columnas 

		SELECT *
		FROM Empleados
		ORDER BY Apellido ASC, Nombre DESC;


-- HAVING 
-- Filtra los resultados despues de agrupar (se usa solo0 en group by)
		SELECT Departamento, COUNT(*) AS Total
		FROM Empleados
		GROUP BY Departamento
		HAVING COUNT(*) > 5;