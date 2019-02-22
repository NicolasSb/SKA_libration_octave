
function U = mySVD(A)
  U = A;
  for i = 1:6
   UT = ctranspose(U);
   U = 1/2*(U + inv(UT));
  end