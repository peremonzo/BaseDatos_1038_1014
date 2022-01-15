CREATE OR REPLACE FUNCTION FunHorasAct() RETURNS TRIGGER AS '
DECLARE
h_max integer;
h_act integer;
BEGIN

IF TG_OP=''INSERT''THEN
	IF EXTRACT(YEAR FROM f_ini) != EXTRACT(YEAR FROM COALESCE(f_fin, CURRENT_DATE)) THEN
		DELETE FROM maneja 
		WHERE cod_maquina = NEW.cod_maquina
		AND turno = NEW.turno
		AND f_ini = NEW.f_ini;
		RAISE EXCEPTION ''No se pueden poner aÃ±os diferentes entre f_ini y f_fin'';
	END IF;
	
	IF EXTRACT(YEAR FROM NEW.f_ini) = EXTRACT(YEAR FROM COALESCE(NEW.f_fin, CURRENT_DATE)) THEN
		SELECT horas_max INTO h_max
		FROM operario
		WHERE dni = NEW.operario_dni;
		SELECT horas_act INTO h_act
		FROM operario
		WHERE dni = NEW.operario_dni;
		IF h_act > h_max THEN
			DELETE FROM maneja 
			WHERE cod_maquina = NEW.cod_maquina
			AND turno = NEW.turno
			AND f_ini = NEW.f_ini;
			RAISE EXCEPTION ''El operario con dni % no puede tener mas horas_act que horas_max'', NEW.operario_dni;
		ELSE
			UPDATE operario SET horas_act = horas_act + NEW.horas WHERE dni = NEW.dni;		
		END IF;
	END IF;

ELSIF TG_OP=''UPDATE'' THEN
	IF EXTRACT(YEAR FROM f_ini) = EXTRACT(YEAR FROM COALESCE(f_fin, CURRENT_DATE)) THEN
		IF NEW.operario_dni != OLD.operario_dni THEN
			SELECT horas_max INTO h_max
			FROM operario
			WHERE dni = NEW.operario_dni;
			SELECT horas_act INTO h_act
			FROM operario
			WHERE dni = NEW.operario_dni;
			IF h_act > h_max THEN
				UPDATE maneja
				SET operario_dni = OLD.operario_dni
				WHERE cod_maquina = NEW.cod_maquina
				AND turno = NEW.turno
				AND f_ini = NEW.f_ini;
				RAISE EXCEPTION ''El operario con dni % no puede tener mas horas_act que horas_max'', NEW.operario_dni;
			ELSE
				UPDATE operario SET horas_act = horas_act + NEW.horas WHERE dni = NEW.dni;
				UPDATE operario SET horas_act = horas_act - OLD.horas WHERE dni = OLD.dni;
			END IF;
			
		ELSE
			SELECT horas_max INTO h_max
			FROM operario
			WHERE dni = NEW.operario_dni;
			SELECT horas_act INTO h_act
			FROM operario
			WHERE dni = NEW.operario_dni;
			IF h_act > h_max THEN
				DELETE FROM maneja 
				WHERE cod_maquina = NEW.cod_maquina
				AND turno = NEW.turno
				AND f_ini = NEW.f_ini;
				RAISE EXCEPTION ''El operario con dni % no puede tener mas horas_act que horas_max'', NEW.operario_dni;
			ELSE
				UPDATE operario SET horas_act = horas_act - OLD.horas + NEW.horas WHERE dni = NEW.dni;		
			END IF;
		END IF;
	END IF;

ELSE 
	IF EXTRACT(YEAR FROM OLD.f_ini) = EXTRACT(YEAR FROM COALESCE(OLD.f_fin, CURRENT_DATE)) THEN
		UPDATE operario SET horas_act = horas_act - OLD.horas WHERE dni = OLD.dni;
	END IF;
END IF;
RETURN NEW;
END;
' LANGUAGE 'plpgsql';



CREATE TRIGGER TrgHorasAct
AFTER INSERT OR DELETE OR UPDATE of horas, operario_dni ON maneja
FOR EACH ROW
EXECUTE PROCEDURE FunHorasAct();





CREATE OR REPLACE FUNCTION FunHorasMax() RETURNS TRIGGER AS '
BEGIN
IF NEW.horas_act > NEW.horas_max THEN
	RAISE EXCEPTION ''El operario con dni % no puede tener mas horas_act que horas_max'', NEW.dni;
END IF;
RETURN NEW;
END;
'LANGUAGE 'plpgsql';



CREATE TRIGGER TrgHorasMax
BEFORE INSERT OR UPDATE ON operario
FOR EACH ROW
EXECUTE PROCEDURE FunHorasMax();
