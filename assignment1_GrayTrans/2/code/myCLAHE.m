function newim = myCLAHE(im, m, n, upper_cap)
% Assumes n,m are odd
if(rem(m,2) == 0)
	m = m+1;
end
if(rem(n,2) == 0)
	n = n+1;
end

disp('Started CLAHE')

digits(4);
[M, N, K] = size(im);
edges = 0:256;

offsetM = (m-1)/2;
offsetN = (n-1)/2;

assert(offsetM<M);
assert(offsetN<N);

newim = im;
for k = 1:K
    for i = 1:M
        i_start = max(i-offsetM, 1);
        i_end = min(i+offsetM, M);
        pdf = histcounts(im(i_start:i_end,1:offsetN,k),edges)';
        pixels = (i_end-i_start+1)*offsetN;
        
        for j = 1:N   
            if (j-1>offsetN)
                pdf = pdf - histcounts(im(i_start:i_end,j-offsetN-1,k),edges)';
            end
            if (N-j>offsetN)
                pdf = pdf + histcounts(im(i_start:i_end,j+offsetN,k),edges)';
            end

            if ~(j-1>offsetN) && (N-j>offsetN)
                pixels = pixels + (i_end-i_start+1);
            end
            if (j-1>offsetN) && ~(N-j>offsetN)
                pixels = pixels - (i_end-i_start+1);
            end

            cl_pdf = pdf;
            excess = 0;
            for intensity = 1:256
                if cl_pdf(intensity) > upper_cap*pixels
                    excess = excess + cl_pdf(intensity) - upper_cap*pixels;
                    cl_pdf(intensity) = upper_cap*pixels;
                end
            end

            excess_temp = excess*((im(i,j,k)+1)/256);
            mera_sum = (sum(cl_pdf(1:(im(i,j,k)+1))));
            temp_cdf = mera_sum + double(excess_temp);
            newim(i,j,k) = round(temp_cdf*(255/pixels));
        end
    end
end

disp('Finished CLAHE')

end
