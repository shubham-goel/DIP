function printImage(im)
if(size(im,3)>1)
	size(im)
	imshow(im);
    colormap(jet(200));
else
	imshow(mat2gray(im));
    colormap(gray(200));
end
axis tight;
axis on;
colorbar;
pause(5); 
end