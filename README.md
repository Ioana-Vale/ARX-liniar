# ARX-liniar

Sunt create două figuri pentru reprezentarea grafică a datelor de identificare și de validare.

Identificarea modelului ARX:
-Se specifică ordinele pentru coeficienții AR (na) și coeficienții B (nb).
-Se extrag datele de intrare (u_id) și datele de ieșire (y_id) din setul de date de identificare (id).
-Se construiește matricea de regresie (phi_id) utilizând funcția buildMatrix.
-Parametrii modelului (theta) sunt estimați utilizând metoda celor mai mici pătrate (\).

Se calculează ieșirea estimată pentru datele de identificare (Y_id) utilizând matricea de regresie și parametrii estimați.
Se afișează rezultatele pentru datele de identificare.

Acelasi lucru se face pentru validare.

Se afișează rezultatele simulării, ieșirea modelului și datele reale.

Se utilizează funcția optimalOrderSelection pentru a testa diferite combinații ale ordinilor na și nb și pentru a afișa MSE asociat fiecăreia dintre aceste combinații.

buildMatrix: Construiește matricea de regresie pe baza datelor de intrare și ieșire și ordinilor AR și B specificate.
simulateModel: Simulează modelul ARX pe baza parametrilor estimați și a datelor de intrare.
calculateMSE: Calculează Mean Squared Error (MSE) între două seturi de date.
plotIdentificationResults și plotSimulationResults: Funcții auxiliare pentru afișarea rezultatelor identificării și simulării.
