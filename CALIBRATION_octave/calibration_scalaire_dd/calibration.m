na = 40;    %number of antenna
n_dir = 5;
iter = 1;  %number of iterations
lambda = 0.5;%damping coefficient

observation = complex(rand(na*n_dir, 1), rand(na*n_dir, 1)); %random vector used to create visibilities
      %used also for testing the result but does not take part of the computation

dg = complex(rand(na*n_dir, 1), rand(na*n_dir, 1)); %random guess
tic
observation = norm(observation);
%dg = (dg+ observation);

J = Jacobien(observation, na, n_dir);

data = J * observation; % these are the visibilities
dg = norm(dg + observation);

plot_r_1 = zeros(na, iter);  
plot_im_1  = zeros(na, iter);
plot_r_2 = zeros(na, iter);  
plot_im_2  = zeros(na, iter);

for i = 1:iter
  J = Jacobien(dg, na, n_dir); %Jacobian on our guess
  Jt = ctranspose(J);
  %C = covariance(data, na*(na-1));
  %Cinv = inv(C);
  H = Jt*J                    %Hessian matrix (diagonal and real)
  K = H + lambda*diag(diag(H));
  Kinv = inv(K);
  
  dataDg = data - J * dg;
  dg0 = Kinv * Jt * dataDg;
  dg = dg+dg0;
  %applying the formula and injecting visibilities
  dg = norm(dg); %take the first antenna as a reference
  
  for j = 1:na
    count = 1;
    plot_r_1(j,i) = real(abs(observation(2*(j-1)+1,1) - dg(2*(j-1)+1,1)));
    plot_im_1(j,i) = abs(imag(observation(2*(j-1)+1,1) - dg(2*(j-1)+1,1)))';
    plot_r_2(j,i) = real(abs(observation(2*(j-1)+2,1) - dg(2*(j-1)+2,1)));
    plot_im_2(j,i) = abs(imag(observation(2*(j-1)+2,1) - dg(2*(j-1)+2,1)))';
    count = count+2;
  end
end;
toc
x = 1:1:iter;             %vector used for the plots

plot_r_1(1,:) = 0;
plot_im_1(1,:) = 0;

plot_r_2(1,:) = 0;
plot_im_2(1,:) = 0;
%plots the accuracy of the computing

figure
subplot(221);
semilogy(x, plot_r_1,'k');
xlabel('\fontsize{10} Iteration');
ylabel('\fontsize{10} Residual Amplitude');

subplot(223);
semilogy(x ,plot_im_1,'k');
xlabel('\fontsize{10} Iteration');
ylabel('\fontsize{10} Residual phase');

subplot(222);
semilogy(x, plot_r_2,'k');
xlabel('\fontsize{10} Iteration');
ylabel('\fontsize{10} Residual Amplitude');

subplot(224);
semilogy(x ,plot_im_2,'k');
xlabel('\fontsize{10} Iteration');
ylabel('\fontsize{10} Residual phase');