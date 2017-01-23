function [segmented_img] = myMeanShiftSegmentation(img,hr,hs,neighbours,numIter)

    [m,n,z] = size(img);
    segmented_img=double(zeros(m,n,z));
    
    % Get 5D feature vector for each pixel
    imgPos=zeros(m*n,2);
    for i=1:m
        for j=1:n
            imgPos(i+(j-1)*m,:)=[i/hs,j/hs];
        end
    end
    imgVec=horzcat(reshape(img,m*n,3)./hr,imgPos);
    
    for interation=1:numIter
        [IDX,D]=knnsearch(imgVec,imgVec,'k',neighbours);
        imgVecNew = imgVec;
        for i = 1:m
            for j = 1:n
                % Generate weights using distances
                weights = exp(-(D(i+(j-1)*m,:).^2)/2)';
                
                % Update pixel features
                diff = ((imgVec(IDX(i+(j-1)*m,:),:)' * weights)./sum(weights) - imgVec(i+(j-1)*m,:)');
                imgVecNew(i+(j-1)*m,:) = imgVec(i+(j-1)*m,:) + diff'.*1;
                
            end
        end
        imgVec = imgVecNew;

    end
    
    for i=1:m
        for j=1:n
            segmented_img(i,j,:)=imgVec(i+(j-1)*m,1:3).*hr;
        end
    end
end