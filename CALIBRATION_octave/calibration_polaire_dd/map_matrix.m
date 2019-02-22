% maps a vector in a matrix_type

function m = map_matrix(vec, offset)
    m(1,1) = vec(1+offset);
    m(1,2) = vec(3+offset);
    m(2,1) = vec(2+offset);
    m(2,2) = vec(4+offset);
end;
 