%Israel Villagra
%16265519-1
%Dominios
%	sii(Rut,Nombre,Fecha_inicio_actividades,Termino_giro, Tipo_persona) symbol.
%	aquifax(RUT, NOMBRE,DIRECCION ,COMUNA, Morosidades,	Infracciones_previsionales,	Protestos, MontoCreditos) Symbol.
%	gesintel(Rut,Ndemandas,Ndetenciones,BuscadoPDI) symbol.

%Predicados
%	direccion(RUT,DIRECCION)			    aridad = 2
%   deudadVencidadPersonaNatural(RUT,S)     aridad = 2
%   clienteSinProtestos(RUT,PROTESTOS)      aridad = 2
%   noBuscadoPDI(RUT,BUSCADO)               aridad = 2
%   giroNoDetenido(RUT,DETENIDO)            aridad = 2
%   deudadMenoresA(RUT,X)                   aridad = 2
%   evaluaCliente(RUT,Y)                    aridad = 2

%Metas
%	Primarias
%	    evaluaCliente(RUT,Y)
%       deudadVencidadPersonaNatural(RUT,S)	
%       evaluaCliente	        
%	Secundarias
%	    direccion(RUT,DIRECCION)			    aridad = 2
%       clienteSinProtestos(RUT,PROTESTOS)      aridad = 2
%       noBuscadoPDI(RUT,BUSCADO)               aridad = 2
%       giroNoDetenido(RUT,DETENIDO)            aridad = 2
%       deudadMenoresA(RUT,X)                   aridad = 2

%Cláusulas
% hechos
%    Rut             Nombre         Fecha inicio actividades	¿Termino giro?	Tipo persona
sii('12.344.100-8', 'Cisarro Covid','No tiene'                 , 'No'           , 'Natural').
sii('16.500.122-5', 'Nicole Rojas' ,'20/11/2010'               , 'No'           , 'Natural').
sii('76.540.100-6', 'Guantes LTDA' ,'30/10/2012'               , 'Si'           , 'Jurídica').
sii('64.990.657-1', 'Empresa1 S.A' ,'12/07/2015'               , 'No'           , 'Jurídica').
sii('5.680.123-4' , 'Ana Durán'    ,'12/2/2020'                , 'No'           , 'Natural').


%        Rut	         Nombre                                      Morosidades	Infracciones previsionales	Protestos  Monto créditos
aquifax('16.500.122-5', 'Nicole Rojas','Calle Sur #454.'  ,'Recoleta' , 2500000    , 500590                    , 0         , 60100000).
aquifax('64.990.657-1', 'Empresa1 S.A', 'Poniente 1 #121. ','Santiago' ,  52000000   , 4960010                   , 399890    , 101890410).
aquifax( '5.680.123-4', 'Ana Durán'   , 'Rosales #31123. ' ,'Maipú'    ,  4500       , 0                         , 0         , 300000).

%         Rut           N° demandas N° detenciones ¿Buscado por PDI?
gesintel('16.500.122-5', '5'        ,'1'           ,'No').
gesintel('12.344.100-8', '1'        ,'0'           ,'Si').

%        Rut             Morosidades  Infracciones previsionales	Protestos	Teléfono
sinacofi('16.500.122-5', 2500000      , 500590                     ,0          ,'600421777').
sinacofi('64.990.657-1', 6400000      , 4960010                    ,0          ,'944581110').%11.360.010


%Reglas
%Dirección de la persona
direccion(RUT,DIRECCION):- aquifax(RUT, _,DI ,COMUNA, _, _,_,_),  atom_concat(DI, COMUNA,DIRECCION) ;DIRECCION = 'No Encontrado, Compruebe RUT'.

%Deuda Persona Natural.
deudadVencidadPersonaNatural(RUT,S):- sii(RUT,_,_,_,'Natural'),
sinacofi(RUT,MS,IPS,PS,_),
aquifax(RUT,_,_,_,ME,IPE,PSE,_),
(MS+IPS+PS)> (ME+IPE+PSE),
S is (MS+IPS+PS);
aquifax(RUT,_,_,_,ME,IPE,PSE,_),S is (ME+IPE+PSE).

%*************Región Clienes Sin Protestos*************
%Busca clientes con Protestos
clienteSinProtestos(RUT,PROTESTOS):- sinacofi(RUT,_,_,PS,_), aquifax(RUT,_,_,_,_,_,PSE,_), (PS = 0, PSE = 0 -> PROTESTOS = true ; PROTESTOS = false);PROTESTOS = true.
%clienteSinProtestos('64.990.657-1',X).
%clienteSinProtestos('5.680.123-4',X).

%*************Región No Buscado por PDI*************
noBuscadoPDI(RUT,BUSCADO) :-gesintel(RUT, _ ,_ ,PDI), (PDI =@= 'No' -> BUSCADO = true ; BUSCADO=false).
%noBuscadoPDI('16.500.122-5',X).
%noBuscadoPDI('12.344.100-8',X).

%*************Región Giro No Detenido*************
giroNoDetenido(RUT,DETENIDO) :-sii(RUT,_,_, GIRODETENIDO, _), (GIRODETENIDO =@= 'No' -> DETENIDO = true ; DETENIDO=false).
%giroDetenido('12.344.100-8', X).

%*************Región Persona Juridica*************
personaJuridica(RUT,X) :- sii(RUT,_,II,_,'Jurídica'), X is II.

%*************Región Giro No Detenido*************
deudadMenoresA(RUT,X):- sinacofi(RUT,DEUDAS,_,_,_),
aquifax(RUT,_,_,_,DEUDAE,_,_,_),
aquifax(RUT,_,_,_,_,_,_,CREDITO),
       ( (  
            ( 
                (DEUDAS+DEUDAE)*100
            ) /CREDITO 
        ) > 25 -> X = false ; X = true).

%*************Región Evalua Cliente*************
%Evalua posible cliente
evaluaCliente(RUT,Y):- clienteSinProtestos(RUT,PROTESTOSCLIENTE),
noBuscadoPDI(RUT,NO_PDI),
giroNoDetenido(RUT, GIRODETENIDO),
deudadMenoresA(RUT, DEUDACREDITO),
(                (PROTESTOSCLIENTE = true
                , GIRODETENIDO = true 
                , NO_PDI = true
                , DEUDACREDITO = true) -> Y = true ; Y = false
); Y =false.
%evaluaCliente('16.500.122-5',X).
%evaluaCliente('64.990.657-1',X).
