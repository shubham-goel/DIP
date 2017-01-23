function newim = myDownsample(im)
    im = imgaussfilt(im(:,:,:),1);
    newim = im(1:2:end,1:2:end,:);
end
