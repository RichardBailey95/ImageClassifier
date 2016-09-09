function mean = calcMean(featureMatrix, numberOfImages, cutoff)
    %% Calculate the mean by adding each row together and then dividing by the
    %% by the number of rows.
    mean = zeros(1, cutoff);
    for iter = 1:numberOfImages
        mean = mean + featureMatrix(iter,:);
    end
    mean = mean/numberOfImages;
end

