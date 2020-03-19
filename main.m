images = cell(1, 2);
object = 'ledge';
images{1} = imread(['img/', object, '/left.jpg']);
images{2} = imread(['img/', object, '/right.jpg']);

[result, H, num_inliers, residual] = ...
    stitch_images(images, 5, 5, 0.03, 1, 100, 4000);

imshow(result);
imwrite(result, ['result/', object, '.jpg']);