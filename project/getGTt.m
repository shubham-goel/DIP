function [GTt]=getGTt(T,window_size,t,pseudo)
    [x,y]=meshgrid(floor(window_size/2):-1:-floor(window_size/2),floor(window_size/2):-1:-floor(window_size/2));
    
    if(pseudo==0)
        Tinv=inv(T);
    else
        Tinv=pinv(T);
    end
        
    GTt=exp(-(x.^2*Tinv(1,1)+y.^2*Tinv(2,2)+x.*y*(Tinv(1,2)+Tinv(2,1)))/(4*t))/(4*pi*t);
    GTt = GTt./sum(sum(GTt));
end