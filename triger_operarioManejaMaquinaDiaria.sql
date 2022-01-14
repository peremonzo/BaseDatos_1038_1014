CREATE OR REPLACE FUNCTION funCompruebaOperarioManejaMaquinas() RETURNS
TRIGGER AS '
BEGIN
IF EXISTS (select * from maneja where operario_dni = new.operario_dni and f_ini = new.f_ini)
THEN
RAISE EXCEPTION '' Este operario ya está manejando una máquina ese día'';
END IF;
RETURN NEW;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER TrgOperManejMaq
BEFORE INSERT OR UPDATE ON maneja
FOR EACH ROW
EXECUTE PROCEDURE funCompruebaOperarioManejaMaquinas();