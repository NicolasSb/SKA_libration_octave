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


%{

each column of the Jacobien corresponds to one single antenna.
For each of them you just have to write in place 
(offset = current antenna * Number of antenna -1)
the gains from the other antennae.

3 antenna example : 

g = [ g1 g2 g3]

J = [g2 0 0; g3 0 0; 0 g1 0; 0 g3 0; 0 0 g1; 0 0 g2]

%}
