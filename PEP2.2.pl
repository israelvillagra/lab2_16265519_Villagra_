%Israel Villagra
%16265519-1
%Dominios
%	estados(s,a,derecha,1). symbol.

%Predicados
%	verificar(INICIO,FINAL,VALOR)			    aridad = 3

%Metas
%	Primarias
%       verificar(INICIO,FINAL,VALOR)			    

%Cláusulas
% hechos
estados(s,a,derecha,1).
estados(s,c,derecha,2).
estados(c,a,arriba,4).
estados(c,d,derecha,3).
estados(a,b, derecha,1).
estados(b,d, abajo, 1).
estados(b,e, derecha, 2).
estados(d,e, derecha,1).

%Reglas
% Se verifica si el origen con el destino final contiene el valor que se ingresa como parametro
% el INICIO se considera como el ORIGEN 
% FINAL se referencia al destino
% El VALOR referencia al COSTO
% Este es una de muchas las soluciones.

verificar(INICIO,FINAL,VALOR):- estados(INICIO,FINAL,_,VALOR1)
, VALOR is VALOR1.

verificar(INICIO,FINAL,VALOR):- estados(INICIO,INICIO1,_,VALOR1)
, estados(INICIO1,FINAL,_,VALOR2)
, VALOR is VALOR1+VALOR2.

verificar(INICIO,FINAL,VALOR):- estados(INICIO,INICIO1,_,VALOR1)
, estados(INICIO1,INICIO2,_,VALOR2)
, estados(INICIO2,FINAL,_,VALOR3)
, VALOR is VALOR1+VALOR2+VALOR3.

verificar(INICIO,FINAL,VALOR):- estados(INICIO,INICIO1,_,VALOR1)
, estados(INICIO1,INICIO2,_,VALOR2)
, estados(INICIO2,INICIO3,_,VALOR3)
, estados(INICIO3,FINAL,_,VALOR4)
, VALOR is VALOR1+VALOR2+VALOR3+VALOR4. 

verificar(INICIO,FINAL,VALOR):- estados(INICIO,INICIO1,_,VALOR1)
, estados(INICIO1,INICIO2,_,VALOR2)
, estados(INICIO2,INICIO3,_,VALOR3)
, estados(INICIO3,INICIO4,_,VALOR4)
, estados(INICIO4,FINAL,_,VALOR5)
, VALOR is VALOR1+VALOR2+VALOR3+VALOR4+VALOR5. 