CREATE OR REPLACE FUNCTION corres.f_encuentra_raiz (
  fl_id_correspondencia integer
)
RETURNS integer AS'
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE FLUJO ()
***************************************************************************
 SCRIPT: 		corres.f_encuentra_raiz
 DESCRIPCIÓN: 	encuentra el nodo raiz de la correspondencia señalada
 AUTOR: 		KPLAIN RAC
 FECHA:			13/01/2012
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA  

******************/

DECLARE 
  v_nivel integer;
  v_id_corre integer;
  v_id_corre_fk integer;
  v_raiz integer;    
BEGIN

  /*
  --1)  encuentro nodo  raiz con nivel = 0
  
  */
  
  SELECT 
    co.nivel, 
    co.id_correspondencia, 
    co.id_correspondencia_fk 
  into 
    v_nivel,
    v_id_corre,
    v_id_corre_fk    
  FROM  corres.tcorrespondencia co
  WHERE co.id_correspondencia = fl_id_correspondencia;
  
  IF(v_nivel=0) THEN
    return  v_id_corre;
  ELSE
    v_raiz=corres.f_encuentra_raiz(v_id_corre_fk);
    return  v_raiz;
  END IF;
END;
'LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;