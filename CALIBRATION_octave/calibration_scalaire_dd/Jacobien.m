
function J = Jacobien(mat, na, n_dir)
    J = zeros(na*(na-1), na*n_dir);         %initialize an empty matrix at the right size
    LBL = list_baseline(na);                %create a matrix containing a list of baselines
                                            % at the right places
    for i = 1:na                               
      for j = 1:(na-1)                      %for each baselines
        q = LBL((i-1)*(na-1)+j, 2);   
        for dir = 1:n_dir         
          J((i-1)*(na-1) + (j-1) + 1,n_dir*(i-1)+(dir-1) +1) = conj(mat(q*n_dir+dir));
        end;
      end; 
    end;
 end;
%{

each column of the Jacobien corresponds to one single antenna.
For each of them you just have to write in place 
(offset = current antenna * Number of antenna -1)
the gains from the other antennae.

3 antenna example : 

g = [ g1 g2 g3]

J = [g2 0 0; g3 0 0; 0 g1 0; 0 g3 0; 0 0 g1; 0 0 g2]

%}
