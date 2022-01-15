CREATE OR REPLACE FUNCTION funCompruebaHoras() RETURNS TRIGGER AS '
DECLARE
filatipo nivel%ROWTYPE;
BEGIN
SELECT * INTO filatipo
FROM nivel
WHERE cod_nivel = NEW.cod_nivel;
IF (filatipo.horas_max < new.horas or filatipo.horas_min > new.horas)
THEN
RAISE EXCEPTION '' Las % horas del operario % están fuera del rango del nivel % (% - %)'', NEW.horas, NEW.nombre, filatipo.cod_nivel, filatipo.horas_min, filatipo.horas_max;
END IF;
RETURN NEW;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER trgCompruebaHoras
BEFORE INSERT OR UPDATE ON OPERARIO 
FOR EACH ROW 
EXECUTE PROCEDURE funCompruebaHoras();
