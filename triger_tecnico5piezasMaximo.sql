CREATE OR REPLACE FUNCTION funCompruebaMaxPiezasMantenidas() RETURNS
TRIGGER AS '
BEGIN
IF EXISTS (select dni from mantiene_pieza where dni = new.dni group by
dni having count(cod_pieza) = 5)
THEN
RAISE EXCEPTION '' Este operario ya maneja el número máximo de piezas'';
END IF;
RETURN NEW;
END;
' LANGUAGE 'plpgsql';


CREATE TRIGGER trgCompruebaMaxPiezasMantenidas
BEFORE INSERT OR UPDATE ON mantiene_pieza
FOR EACH ROW
EXECUTE PROCEDURE funCompruebaMaxPiezasMantenidas();