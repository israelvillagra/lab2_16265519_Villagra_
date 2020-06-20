

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
archivosEnZonasDeTrabajo(lab1, workspace, [cargarArchivo, actualizArchivo, eliminaArchivo, listarArchivos]).

gitInit(L,A,V) :- repositorio(_,L,A,_,_,V).
%gitInit('LABORATORIO2','Israel Villagra', RepoOutput).

gitadd(X,Y,Z) :- append(Y,[X],Z).
