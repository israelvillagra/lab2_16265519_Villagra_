

%repositorio(Autor, Fecha, Hora, NombreRepo, zonasDeTrabajo[]).

% Repositorio
repositorio(lab1,'LABORATORIO2','Israel Villagra', '02-06-2020','13:57' ,[workspace, index, localRepository, remoteRepository]).

% Zonas de Trabajo
zonasDeTrabajo(workspace).
zonasDeTrabajo(index).
zonasDeTrabajo(localRepository).
zonasDeTrabajo(remoteRepository).

%Flujo de Cambios
flujoZonasDeTrabajo(workspace,index).
flujoZonasDeTrabajo(index,localRepository).
flujoZonasDeTrabajo(localRepository,remoteRepository).

% Archivos en Zonas de Trabajo
archivosEnZonasDeTrabajo(lab1, 'LABORATORIO2',workspace,['archivo1W.txt','archivo2W.txt','archivo3W.txt','archivo4W.txt','archivo5W.txt']).
archivosEnZonasDeTrabajo(lab1, 'LABORATORIO2',index,['archivo1I.txt','archivo2I.txt','archivo3I.txt','archivo4I.txt']).
archivosEnZonasDeTrabajo(lab1, 'LABORATORIO2',localRepository,['archivo1L.txt','archivo2L.txt','archivo3L.txt','archivo4L.txt']).
archivosEnZonasDeTrabajo(lab1, 'LABORATORIO2',remoteRepository,['archivo1R.txt','archivo2R.txt','archivo3R.txt','archivo4R.txt']).

%Commit en Zonas de Trabajo
commitEnZonasDeTrabajo(lab1, 'LABORATORIO2',index,['archivo1W.txt','archivo2W.txt','archivo3W.txt'],'Se ha subido tres archivos desde workspace a index').
commitEnZonasDeTrabajo(lab1, 'LABORATORIO2',localRepository,['archivo1W.txt','archivo2I.txt'],'Se ha subido dos archivos de workspace a index').
commitEnZonasDeTrabajo(lab1, 'LABORATORIO2',remoteRepository,['archivo1W.txt'],'Se ha subido un archivo de localRepository a remoteRepository').

%************Región gitInit*********************
gitInit(L,A,V) :- repositorio(_,L,A,_,_,V).
%gitInit('LABORATORIO2','Israel Villagra', RepoOutput).


%************Región gitAdd*********************
%Obtiene los archivos de una zona de trabajo (variables Z), de un repositorio indicador con la (variables X)
obtenerArchivos(X,Z,A) :- archivosEnZonasDeTrabajo(_,X,Z,A).
%agregaUltimoElemento(A,[],A).
%agregaUltimoElemento(W,Z) :- obtenerArchivos(_,W,A),  obtenerArchivos(_,index,B), append(A,B,Z).

%Añade a la lista Z los elementos que se encuentran en la lista I, que provienen de la lista W
gitAdd(W,I,Z) :- flujoZonasDeTrabajo(W,OTRO), obtenerArchivos(_,OTRO,A), append(A,I,Z).
%Prueba que envía desde el workspace los archivos a index.
%gitAdd(workspace,['archivo1W.txt','archivo2W.txt','archivo3W.txt'],X).

%************Región gitCommit*********************
gitCommit(RepoInput, Mensaje, RepoOutput):-  commitEnZonasDeTrabajo(_,_,RepoInput,A,_), append(A,Mensaje,RepoOutput).
%flujoZonasDeTrabajo(RepoInput,RI),
%Envía los archivos pendientes desde Index a LocalRepository
%gitCommit(index,'Se envían los archivos pendientes a localRepository',X).

%************Región gitCommit*********************
gitPush(RepoInput, RepoOutput):- flujoZonasDeTrabajo(RepoInput,RI), commitEnZonasDeTrabajo(_,_,RI,A,M), append(A,M,RepoOutput).
%
%gitPush(localRepository, RepoOutput).

%************Región git2String*********************
%git2String(RepoInput, RepoAsString).
%git2String(RepoInput, RepoAsString):-write(RepoAsString,"\n").
imprimir(X):- archivosEnZonasDeTrabajo(_,L,_,_), X = L.
imprimir(X):- archivosEnZonasDeTrabajo(_,L,_,_), X = L.
hola(X):- repositorio(_,LABORATORIO,AUTOR, FECHACREACION,HORACREACION ,_), 
X = '###### Repositorio'+ LABORATORIO +' ###### 
Fecha de creación: '+FECHACREACION +' '+ HORACREACION +'
AUTOS : '+AUTOR +'
##### FIN DE REPRESENTACIÓN COMO STRING DEL REPOSITORIO #####'.
%+FECHACREACION+' '+HORACREACION.
%.%, format('\n| ~s~t~28|| ~s~t~36|| ~s~t~56|| ~s~t~80||~n', [L, 'Age', 'Eye Colour', 'Phone Number']).
%repositorio(lab1,'LABORATORIO2','Israel Villagra', '02-06-2020','13:57' ,[workspace, index, localRepository, remoteRepository]).