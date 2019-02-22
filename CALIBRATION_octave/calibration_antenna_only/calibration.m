
na = 40;    %number of antenna
iter = 50;  %number of iterations
lambda = 0.5;%damping coefficient

observation = complex(rand(na, 1), rand(na, 1)); %random vector used to create visibilities
      %used also for testing the result but does not take part of the computation

dg = complex(rand(na, 1), rand(na, 1)); %random guess
tic
observation = norm(observation);
%dg = (dg+ observation);

J = Jacobien(observation, na);

data = J * observation; % these are the visibilities
%dg = norm(dg);

plot_r = zeros(na, iter);  
plot_im  = zeros(na, iter);



for i = 1:iter
  J = Jacobien(dg, na); %Jacobian on our guess
  H = ctranspose(J)*J; %Hessian matrix (diagonal and real)
  dg = (lambda/(lambda+1)) * dg + 1/(lambda+1) * inv(H) *ctranspose(J)*data;
  %applying the formula and injecting visibilities
  dg = norm(dg); %take the first antenna as a reference
  
  plot_r(:,i) = real(abs(observation - dg));
  plot_im(:,i) = abs(imag(observation - dg))';
end;
toc
x = 1:1:iter;             %vector used for the plots


plot_r(1,:) = 0; %so that the machine precision doesnt spoil the plot
plot_im(1,:) = 0;

%plots the accuracy of the computing
figure
subplot(121);
semilogy(x, plot_r,'k');
xlabel('\fontsize{10} Iteration');
ylabel('\fontsize{10} Residual Amplitude');

subplot(1,2,2);
semilogy(x ,plot_im,'k');
xlabel('\fontsize{10} Iteration');
ylabel('\fontsize{10} Residual phase');