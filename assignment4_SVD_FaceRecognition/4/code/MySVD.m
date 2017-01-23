function [ U, V, S ] = MySVD( A )
[U, S2] = eig(A*A');
[V, S3] = eig(A'*A);

U = fliplr(U);
V = fliplr(V);
S2 = fliplr(fliplr(S2)');

S = S2.^(0.5);
V = V - 2*V.*checkEqual(A*V,-U*S);
S=diag(S);
end

