% Dependencies:
%           VLFeat        - Download at http://www.vlfeat.org/download.html

object = 'uttower'; % options are hill, ledge, pier, uttower
image1 = imread(['img/', object, '/left.jpg']);
image2 = imread(['img/', object, '/right.jpg']);

[result, H, num_inliers, residual] = ...
    stitch_pair(image1, image2, 5, 5, 0.03, 1, 100, 4000);

imshow(result);
imwrite(result, ['result/', object, '.jpg']);