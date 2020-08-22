%Dominios
%	employee(X,Y,Z) symbol
%	department(A,B) symbol.

%Predicados
%	rrhhEmployee(E)			aridad = 4
%	expensiveEmployee(E)	aridad = 1
%	salaryByEmployee(E, S)	aridad = 2
%	salary(X,Y)				aridad = 2
%	department(X,Y)			aridad = 2
%	employee(E,Y,Z).		aridad = 3

%Metas
%	Primarias
%		salaryByEmployee(E, S)
%		expensiveEmployee(E)
%		rrhhEmployee(E)
%	Secundarias
%		employee(X,T,Z).
%		department(X,Y).
%		salary(X,Y).

%Cláusulas
%Hechos, axiomas, verdades, base de conocimiento, base de datos
employee(mcardon,1,5).
employee(treeman,2,3).
employee(chapman,1,2).
employee(claessen,4,1).
employee(petersen,5,8).
employee(cohn,1,7).
employee(duffy,1,9).
department(1,board).
department(2,human_resources).
department(3,production).
department(4,technical_services).
department(5,administration).
salary(1,1000).
salary(2,1500).
salary(3,2000).
salary(4,2500).
salary(5,3000).
salary(6,3500).
salary(7,4000).
salary(8,4500).
salary(9,5000).

%Reglas
salaryByEmployee(E, S) :- employee(E, _, S_ID), salary(S_ID, S).
expensiveEmployee(E) :- salaryByEmployee(E, SAL), SAL >= 3000.
rrhhEmployee(E) :- department(ID_D, human_resources), employee(E, ID_D, _).
employeeDepartamentSalary(E, EMPLEADO, SALARYTOTAL, SalaryFrom,SalaryUP) :- department(ID_D, E), employee(EMPLEADO, ID_D, W), salary(W,SALARYTOTAL), SALARYTOTAL > SalaryFrom, SALARYTOTAL < SalaryUP .
%employeeDepartamentSalary(E, EMPLEADO, SalaryFrom) :- department(ID_D, E), employee(EMPLEADO, ID_D, W), salary(W,SALATYTOTAL), SALATYTOTAL >= SalaryFrom.

inexpensiveEmployee(Empl) :- salaryByEmployee(Empl,S), not(expensiveEmployee(Empl)).

