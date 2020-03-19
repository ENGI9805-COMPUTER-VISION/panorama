Image-Stitching
===============

MATLAB code for panorama image stitching.

![img](https://github.com/ENGI9805-COMPUTER-VISION/panorama/blob/master/result/hill.jpg)  
![img](https://github.com/ENGI9805-COMPUTER-VISION/panorama/blob/master/result/uttower.jpg)  

## Stitch_images

Given a pair of images with overlapping regions,
automatically compute a panorama image.

## Prerequisite

- Download(https://www.vlfeat.org/download.html) and extract the latest VLFeat binary distribution in a directory of your choice (e.g. ~/src/vlfeat). 
- Change VLFEATROOT to your directory for next command. 
- To permanently add VLFeat to your MATLAB environment, add this line to your startup.m file:
`run('VLFEATROOT/toolbox/vl_setup')`
See startup.m file(https://www.mathworks.com/help/matlab/ref/startup.html) for details.
- Now you can restart MATLAB and run commands of VLFEAT library.

## Usage    

run main.m

## stitch_images description

[result_img, H, num_inliers, residual] ...
              = stitch_images (images, sift_r, harris_r, ...
              harris_thresh, harris_sigma, num_putative_matches, ransac_n)

Arguments:
          images                - 1 by n cell array of images.
          sift_r                - radius of the SIFT descriptor.
          harris_r              - radius of the Harris corner detector.
          harris_thresh         - Harris corner detector threshold.
          harris_sigma          - standard deviation of smoothing Gaussian
          num_putative_matches  - number of putative matches to run
                                  RANSAC.
          ransac_n              - number of RANSAC iterations.

Returns:
          result_img    - computed paranoma image.
          H             - n by n cell array of homography matrices.
                          H{i, j} is the homography matrix between images
                          i and j.
          num_inliers   - n by n array of number of inliers. num_inliers{i,
                          j} is the number of inliers between images i and
                          j.
          residual      - n by n array of sum of squared disrances.
                          residual{i, j} is the residual between images i
                          and j.


