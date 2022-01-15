CREATE TRIGGER trgCompruebaRango 
BEFORE UPDATE ON Nivel
 FOR EACH ROW 
EXECUTE PROCEDURE funCompruebaRango() ;

CREATE OR REPLACE FUNCTION funCompruebaRango() 
RETURNS TRIGGER AS' 
BEGIN
IF EXISTS (select * from operario where cod_nivel = NEW.cod_nivel AND(NEW.horas_min > horas OR NEW.horas_max < horas)) THEN
RAISE EXCEPTION '' Las % horas del operario % están fuera del rango del nivel % (% - %)'', horas, nombre, OLD.cod_nivel, NEW.horas_min, NEW.horas_max;
END IF;
RETURN NEW;
END;
'LANGUAGE 'plpgsql';
