function J = Jacobien(mat, na)
  J = zeros(na*(na-1),na);
  for i=1:na
    for j=1:na-1
      if i>j
        J((na-1)*(i-1)+j, i) = conj(mat(j));
      else if i<=j
        J((na-1)*(i-1)+j, i) = conj(mat(j+1));
      end
    end
  end
end