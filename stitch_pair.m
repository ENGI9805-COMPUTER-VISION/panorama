function [result_img, H, num_inliers, residual] = ...
    stitch_pair (image, target_image, sift_r, harris_r, harris_thresh, harris_sigma, num_putative_matches, ransac_n)
% STITCH_PAIR - Given a set of images with overlapping regions,
%                 automatically compute a panorama image.
%
% Usage:    [result_img, H, num_inliers, residual] ...
%               = stitch_images (images, sift_r, harris_r, ...
%               harris_thresh, harris_sigma, num_putative_matches, ransac_n)
%
% Usage example:
%           stitch_images(images, 5, 5, 0.03, 1, 100, 4000)
%
% Arguments:
%           images        - 1 by n cell array of images.
%           sift_r        - radius of the SIFT descriptor.
%           harris_r      - radius of the Harris corner detector.
%           harris_thresh - Harris corner detector threshold.
%           harris_sigma  - standard deviation of smoothing Gaussian
%           num_putative_matches  - number of putative matches to run
%                                   RANSAC.
%           ransac_n      - number of RANSAC iterations.
%
% Returns:
%           result_img    - Computed paranoma image.
%           H             - n by n cell array of homography matrices.
%                           H{i, j} is the homography matrix between images
%                           i and j.
%           num_inliers   - n by n array of number of inliers. num_inliers{i,
%                           j} is the number of inliers between images i and
%                           j.
%           residual      - n by n array of sum of squared disrances.
%                           residual{i, j} is the residual between images i
%                           and j.

image_bw = im2single(rgb2gray(image));
target_image_bw = im2single(rgb2gray(target_image));

[cim, left_Y, left_X] = harris(image_bw, harris_sigma, harris_thresh, harris_r, 0);
[cim2, right_Y, right_X] = harris(target_image_bw, harris_sigma, harris_thresh, harris_r, 0);

image_keypoint = cat(2, left_X, left_Y, repmat(sift_r, length(left_X), 1));
target_image_keypoint = cat(2, right_X, right_Y, repmat(sift_r, length(right_X), 1));

[image_descriptor_loc, left_descriptors] = sift(image_bw, image_keypoint);
[target_image_descriptor_loc, right_descriptors] = sift(target_image_bw, target_image_keypoint);

[left_matches, right_matches] = select_putative_matches(left_descriptors, right_descriptors, num_putative_matches);

XY = image_descriptor_loc(left_matches,:);
XY_ = target_image_descriptor_loc(right_matches,:);

[H, num_inliers, residual] = ransac(XY, XY_, ransac_n, @fit_homography, @homography_transform);

result_img = stitch(image, H, target_image);

end