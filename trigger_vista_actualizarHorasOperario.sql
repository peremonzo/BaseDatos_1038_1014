CREATE OR REPLACE FUNCTION funActualizarVista() RETURNS TRIGGER AS '
BEGIN
Update maneja set horas = new.horas where operario_dni = new.operario_dni and cod_maquina = new.cod_maquina; 
RETURN NEW;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER trgActualizarVista
INSTEAD OF UPDATE ON maneja_act_nivel_3
FOR EACH ROW
EXECUTE PROCEDURE funActualizarVista();

