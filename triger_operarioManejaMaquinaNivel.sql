CREATE OR REPLACE FUNCTION FunNivelOper() RETURNS TRIGGER AS '
BEGIN
IF (NEW.dni in (select operario_dni from maneja))
	THEN
	IF EXISTS (SELECT * FROM maneja as man
			JOIN maquina AS maq ON man.cod_maquina = maq.codigo
			WHERE man.operario_dni = NEW.dni
			AND NEW.nivel NOT IN ( SELECT cod_nivel FROM mayor_igual_que
						WHERE cod_nivel_2 = maq.nivel)
			AND NEW.nivel != maq.nivel)
	THEN RAISE EXCEPTION ''El operario con dni % no puede manejar una maquina con mayor nivel'', NEW.dni;
	END IF;
END IF;
RETURN NEW;
END;
'LANGUAGE 'plpgsql';


CREATE TRIGGER TrgNivelOper
BEFORE UPDATE of nivel ON operario
FOR EACH ROW
EXECUTE PROCEDURE FunNivelOper();


CREATE OR REPLACE FUNCTION FunNivelMaq() RETURNS TRIGGER AS '
BEGIN
IF (NEW.codigo in (select cod_maquina from maneja))
	THEN
	IF EXISTS (SELECT * FROM maneja as man
			JOIN operario AS o ON man.operario_dni = o.dni
			WHERE man.cod_maquina = NEW.codigo
			AND o.nivel NOT IN ( SELECT cod_nivel FROM mayor_igual_que
						WHERE cod_nivel_2 = NEW.nivel)
			AND NEW.nivel != o.nivel)
	THEN RAISE EXCEPTION ''La maquina con codigo % no puede ser manejada por un operario con menor nivel'', NEW.codigo;
	END IF;
END IF;
RETURN NEW;
END;
'LANGUAGE 'plpgsql';


CREATE TRIGGER TrgNivelMaq
BEFORE UPDATE of nivel ON maquina
FOR EACH ROW
EXECUTE PROCEDURE FunNivelMaq();


CREATE OR REPLACE FUNCTION FunNivelMan() RETURNS TRIGGER AS '
DECLARE
nivelOperario TEXT;
nivelMaquina TEXT;
BEGIN
SELECT nivel INTO nivelOperario FROM operario WHERE dni = NEW.operario_dni;
SELECT nivel INTO nivelMaquina FROM maquina WHERE codigo = NEW.cod_maquina;
IF nivelOperario != nivelMaquina
AND nivelOperario NOT IN (SELECT cod_nivel FROM mayor_igual_que
				WHERE cod_nivel_2 = nivelMaquina)
	THEN RAISE EXCEPTION ''El operario % no tiene el nivel suficiente para manejar la maquina %'', NEW.operario_dni, NEW.cod_maquina;
END IF;
RETURN NEW;
END;
'LANGUAGE 'plpgsql';



CREATE TRIGGER TrgNivelMan
BEFORE INSERT OR UPDATE ON maneja
FOR EACH ROW
EXECUTE PROCEDURE FunNivelMan();
