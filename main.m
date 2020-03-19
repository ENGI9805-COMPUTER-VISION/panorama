images = cell(1, 2);
images{1} = imread('img/uttower/left.jpg');
images{2} = imread('img/uttower/right.jpg');

[result, H, num_inliers, residual] = ...
    stitch_images(images, 5, 5, 0.03, 1, 100, 4000);

imshow(result);