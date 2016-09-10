function newim = myDownsample(im)

im = imgaussfilt(im,0.66);
newim = im(1:2:end,1:2:end);

end
