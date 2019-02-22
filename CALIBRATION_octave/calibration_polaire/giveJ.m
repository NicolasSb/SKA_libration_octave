function J = giveJ(gains, sky, na, n_pola)
    J = zeros(n_pola*na*(na-1), n_pola*na); %initialize an empty matrix at the right size
    LBL = list_baseline(na);                %create a matrix containing a list of baselines
    indexes = [0,2];                        % this tab will help us to put the right values 
                                            % at the right places
    for i = 1:na                               
      for j = 1:(na-1)                      %for each baselines
        q = LBL(2*(i-1)+j, 2);              %take the second antenna of the baseline
        if (n_pola ~=1)                     % if we do not have a scalar polarisation
          tmp = compute_tmp(gains, sky, q);   %compute one block component
          for l=1:n_pola                      %for each polarisation      
            index_r = indexes(floor((l-1)/2) + 1); %offset for raws
            index_c = indexes(mod((l-1), 2) + 1);  %offset for columns
            insert = tmp(floor((l-1)/2)+1, mod(l-1,2)+1); % in order : will take (0,0), (0,1), (1,0), (1,1)
                                                          % in the tmp matrix
            %set the value at the right places in the jacobian
            J((i-1)*(na-1)*n_pola + (j-1)*n_pola+index_r + 1, 4*(i-1)+index_c+1) = insert;
            J((i-1)*(na-1)*n_pola + (j-1)*n_pola +index_r + 2, 4*(i-1)+index_c+2) = insert;
          end;
        else                                % if the polarisation is scalar 
          J((i-1)*(na-1) + (j-1)+1,(i-1)+1) = gains(q+1);
        end;
      end; 
    end;   
 end;