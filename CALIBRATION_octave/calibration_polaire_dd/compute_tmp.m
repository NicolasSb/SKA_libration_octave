%compute a matrix 2*2 representing one block of the jacobian

function tmp = compute_tmp(gains, sky, antenna, dir, n_dir)
  for i = 1:2
    for j = 1:2
      tmp1 = conj(gains(4*antenna*n_dir + 4*(dir-1) + i, 1)); %take g at polarisation i
      tmp2 = conj(gains(4*antenna*n_dir + 4*(dir-1)+i+2,1)); %take g at pola i+2
      tmp1 = tmp1 * sky(j,1);                  %scale by the right sky model pola
      tmp2 = tmp2 * sky(j,2);
      tmp(i,j) = (tmp1 + tmp2);            % sum both and scale by 0.5
      %                                       because of the wirtinger approx
    end;
  end;
end;