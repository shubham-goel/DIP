function newIM = myPatchBasedFiltering(im, patchSize, windowSize, h)

digits(4);
[m,n] = size(im);
newIM = im;

%% Filter Image

% Gaussian mask for making patches more isotropic
patchStdDev = patchSize/4;
spaceMask = fspecial('gaussian', patchSize, patchStdDev);
imshow((mat2gray(spaceMask*255)));
axis tight;
% pause(5); 

% waitbar
wtbar = waitbar(0,'Please wait. Applying a patch based filter...');
for i=1:m
	waitbar(i / m)
	for j=1:n
        
        % Determine window for each pixel
		winLeft = max(i-floor(windowSize/2),1);
		winRight = min(i+floor(windowSize/2),m);
		winUp = max(j-floor(windowSize/2),1);
		winDown = min(j+floor(windowSize/2),n);

        % Determine patch boundries for pixel i,j
		PpatchLeft = max(i-floor(patchSize/2),1);
		PpatchRight = min(i+floor(patchSize/2),m);
		PpatchUp = max(j-floor(patchSize/2),1);
		PpatchDown = min(j+floor(patchSize/2),n);

		PoffLeft = min(floor(patchSize/2),i-1);
		PoffRight = min(floor(patchSize/2),m-i);
		PoffUp = min(floor(patchSize/2),j-1);
		PoffDown = min(floor(patchSize/2),n-j);

        % Patch for pixel i,j
		Ppatch = im(PpatchLeft:PpatchRight,PpatchUp:PpatchDown);
		weight = zeros(winRight-winLeft,winDown-winUp);
		weightI = zeros(winRight-winLeft,winDown-winUp);

        % Find correlation with all neighbouring patches inside window
        for iq=winLeft:winRight
            for jq=winUp:winDown
                if(iq~=i || jq~=j) % Consider different neighbourhoods only
                    
                    % Determine patch boundries for pixel i,j
                    QpatchLeft = max(iq-floor(patchSize/2),1);
                    QpatchRight = min(iq+floor(patchSize/2),m);
                    QpatchUp = max(jq-floor(patchSize/2),1);
                    QpatchDown = min(jq+floor(patchSize/2),n);

                    % Optimization for speeding things up
                    if ((QpatchUp-QpatchDown) == (PpatchUp-PpatchDown) && (QpatchLeft-QpatchRight) == (PpatchLeft-PpatchRight) && all(size(Ppatch)==[patchSize,patchSize]))
                        Qpatch = im(QpatchLeft:QpatchRight,QpatchUp:QpatchDown);
                        
                        % 2-norm of difference between more isotropic patches
                        nrm = norm((Qpatch-Ppatch).*spaceMask);
                    else
                        QoffLeft = min(floor(patchSize/2),iq-1);
                        QoffRight = min(floor(patchSize/2),m-iq);
                        QoffUp = min(floor(patchSize/2),jq-1);
                        QoffDown = min(floor(patchSize/2),n-jq);

                        PQoffLeft = min(PoffLeft,QoffLeft);
                        PQoffRight = min(PoffRight,QoffRight);
                        PQoffUp = min(PoffUp,QoffUp);
                        PQoffDown = min(PoffDown,QoffDown);

                        PpatchTemp = im(i-PQoffLeft:i+PQoffRight,j-PQoffUp:j+PQoffDown);
                        QpatchTemp = im(iq-PQoffLeft:iq+PQoffRight,jq-PQoffUp:jq+PQoffDown);
                        spaceMaskTemp = spaceMask(1+floor(patchSize/2)-PQoffLeft:1+floor(patchSize/2)+PQoffRight,1+floor(patchSize/2)-PQoffUp:1+floor(patchSize/2)+PQoffDown);

                        % 2-norm of difference between more isotropic patches
                        nrm = norm((QpatchTemp-PpatchTemp).*(spaceMaskTemp));
                    end
                    
                    % Computing weight and weight*Intensity
                    weight(iq-winLeft+1,jq-winUp+1) = exp(-((nrm/h)^2));
                    weightI(iq-winLeft+1,jq-winUp+1) = weight(iq-winLeft+1,jq-winUp+1)*im(iq,jq);
                end
            end
        end
        
        % Find new value of pixel i,j
		newIM(i,j) = sum(sum(weightI))/sum(sum(weight));
	end
end

close(wtbar);

end
