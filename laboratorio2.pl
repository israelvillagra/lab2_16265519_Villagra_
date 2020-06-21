

%repositorio(Autor, Fecha, Hora, NombreRepo, zonasDeTrabajo[]).

% Repositorio
repositorio(lab1,'LABORATORIO2','Israel Villagra', '02-06-2020','13:57' ,[workspace, index, localRepository, remoteRepository]).
%repositorio('Israel Villagra', '02-06-2020', '13:57', 'lab2', [workspace, index, localRepository, remoteRepository).

% Zonas de Trabajo
zonasDeTrabajo(workspace).
zonasDeTrabajo(index).
zonasDeTrabajo(localRepository).
zonasDeTrabajo(remoteRepository).

% Archivos en Zonas de Trabajo
archivosEnZonasDeTrabajo(lab1, 'LABORATORIO2',workspace,['archivo1W.txt','archivo2W.txt','archivo3W.txt','archivo4W.txt','archivo5W.txt']).
archivosEnZonasDeTrabajo(lab1, 'LABORATORIO2',index,['archivo1I.txt','archivo2I.txt','archivo3I.txt','archivo4I.txt']).
archivosEnZonasDeTrabajo(lab1, 'LABORATORIO2',localRepository,['archivo1L.txt','archivo2L.txt','archivo3L.txt','archivo4L.txt']).
archivosEnZonasDeTrabajo(lab1, 'LABORATORIO2',remoteRepository,['archivo1R.txt','archivo2R.txt','archivo3R.txt','archivo4R.txt']).

%************Región gitInit*********************
gitInit(L,A,V) :- repositorio(_,L,A,_,_,V).
%gitInit('LABORATORIO2','Israel Villagra', RepoOutput).


%************Región gitAdd*********************
%Obtiene los archivos de una zona de trabajo (variables Z), de un repositorio indicador con la (variables X)
obtenerArchivos(X,Z,A) :- archivosEnZonasDeTrabajo(_,X,Z,A).
%agregaUltimoElemento(A,[],A).
%agregaUltimoElemento(W,Z) :- obtenerArchivos(_,W,A),  obtenerArchivos(_,index,B), append(A,B,Z).

%Añade a la lista Z los elementos que se encuentran en la lista I, que provienen de la lista W
gitAdd(W,I,Z) :- obtenerArchivos(_,W,A), append(A,I,Z).
%gitAdd(workspace,['archivo1.txt'],X).
%gitAdd(workspace,['archivo1.txt','archivo3.txt'],X).

%************Región gitCommit*********************
%gitCommit(RepoInput, Mensaje, RepoOutput).