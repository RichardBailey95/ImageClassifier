function imageSeq = loadImagesT(name)
    %% Load all the Alien images into the program.
    imgPath = 'Images/Test/';
    if exist(imgPath, 'dir') == 0
        disp('Error: Image directory set incorrectly');
        return;
    end
    imgType = strcat('/',name,'*.gif'); % Loads all images with this name - all the aliens
    images  = dir([imgPath imgType]);
    numberOfImages = length(images);
    imageSeq = cell(1,numel(images));
    for idx = 1:numberOfImages
        tempimg = imread([imgPath images(idx).name]);
        imageSeq{idx} = tempimg;
    end
end

