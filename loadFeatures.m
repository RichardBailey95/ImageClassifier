function featureMatrix = loadFeatures(imageSeq, numberOfImages, cutoff)
    %% Populate the featureVectors cell with the feature vectors of all the
    %% loaded images to generate a matrix of feature vectors.
    featureVectorsCell = cell(1,numberOfImages); % A cell to hold the full feature vectors for all images.
    % A for loop that iterates over each image and generates the chain code,
    % and then the feature vector.
    for imgNo = 1:numberOfImages
        image = imageSeq{imgNo};
        image = logical(image);
        c = chainCode(image);
        %% filter using the FT of the angles of the chaincode
        angles = c(3,:)*(2*pi/8);
        anglesFFT = fft(angles); %fast fourier transform

        % Filter using a 'top hat' filter. The filter conists of the value one for 
        %the lowest Nfrequencies and zero elsewhere.
        N = 30; %number of lowest frequencies to keep
        filter = zeros(size(angles)); 

        %Both the positive and negative low frequencies must be kept
        %filter(1) is the zero (DC) frequency, so there will be (N*2)-1 ones in
        %total
        filter(1:N) = 1; 
        filter(end-N+2:end) = 1;

        filteredFFT = anglesFFT .* filter; % Apply the filter by scalar multipliacation

        featureVectorsCell{imgNo} = abs(filteredFFT); % Put the feature vectors into the cell.
    end
    
    featureMatrix = zeros(numberOfImages, cutoff);
    for iter = 1:numberOfImages
        featureMatrix(iter,:) = featureVectorsCell{iter}(1:cutoff);
    end
end

