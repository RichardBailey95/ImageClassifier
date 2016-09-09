function covariance = calcCovar(featureMatrix, numberOfImages, mean, cutoff)
    %% Calculate the covariance by finding the distance from the mean for each
    %% feature in each feature vector.
    covariance = (1/numberOfImages)*featureMatrix'*featureMatrix - mean'*mean;
end

