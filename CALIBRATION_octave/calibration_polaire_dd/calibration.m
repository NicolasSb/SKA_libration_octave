na = 3;         %number of antenna
n_pola = 4;     %number of polarisations
n_dir = 2;
n_iter = 100;   %number of iterations



tic

damp = 0.5;     %damping coefficient 

gTrue = complex(rand(na*n_dir*n_pola, 1),rand(na*n_dir*n_pola, 1));%create a random vector

dG = complex(rand(na*n_dir*n_pola, 1), rand(na*n_dir*n_pola, 1));

%take the first antenna as a reference
dG = dG + gTrue;
gTrue = take_ref(gTrue, na);

dG = take_ref(dG, na);

skyC = complex(rand(2, 2), rand(2,2)); %create a random sky coherency model
skyC = skyC + 2000*diag(diag(skyC));
skyC = skyC ./ 2000; % sky model is most of the time almost diagonal


J = giveJ(gTrue, skyC, na, n_dir, n_pola);  %compute the jacobian

v = J * gTrue;              % compute the visibilities

%initialise the storage matrix for the plots
plot_r = zeros(n_iter, na*n_pola*n_dir);  
plot_im  = zeros(n_iter, na*n_pola*n_dir);
theoretical_r = zeros(n_iter, na*n_pola*n_dir);
theoretical_im = zeros(n_iter, na*n_pola*n_dir);

%beginning of the LM algorithm
for i = 1:1:n_iter
    J0 = giveJ(dG, skyC, na, n_dir, n_pola);
    Jt = ctranspose(J0);
    H = Jt * J0;
    K = H + damp*diag(diag(H));
    Kinv = inv(K);
    
    dataDg = v - J0*dG;
    
    tmpMat = Jt * dataDg;
    
    dg0 = Kinv * tmpMat;
    dG = dG + dg0;
    
    dG = take_ref(dG, na);%take the first antenna of our estimation as a reference  
    % saving data to plot later
    plot_r(i,:) = real(abs(gTrue - dG));
    plot_im(i,:) = abs(imag(gTrue - dG))';
end;
toc
x = 1:1:n_iter;             %vector used for the plots
%plot

figure
subplot(121);
semilogy(x, plot_r,'k');
xlabel('\fontsize{15} Iteration');
ylabel('\fontsize{15} Residual Amplitude');

subplot(1,2,2);
semilogy(x ,plot_im,'k');
xlabel('\fontsize{15} Iteration');
ylabel('\fontsize{15} Residual phase');