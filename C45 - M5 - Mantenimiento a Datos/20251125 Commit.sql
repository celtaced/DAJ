-- 1. Consulta inicial: revisar el contenido actual de la tabla
SELECT terminal, tipo, nombre, departamento, ubicacion, direccion
FROM dim_terminales;

-- 2. Inserción de un nuevo registro (ejemplo de alta de terminal)
INSERT INTO dim_terminales (terminal, tipo, nombre, departamento, ubicacion, direccion)
VALUES ('AT26', 'NORMAL', 'FARMACIA SONSONATE II', 'SV-SO', 'FARMACIA', 'SONSONATE');

-- 3. Inicio de una transacción
BEGIN;  -- A partir de aquí, los cambios no son definitivos hasta hacer COMMIT

-- 4. Inserción dentro de la transacción
INSERT INTO dim_terminales (terminal, tipo, nombre, departamento, ubicacion, direccion)
VALUES ('AT27', 'NORMAL', 'FARMACIA SONSONATE III', 'SV-SO', 'FARMACIA', 'SONSONATE');

-- 5. Ejemplo de eliminación dentro de la transacción
DELETE FROM dim_terminales
WHERE terminal = 'AT26';

-- 6. Si algo salió mal, podemos revertir todos los cambios
ROLLBACK;  -- Cancela la transacción y devuelve la tabla al estado inicial

-- 7. Si todo está correcto, confirmamos los cambios
COMMIT;    -- Aplica definitivamente las operaciones realizadas en la transacción
