function proj1_516


readAoA(-2);

% Cl, Cd, Cm, L/D and compare against Xfoil
% table of the above values vs AoA

end

function readAoA(AoA)

A = importdata([num2str(AoA), '_deg/report-drag-rfile.out']);

end