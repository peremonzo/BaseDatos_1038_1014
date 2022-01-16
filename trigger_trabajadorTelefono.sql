CREATE OR REPLACE FUNCTION Funcomptel() RETURNS TRIGGER AS '
DECLARE
BEGIN
If ((select count(dni) from telefono where dni = new.dni) = 0) then
RAISE EXCEPTION ''Este trabajador necesita un número de contacto'';
End if;
Return new;
End;
' LANGUAGE 'plpgsql';

CREATE CONSTRAINT TRIGGER comptel
AFTER INSERT or UPDATE ON trabajador
INITIALLY DEFERRED
FOR EACH ROW
EXECUTE PROCEDURE Funcomptel();
