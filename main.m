clear;
close all;

cutoff = 8; % CHANGE THIS TO DETERMINE HOW MANY FEATURES ARE ANALYZED

percent = 79; % CHANGE THIS TO DETERMINE WHAT PERCENTAGE OF THE IMAGES ARE USED AS TRAINING

% Load aliens
imageSeq_Aliens = loadImages('Alien');
numberOfImages_Aliens = length(imageSeq_Aliens);
numberOfImages_Aliens = floor(numberOfImages_Aliens * percent / 100);
featureMatrix_Aliens = loadFeatures(imageSeq_Aliens, numberOfImages_Aliens, cutoff);
mean_Aliens = calcMean(featureMatrix_Aliens, numberOfImages_Aliens, cutoff);
covar_Aliens = calcCovar(featureMatrix_Aliens, numberOfImages_Aliens, mean_Aliens, cutoff);
disp('Alien gaussian created');

% Load butterflys
imageSeq_Butterfly= loadImages('Butterfly');
numberOfImages_Butterfly = length(imageSeq_Butterfly);
numberOfImages_Butterfly= floor(numberOfImages_Butterfly * percent / 100);
featureMatrix_Butterfly = loadFeatures(imageSeq_Butterfly, numberOfImages_Butterfly, cutoff);
mean_Butterfly = calcMean(featureMatrix_Butterfly, numberOfImages_Butterfly, cutoff);
covar_Butterfly = calcCovar(featureMatrix_Butterfly, numberOfImages_Butterfly, mean_Butterfly, cutoff);
disp('Butterfly gaussian created');

% Load faces
imageSeq_Face = loadImages('Face');
numberOfImages_Face = length(imageSeq_Face);
numberOfImages_Face = floor(numberOfImages_Face * percent / 100);
featureMatrix_Face = loadFeatures(imageSeq_Face, numberOfImages_Face, cutoff);
mean_Face = calcMean(featureMatrix_Face, numberOfImages_Face, cutoff);
covar_Face = calcCovar(featureMatrix_Face, numberOfImages_Face, mean_Face, cutoff);
disp('Face gaussian created');

% Load stars
imageSeq_Star = loadImages('Star');
numberOfImages_Star = length(imageSeq_Star);
numberOfImages_Star = floor(numberOfImages_Star * percent / 100);
featureMatrix_Star = loadFeatures(imageSeq_Star, numberOfImages_Star, cutoff);
mean_Star = calcMean(featureMatrix_Star, numberOfImages_Star, cutoff);
covar_Star = calcCovar(featureMatrix_Star, numberOfImages_Star, mean_Star, cutoff);
disp('Star gaussian created');

% Calculate priors
totalImages = numberOfImages_Aliens + numberOfImages_Butterfly + numberOfImages_Face + numberOfImages_Star;
prior_Aliens = numberOfImages_Aliens / totalImages;
prior_Butterfly = numberOfImages_Butterfly / totalImages;
prior_Face = numberOfImages_Face / totalImages;
prior_Star = numberOfImages_Star / totalImages;

% Classify
confusionMatrix = zeros(4,4);

for iterate = numberOfImages_Aliens+1:length(imageSeq_Aliens)
    featureVector = loadFeatures(imageSeq_Aliens(iterate), 1, cutoff);
    mapClassify_Aliens = mapClassify(featureVector, mean_Aliens, covar_Aliens, prior_Aliens);
    mapClassify_Butterfly = mapClassify(featureVector, mean_Butterfly, covar_Butterfly, prior_Butterfly);
    mapClassify_Face = mapClassify(featureVector, mean_Face, covar_Face, prior_Face);
    mapClassify_Star= mapClassify(featureVector, mean_Star, covar_Star, prior_Star);
    class = [mapClassify_Aliens, mapClassify_Butterfly, mapClassify_Face, mapClassify_Star];
    X = 1;
    for iterate2 = 2:4
        if class(iterate2) > class(X)
            X = iterate2;
        end
    end
    confusionMatrix(1,X) = confusionMatrix(1,X) + 1;
end

for iterate = numberOfImages_Butterfly+1:length(imageSeq_Butterfly)
    featureVector = loadFeatures(imageSeq_Butterfly(iterate), 1, cutoff);
    mapClassify_Aliens = mapClassify(featureVector, mean_Aliens, covar_Aliens, prior_Aliens);
    mapClassify_Butterfly = mapClassify(featureVector, mean_Butterfly, covar_Butterfly, prior_Butterfly);
    mapClassify_Face = mapClassify(featureVector, mean_Face, covar_Face, prior_Face);
    mapClassify_Star= mapClassify(featureVector, mean_Star, covar_Star, prior_Star);
    class = [mapClassify_Aliens, mapClassify_Butterfly, mapClassify_Face, mapClassify_Star];
    X = 1;
    for iterate2 = 2:4
        if class(iterate2) > class(X)
            X = iterate2;
        end
    end
    confusionMatrix(2,X) = confusionMatrix(2,X) + 1;
end

for iterate = numberOfImages_Face+1:length(imageSeq_Face)
    featureVector = loadFeatures(imageSeq_Face(iterate), 1, cutoff);
    mapClassify_Aliens = mapClassify(featureVector, mean_Aliens, covar_Aliens, prior_Aliens);
    mapClassify_Butterfly = mapClassify(featureVector, mean_Butterfly, covar_Butterfly, prior_Butterfly);
    mapClassify_Face = mapClassify(featureVector, mean_Face, covar_Face, prior_Face);
    mapClassify_Star= mapClassify(featureVector, mean_Star, covar_Star, prior_Star);
    class = [mapClassify_Aliens, mapClassify_Butterfly, mapClassify_Face, mapClassify_Star];
    X = 1;
    for iterate2 = 2:4
        if class(iterate2) > class(X)
            X = iterate2;
        end
    end
    confusionMatrix(3,X) = confusionMatrix(3,X) + 1;
end

for iterate = numberOfImages_Star+1:length(imageSeq_Star)
    featureVector = loadFeatures(imageSeq_Star(iterate), 1, cutoff);
    mapClassify_Aliens = mapClassify(featureVector, mean_Aliens, covar_Aliens, prior_Aliens);
    mapClassify_Butterfly = mapClassify(featureVector, mean_Butterfly, covar_Butterfly, prior_Butterfly);
    mapClassify_Face = mapClassify(featureVector, mean_Face, covar_Face, prior_Face);
    mapClassify_Star= mapClassify(featureVector, mean_Star, covar_Star, prior_Star);
    class = [mapClassify_Aliens, mapClassify_Butterfly, mapClassify_Face, mapClassify_Star];
    X = 1;
    for iterate2 = 2:4
        if class(iterate2) > class(X)
            X = iterate2;
        end
    end
    confusionMatrix(4,X) = confusionMatrix(4,X) + 1;
end

confusionMatrix
accuracy = confusionMatrix(1,1) + confusionMatrix(2,2) + confusionMatrix(3,3) + confusionMatrix(4,4);
accuracy = accuracy / sum(sum(confusionMatrix))