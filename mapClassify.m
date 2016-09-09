function classification = mapClassify(feature, mean, covar, prior)
    classification = log(prior) - 0.5*log(det(covar)) - 0.5*((feature-mean)*inv(covar)*(feature-mean).');
end

