na = 3;         %number of antenna
n_pola = 4;     %number of polarisations
n_iter = 100;   %number of iterations

tic

damp = 0.5;     %damping coefficient 

gTrue = [0.425823 + 0.758928i;
   0.736963 + 0.348578i;
   0.065215 + 0.132876i;
   0.466039 + 0.758798i;
   0.991491 + 0.905005i;
   0.829719 + 0.657109i;
   0.572134 + 0.343622i;
   0.865294 + 0.829858i;
   0.016707 + 0.028062i;
   0.348541 + 0.912481i;
   0.154412 + 0.154412i;
   0.404196 + 0.179453i]; %create a random vector

dG = [0.074284 + 0.896047i;
   0.743462 + 0.536599i;
   0.213472 + 0.632637i;
   0.238932 + 0.018893i;
   0.889041 + 0.343798i;
   0.882164 + 0.698514i;
   0.611875 + 0.863121i;
   0.531024 + 0.797096i;
   0.497339 + 0.653385i;
   0.918741 + 0.511386i;
   0.906306 + 0.000533i;
   0.591349 + 0.600630i];

%take the first antenna as a reference
dG = dG + gTrue;
gTrue = take_ref(gTrue, na);

dG = take_ref(dG, na);

skyC = [1.0012e+00 + 1.0032e+00i,   3.6935e-03 + 4.8009e-03i;
   5.9376e-04 + 7.3177e-04i,   1.0029e+00 + 1.0046e+00i];

J = giveJ(gTrue, skyC, na, n_pola);  %compute the jacobian

v = J * gTrue;          % compute the visibilities

%initialise the storage matrix for the plots
plot = zeros(na*n_pola, n_iter);

%beginning of the LM algorithm
for i = 1:1:n_iter

    J0 = giveJ(dG, skyC, na, n_pola);
    Jt = ctranspose(J0);
    H = Jt * J0;
    
    Jv = Jt*v;
    Hinv = inv(H);
    tmp = 0.67*Hinv*Jv;
    dG = 0.33*dG + tmp;
    
    dG = take_ref(dG, na);%take the first antenna of our estimation as a reference  
    % saving data to plot later
    plot(:,i) = dG;
end;
toc
plot ;

res = gTrue- dG
x = 1:1:n_iter;             %vector used for the plots
%plot
%{
figure
subplot(121);
semilogy(x, plot_r,'k');
xlabel('\fontsize{15} Iteration');
ylabel('\fontsize{15} Residual Amplitude');

subplot(1,2,2);
semilogy(x ,plot_im,'k');
xlabel('\fontsize{15} Iteration');
ylabel('\fontsize{15} Residual phase');
%}