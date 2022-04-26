--9. Procedimiento que reste la cantidad de productos del inventario de las tiendas cada que se presente una venta.

CREATE OR REPLACE TRIGGER changes_Inventarios
AFTER INSERT
   ON facturas
   FOR EACH ROW

DECLARE
   fact_id NUMBER;

BEGIN
   fact_id  := :new.facturas_id;

FOR item IN (SELECT * FROM mantenimientos mant WHERE fact_id = mant.mantenimiento_id)
  LOOP
     UPDATE Inventarios I SET I.cantidad = I.cantidad - item.cantidad WHERE I.repuesto_id = item.repuesto_id AND item.tienda_id = I.tienda_id;
 END LOOP;

END;