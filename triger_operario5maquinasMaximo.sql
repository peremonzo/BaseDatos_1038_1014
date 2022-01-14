
CREATE OR REPLACE FUNCTION funCompruebaMaquinas() RETURNS TRIGGER AS '

	BEGIN
	IF( (SELECT COUNT(*) FROM mantiene_maquina WHERE cod_tecnico=NEW.cod_tecnico)>=5 )
		THEN
		RAISE EXCEPTION '' El operario ya tiene 5 máquinas '';
  END IF;
	RETURN NEW;
	END;
' LANGUAGE 'plpgsql';

DROP TRIGGER trgcompruebamaquinas ON mantiene_maquina ;

CREATE TRIGGER trgcompruebamaquinas
BEFORE INSERT OR UPDATE ON mantiene_maquina
FOR EACH ROW
EXECUTE PROCEDURE funCompruebaMaquinas();