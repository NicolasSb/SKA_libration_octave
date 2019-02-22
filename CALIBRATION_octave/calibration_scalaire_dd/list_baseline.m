function LBL = list_baseline(na)
  for i=1:na*na
      A(i) = mod(i, na); %for na = 3 : 0,1,2,0,1,2,0,1,2
      B(i) = floor(i/na);%for na = 3 : 0,0,0,1,1,1,2,2,2
  end;
  count = 1; 
  for i =1:na*na 
   if(A(i) ~= B(i)) %if A[i] != B[i] save the current line in lbl
     LBL(count, 1) = B(i);
     LBL(count, 2) = A(i);
     count = count +1 ;
   end;
  end;
end;

%for na = 3 we obtain :
%  0  1
%  0  2
%  1  0
%  1  1
%  2  0
%  2  1

% the first column represent the index of the first antenna of the baseline
% the second column is the second antenna of the baseline ..