%dominio
	%orientaciones
	%este
%predicados
	%xxxxx
	
%metas
	%primarias
        %xxx
	%secundarias
		%xxx
				
%clausulas	
	%Hechos

	%Reglas

/*
zonas de trabajo son instancias encargadas de almacenar los commits, estas zonas pueden ser locales o remotas.
Las zonas de trabajo básicas de git son cuatro:
El Workspace, que representa el directorio local en el PC, donde se puede editar el código fuente.
El Index es donde los cambios son agregados (de uno o más archivos) para formar un commit.
El Local Repository almacena todos los commits generados en base al Index para ser posteriormente subidos al Remote Repository.
El Remote Repository es el servidor externo que respalda los commits enviados desde el Local Repository.
*/

/*
Idea:
se tienen zonas de trabajo que basicamente son directorios enriquecidos o no.
un directorio es un contenedor (lista) de archivos, con nombre. Puede "enriquecerse" con "cambios".
un archivo es una cadena de texto (con "lineas" separadas por caracter '\n'), asociada a un nombre (y timestamp? creación- ultima modificacion)
un "cambio" es un conjunto de listas que contienen numero de linea, contenido actual y contenido nuevo, asociadas a un archivo y timestamp.
si se quisiera "aplicar" un cambio: si no existe el archivo, lo crea. si no existe la linea, la crea (rellenando con '\n' en caso de estar despues del fin del archivo.).
el workspace es solo un directorio local
el index es una copia del workspace original (init) enriquecido con cambios cargados por add
un commit es una lista de pares archivo-[cambios], asociado a un nombre, timestamp, usuario, nombreProyecto
el local repo y el remote repo son directorios, conteniendo archivos originales enriquecidos con commits
*/

% hechos
archivo("ar1.txt", "hola esto es\n el contenido de un archivo").
archivo("ar2.txt", "hola esto es\n texto en un archivo").
archivo("ar3.txt", "hola esto es\n un texto en un archivo").

zona("workspace", "ar1.txt").
zona("workspace", "ar2.txt").
zona("workspace", "ar3.txt").


zona("index", "ar2.txt").
zona("index", "ar3.txt").

zona("localRepo", "ar1.txt").

zona("remoteRepo", "ar1.txt").

% nombreRepo(id_repo, nombre_repo)
%nombreRepo(1, "repo1").

% nombreAutor(id_autor, nombre_autor)
%nombreAutor(1, "Carlos").

% timestamp(id_timestamp, timestamp)
%timestamp(1, 12345).

%se define commit id, mensaje, contenido
commit(1, "mensaje commit 1", []).


% repositorio nombre, autor, timestamp, zona
repositorio("repo1", "Carlos", 123123, "workspace", 1).
repositorio("repo1", "Carlos", 123124, "index", 1).
repositorio("repo1", "Carlos", 123125, "localRepo", 1).
repositorio("repo1", "Carlos", 123126, "remoteRepo", 1).

%

% devuelve los workspaces de un repo (NR)
getZonas(NR, NZ) :- 
    repositorio(NR, _, _, NZ, _).

% devuelve los archivos de una zona (NZ) en un repo (NR)
getArchivos(NR, NZ, Ar) :- 
    repositorio(NR, _, _, NZ, _),
    zona(NZ, Ar).


%nombre, autor, timestamp, zona, commit
gitInit(NR, NA, RO):-
    not(repositorio(NR, NA, _, _, _)),
    RO = repositorio(NR, NA, _, _, _).

%nombre, autor, timestamp, zona, commit
gitAdd(NR, Ar, RO):-
    zona("workspac", joinResults(NR, "workspace", "index"));
    RO = repositorio(NR, NA, TS, "workspace", ID_C),
    zona("workspac", Ar).
       
joinResults(NR, NZ1, NZ2, S):-
    getArchivos(NR, NZ1, S);
    getArchivos(NR, NZ2, S).


% adicionar un elemento de la cabeza de una lista
addhead(X, L, [X|L]).

% reune lo elementos en listas
getTodo(NR, RepoAsString):-
    repositorio(NR, NA, TS, NZ, ID_C),
    findall(Ar, zona(NZ, Ar), ArStr),
    addhead(NZ, ArStr, RepoAsString).

% repoAsString
%nombre, autor, timestamp, zona, commit
repoAsList(NR, RepoAsString):-
    repositorio(NR,NA,TS,_,_),
    findall(RS, getTodo(NR, RS), RAS),
    addhead(TS, RAS, RAS1),
    addhead(NA, RAS1, RAS2),
    addhead(NR, RAS2, RepoAsString).

% suma de los elementos de una lista
total([],0).
total([C|L],T):-
    total(L,T1),
    T is T1+C.

%gitAdd (repoinput, archivos, repooutput)
%gitAdd(repositorio(_,_,_,_), Ar, RO):-
%    repositorio()

