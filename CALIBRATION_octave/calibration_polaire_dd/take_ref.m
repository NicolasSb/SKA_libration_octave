function y = take_ref(gains, na)
      if 1
        a = zeros(2);
        a=map_matrix(gains,0);
        
        
        %[us, s, v] = svd(a);     
        %u = us * ctranspose(v);
        
        u = mySVD(a);
        a=a*ctranspose(u);

        for i = 1:na
          a=map_matrix(gains,(i-1)*4);
          a=a*ctranspose(u);
          gains(4*(i-1) + 1) = a(1,1);
          gains(4*(i-1) + 2) = a(2,1);
          gains(4*(i-1) + 3) = a(1,2);
          gains(4*(i-1) + 4) = a(2,2);
        end;
        y = gains;
      end;
end;