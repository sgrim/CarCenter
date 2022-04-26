--5. Consulta de Clientes que han comprado un acumulado $100.000 en los últimos 60 días

   SELECT * FROM facturas fact, mantenimientos mant, personas per WHERE fact.mantenimiento_id = mant.mantenimiento_id AND  mant.cliente_id = per.persona_id
   100000=SELECT SUM(fact.valor_factura) FROM facturas fact WHERE fact.fecha <  TO_CHAR(TRUNC(SYSDATE - 60));
  
--6. Consulta de los 100 productos más vendidos en los últimos 30 días
  
   SELECT serv.servicio_id, serv.descripcion_servicio FROM facturas fact, mantenimientos mant, servicios serv  
   WHERE 100 = (SELECT COUNT(*) FROM facturas fact, mantenimientos mant, servicios serv 
                                WHERE fact.mantenimiento_id = mant.mantenimiento_id AND  mant.servicio_id = serv.servicio_id
                                AND fact.fecha <  TO_CHAR(TRUNC(SYSDATE - 30)));

--7. Consulta de las tiendas que han vendido más de 100 UND del producto 100 en los últimos 60 días.
     
  SELECT tiend.tienda_id, tiend.nombre, resp.codigo, resp.nombre_producto  FROM facturas fact, mantenimientos mant, repuestos resp, tiendas tiend   
   WHERE 100 > (SELECT COUNT(*) FROM facturas fact, mantenimientos mant, repuestos resp, tiendas tiend                               
                                  WHERE fact.mantenimiento_id = mant.mantenimiento_id AND  mant.repuesto_id = resp.repuesto_id AND resp.codigo =100
                                AND mant.tienda_id = tiend.tienda_id
                                AND fact.fecha <  TO_CHAR(TRUNC(SYSDATE - 60)));

--8. Consulta de todos los clientes que han tenido más de un(1) mantenimento en los últimos 30 días.

     SELECT fact.factura_id, mant.mantenimiento_id, per.persona_id, per.primer_nombre,per.segundo_nombre,per.primer_apellido
      FROM facturas fact, mantenimientos mant, personas per 
     WHERE 1 > (SELECT COUNT(*) FROM facturas fact, mantenimientos mant, personas per 
                                WHERE fact.mantenimiento_id = mant.mantenimiento_id
                                  AND mant.cliente_id = per.persona_id
                                  AND fact.fecha <  TO_CHAR(TRUNC(SYSDATE - 60)));
  