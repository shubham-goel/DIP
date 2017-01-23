function res = myPCADenoising1( im, patch_size, var )
%myPCADenoising1 Denoises using PCA

% Constructing P
[m,n] = size(im);
N = (m-patch_size+1)*(n-patch_size+1);
P = zeros(patch_size^2, N);

for i = 1:m-patch_size+1
    for j = 1:n-patch_size+1
        P(:,(i-1)*(n-patch_size+1)+j) = reshape(im(i:i+patch_size-1,j:j+patch_size-1),[],1);
    end
end

% Finding Alpha_denoised
C = P*P';
[V,D] = eig(C);
Alpha = V'*P;
Alpha_mean = max(0,diag(Alpha*Alpha')/N-var);
fact = (((Alpha_mean/var).^(-1))+1).^(-1);
Alpha_Denoised = diag(fact)*Alpha;

im2_dat = zeros(m,n);
im2_cnt = zeros(m,n);

% Reconstruct denoised image
P = V*Alpha_Denoised;

for i = 1:m-patch_size+1
    for j = 1:n-patch_size+1
        im2_dat(i:i+patch_size-1,j:j+patch_size-1) = im2_dat(i:i+patch_size-1,j:j+patch_size-1) + reshape(P(:,(i-1)*(n-patch_size+1)+j),[],patch_size);
        im2_cnt(i:i+patch_size-1,j:j+patch_size-1) = im2_cnt(i:i+patch_size-1,j:j+patch_size-1) + 1;
    end
end

res = im2_dat./im2_cnt;
end

