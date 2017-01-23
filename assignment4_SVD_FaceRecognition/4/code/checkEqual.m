function tf = checkEqual( a,b )
% Compare elements of a and b, with relative error of 0.05
tf = (abs((a-b)./b));
tf(~isfinite(tf)) = 0;
tf = tf(:,:)<0.05;
end

