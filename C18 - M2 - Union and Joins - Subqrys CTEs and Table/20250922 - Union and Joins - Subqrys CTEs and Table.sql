-- Complementar la data

-- Paso 1 unir Test y gender submision 
select *
from test A
left join gender_submission B on A."PassengerId" = B."PassengerId"


-- Paso 2 ordenamos y seleccionamos las columnas
select A."PassengerId", B."Survived", A."Pclass", A."Name", A."Sex", A."Age", A."SibSp", A."Parch", A."Ticket", A."Fare", A."Cabin", A."Embarked"
from test A
left join gender_submission B on A."PassengerId" = B."PassengerId"


-- Paso 3 Aplicamos union
select * from train
union all 
select A."PassengerId", B."Survived", A."Pclass", A."Name", A."Sex", A."Age", A."SibSp", A."Parch", A."Ticket", A."Fare", A."Cabin", A."Embarked"
from test A
left join gender_submission B on A."PassengerId" = B."PassengerId"


-- 1. CUANTAS PERSONAS SOBREVIVIERON
-- Ejemplo usando dos where (No recomendado)
select * from train where "Survived" = 1
union all 
select A."PassengerId", B."Survived", A."Pclass", A."Name", A."Sex", A."Age", A."SibSp", A."Parch", A."Ticket", A."Fare", A."Cabin", A."Embarked"
from test A
left join gender_submission B on A."PassengerId" = B."PassengerId"
where B."Survived" = 1


-- subconsultas
select *
from (
	-- Esta la subconsulta
	select * from train
	union all 
	select A."PassengerId", B."Survived", A."Pclass", A."Name", A."Sex", A."Age", A."SibSp", A."Parch", A."Ticket", A."Fare", A."Cabin", A."Embarked"
	from test A
	left join gender_submission B on A."PassengerId" = B."PassengerId"
) A
where A."Survived" = 1
-- 494

-- CTE
with datacompleta as(
	select * from train
	union all 
	select A."PassengerId", B."Survived", A."Pclass", A."Name", A."Sex", A."Age", A."SibSp", A."Parch", A."Ticket", A."Fare", A."Cabin", A."Embarked"
	from test A
	left join gender_submission B on A."PassengerId" = B."PassengerId"
)
select * from datacompleta where "Survived" = 1;
--494

-- Creando Tablas o tablas temporales

create table datacompleta_tabla as (
	select * from train
	union all 
	select A."PassengerId", B."Survived", A."Pclass", A."Name", A."Sex", A."Age", A."SibSp", A."Parch", A."Ticket", A."Fare", A."Cabin", A."Embarked"
	from test A
	left join gender_submission B on A."PassengerId" = B."PassengerId"
)


select * from datacompleta_tabla

select * from datacompleta_tabla where "Survived" = 1
-- 494

create temp table datacompleta_temp as (
	select * from train
	union all 
	select A."PassengerId", B."Survived", A."Pclass", A."Name", A."Sex", A."Age", A."SibSp", A."Parch", A."Ticket", A."Fare", A."Cabin", A."Embarked"
	from test A
	left join gender_submission B on A."PassengerId" = B."PassengerId"
)

select * from datacompleta_temp

select * from datacompleta_temp where "Survived" = 1