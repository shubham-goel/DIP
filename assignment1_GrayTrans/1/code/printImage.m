function printImage(im)
imshow(mat2gray(im));
if(size(im,3)>1)
    colormap(jet(200));
else
    colormap(gray(200));
end
axis tight;
axis on;
colorbar;
pause(5); 
end