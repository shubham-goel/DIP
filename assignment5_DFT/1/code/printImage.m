function printImage( im, tt )

figure
imagesc(double(im));
colormap(gray(200));
daspect([1 1 1]);
axis tight;
axis on;
colorbar;
title(tt);
% waitforbuttonpress;
pause(3);

end

