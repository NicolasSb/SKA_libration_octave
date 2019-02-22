function A = norm(mat)
  A = mat.*(1/mat(1,1));
  s1 = mat(1,1);
  s2 = mat(2,1);
  for i = 1:6:2
    mat(i,1) = mat(i,1)/s1;
    mat(i+1,1) = mat(i+1,1)/s2;
  end
  A = mat;
end 