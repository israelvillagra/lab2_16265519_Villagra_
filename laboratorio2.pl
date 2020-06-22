

%repositorio(Autor, Fecha, Hora, NombreRepo, zonasDeTrabajo[]).

% Repositorio
repositorio(master,'LABORATORIO2','Israel Villagra', '02-06-2020','13:57' ,[workspace, index, localRepository, remoteRepository]).

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
archivosEnZonasDeTrabajo(master, 'LABORATORIO2',workspace,['archivo1W.txt','archivo2W.txt','archivo3W.txt','archivo4W.txt','archivo5W.txt']).
archivosEnZonasDeTrabajo(master, 'LABORATORIO2',index,['archivo1I.txt','archivo2I.txt','archivo3I.txt','archivo4I.txt']).
archivosEnZonasDeTrabajo(master, 'LABORATORIO2',localRepository,['archivo1L.txt','archivo2L.txt','archivo3L.txt','archivo4L.txt']).
archivosEnZonasDeTrabajo(master, 'LABORATORIO2',remoteRepository,['archivo1R.txt','archivo2R.txt','archivo3R.txt','archivo4R.txt']).

%Commit en Zonas de Trabajo
commitEnZonasDeTrabajo(master, 'LABORATORIO2',index,['archivo1W.txt','archivo2W.txt','archivo3W.txt'],'Se ha subido tres archivos desde workspace a index').
commitEnZonasDeTrabajo(master, 'LABORATORIO2',localRepository,['archivo1W.txt','archivo2I.txt'],'Se ha subido dos archivos de workspace a index').
commitEnZonasDeTrabajo(master, 'LABORATORIO2',remoteRepository,['archivo1W.txt'],'Se ha subido un archivo de localRepository a remoteRepository').

%************Región gitInit*********************
gitInit(L,A,V) :- repositorio(_,L,A,_,_,V).
%gitInit('LABORATORIO2','Israel Villagra', R).

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
git2String(RAMA,X):- repositorio(RAMA,LABORATORIO,AUTOR, FECHACREACION,HORACREACION ,_),
archivosEnZonasDeTrabajo(_,LABORATORIO,workspace,WORKSPACE_FILES),
archivosEnZonasDeTrabajo(_,LABORATORIO,index,INDEX_FILES),
commitEnZonasDeTrabajo(_, LABORATORIO,index,COMMIT_INDEX_FILES,MESSAGE_INDEX_FILES),
append(INDEX_FILES,COMMIT_INDEX_FILES,ALL_INDEX_FILES),
archivosEnZonasDeTrabajo(_,LABORATORIO,localRepository,LOCALREPOSITORY_FILES),
commitEnZonasDeTrabajo(_, LABORATORIO,localRepository,COMMIT_LOCALREPOSITORY_FILES,MESSAGE_LOCALREPOSITORY_FILES),
append(LOCALREPOSITORY_FILES,COMMIT_LOCALREPOSITORY_FILES,ALL_LOCALREPOSITORY_FILES),
archivosEnZonasDeTrabajo(_,LABORATORIO,remoteRepository,REMOTEREPOSITORY_FILES),
commitEnZonasDeTrabajo(_, LABORATORIO,remoteRepository,COMMIT_REMOTEREPOSITORY_FILES,MESSAGE_REMOTEREPOSITORY_FILES),
append(REMOTEREPOSITORY_FILES,COMMIT_REMOTEREPOSITORY_FILES,ALL_REMOTEREPOSITORY_FILES),
X = '###### Repositorio'+ LABORATORIO +' ###### \nFecha de creación: '+ FECHACREACION + ' ' + HORACREACION +'
rama actual: '+ RAMA +'
AUTOR : ' + AUTOR + '
Archivos en workspace :'+ WORKSPACE_FILES +'\n
Archivos en index :'+ ALL_INDEX_FILES +'\n
Commits en local Index :'+ COMMIT_INDEX_FILES +'
Mensaje en Commits en Index :'+ MESSAGE_INDEX_FILES +'\n
Archivos en Local Repository :'+ LOCALREPOSITORY_FILES +'
Commits en Local Repository :'+ ALL_LOCALREPOSITORY_FILES +'
Mensaje en Commits en Local Repository :'+ MESSAGE_LOCALREPOSITORY_FILES +'\n
Archivos en Remote Repository :'+ ALL_REMOTEREPOSITORY_FILES +'\n
Commits en Remote Repository :'+ COMMIT_REMOTEREPOSITORY_FILES +'
Mensaje en Commits en Remote Repository :'+ MESSAGE_REMOTEREPOSITORY_FILES +'\n
##### FIN DE REPRESENTACIÓN COMO STRING DEL REPOSITORIO #####'
.
%git2String(master,X), write(X).

show_records([]).
show_records([A|B]) :-
  format('~w\n',A),
  show_records(B). 