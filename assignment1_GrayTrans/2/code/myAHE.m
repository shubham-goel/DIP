function newim = myAHE(im, m, n)

digits(4);
[M, N, K] = size(im)
padd = floor(([m n] + 1)/2);
a = zeros(padd(1), N, K) -1;
newim = [a;im;a];
a = zeros(M + padd(1)*2, padd(2), K) - 1;
newim = [a,newim,a];
size(newim)
fun2 = @(x,y) x(1, y+1);
fun = @(x) fun2(myCDF(x),x(padd(1), padd(2)));
for k = 1:size(newim,3)
    im1 = newim(:,:,k);
    newim(:,:,k) = nlfilter(im1, [m n], fun);
end
