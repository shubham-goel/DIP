function [mse_value] = mse(imgorig,img)
    mse_value=mean(mean(mean((imgorig-img).^2)))
end