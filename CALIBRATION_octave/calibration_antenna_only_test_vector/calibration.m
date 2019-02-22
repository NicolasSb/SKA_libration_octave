
na = 3;
iter = 1;

observation = [0.19078 + 0.90151i; 0.21209 + 0.54550i; 0.30087 + 0.14163i];
dg = [0.48679 + 0.05623i; 0.11108 + 0.02649i; 0.61440 + 0.29708i];

observation = norm(observation);
dg = dg + observation;

J = Jacobien(observation, na);

data = J * observation
dg = norm(dg);

save = zeros(na, iter);

for i = 1:iter
  J = Jacobien(dg, na)
  H = ctranspose(J)*J
  Hinv = inv(H);
  ctranspose(J)
  temp = ctranspose(J)*data
  dg = 0.33* dg + 0.67 * Hinv * temp
  dg = norm(dg);
  save(:, i) = dg;
end


save

res = observation - dg