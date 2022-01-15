CREATE OR REPLACE FUNCTION funActVistaP8() RETURNS TRIGGER AS '
BEGIN
Update estado set f_fin = current_date where codigo = new.código_pieza;
Insert into estado values (new.código_pieza, current_date, null, new.estado);
RETURN NEW;
END;
' LANGUAGE 'plpgsql';
CREATE TRIGGER trgActVistaP8
INSTEAD OF UPDATE ON mis_piezas
FOR EACH ROW
EXECUTE PROCEDURE funActVistaP8();
