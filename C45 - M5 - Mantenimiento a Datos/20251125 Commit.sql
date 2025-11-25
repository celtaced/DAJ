select * from dim_terminales
INSERT INTO dim_terminales (terminal, tipo, nombre, departamento, ubicacion, direccion) VALUES('AT26', 'NORMAL', 'FARMACIA SONSONATE II', 'SV-SO', 'FARMACIA', 'SONSONATE');


begin -- Inicio de la sesion 
INSERT INTO dim_terminales (terminal, tipo, nombre, departamento, ubicacion, direccion) VALUES('AT27', 'NORMAL', 'FARMACIA SONSONATE III', 'SV-SO', 'FARMACIA', 'SONSONATE');
delete from dim_terminales where TERMINAL = 'AT26'
	
rollback -- Todos los cambios se van a revertis

commit -- enviar mis sentencias de cambio a la BD