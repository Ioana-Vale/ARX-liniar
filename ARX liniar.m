% Încărcarea datelor
load lab6_5 (2).mat;

% Reprezentarea grafică a datelor de identificare și validare
figure;
plot(id);
title('Date de identificare');

figure;
plot(val);
title('Date de validare');

% Identificarea modelului ARX
na = 9; % Numărul de coeficienți AR
nb = 9; % Numărul de coeficienți B
u_id = id.u;
y_id = id.y;
N_id = length(y_id);

% Construirea matricei de regresie pentru datele de identificare
phi_id = buildMatrix(u_id, y_id, na, nb);

% Estimarea parametrilor
theta = phi_id \ y_id;

% Calcularea ieșirii estimate pentru datele de identificare
Y_id = phi_id * theta;

% Afișarea rezultatelor pentru datele de identificare
figure;
plotIdentificationResults(Y_id, y_id, 'Date de identificare');
title('Date de identificare')

% Validarea modelului
u_val = val.u;
y_val = val.y;
N_val = length(y_val);

% Construirea matricei de regresie pentru datele de validare
phi_val = buildMatrix(u_val, y_val, na, nb);

% Calcularea ieșirii estimate pentru datele de validare
Y_val = phi_val * theta;

% Afișarea rezultatelor pentru datele de validare
figure;
plotIdentificationResults(Y_val, y_val, 'Date de validare');
title('Date de validare')

% Simularea modelului și calcularea MSE
y_sim = simulateModel(u_val, theta, na, nb);
MSE = calculateMSE(y_sim, y_val);

% Afișarea rezultatelor pentru simulare
figure;
plotSimulationResults(y_sim, Y_val, y_val, 'Iesire simulata vs Iesire model vs Iesire reala');
title('Iesire simulata vs Iesire model vs Iesire reala')

% Alegerea valorilor optime pentru na și nb
optimalOrderSelection(id,val);

% Funcții auxiliare

function phi = buildMatrix(u, y, na, nb)
    N = length(y);
    phi = zeros(N, na + nb);

    for k = 1:N
        for i = 1:na
            phi(k, i) = -y(max(1, k - i));
        end

        for i = 1:nb
            phi(k, i + na) = u(max(1, k - i));
        end
    end
end

function plotIdentificationResults(y_out, y, titleText)
    %figure;
    %title(titleText);
    hold on;
    plot(y_out);
   plot(y);
    hold off;
end

%Simulează modelul ARX pe baza parametrilor estimati și a datelor de intrare.
function y_sim = simulateModel(u, theta, na, nb)
    N_val = length(u);
    y_sim = zeros(N_val, 1);

    for k = 2:N_val
        sumay = 0;
        sumau = 0;

        for i = 1:na
            if (k - i > 0)
                sumay = sumay - theta(i) * y_sim(k - i);
            end
        end

        for i = 1:nb
            if (k - i > 0)
                sumau = sumau + theta(na + i) * u(k - i);
            end
        end

        y_sim(k) = sumay + sumau;
    end
end

function MSE = calculateMSE(y_sim, y_val)
    e = y_sim - y_val;
    MSE = (1 / length(y_val)) * sum(e.^2);
end

function plotSimulationResults(y_sim, y_out_val, y_val, titleText)
    %figure;
   % title(titleText);
    hold on;
    plot(y_sim);
    plot(y_out_val);
    plot(y_val);
    hold off;
end

%Alege valorile optime pentru na și nb prin testarea diferitelor combinații și afișarea MSE 
% asociat fiecăreia.

function optimalOrderSelection(id,val)
    for na = 1:30
        nb = na;
        u_id = id.u;
        y_id = id.y;
        N = length(y_id);

        phi_id = buildMatrix(u_id, y_id, na, nb);
        theta = phi_id \ y_id;

        u_val = val.u;
        y_val = val.y;

        M = length(y_val);

        phi_val = buildMatrix(u_val, y_val, na, nb);
        y_out_val = phi_val * theta;

        phi_sim = buildMatrix(u_val, y_out_val, na, nb);
        y_out_sim = phi_sim * theta;

        e = y_out_val - y_out_sim;
        MSE = calculateMSE(y_out_val, y_out_sim);

        %scatter(na, MSE);
        %hold on;
    end
end