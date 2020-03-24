% Reference http://www.leet.it/home/giusti/teaching/matlab_sessions/stitching/stitch.html

function result = stitch(image, H, target_image)
    [~, xdata, ydata] = imtransform(image,maketform('projective',H'));
    % now xdata and ydata store the bounds of the transformed image
    xdata_out=[min(1,xdata(1)) max(size(target_image,2), xdata(2))];
    ydata_out=[min(1,ydata(1)) max(size(target_image,1), ydata(2))];
    % let's transform both images with the computed xdata and ydata
    result1 = imtransform(image, maketform('projective',H'),'XData',xdata_out,'YData',ydata_out);
    result2 = imtransform(target_image, maketform('affine',eye(3)),'XData',xdata_out,'YData',ydata_out);
    result = result1 + result2;
    overlap = (result1 > 0.0) & (result2 > 0.0);
    result_avg = (result1/2 + result2/2);
    
    result(overlap) = result_avg(overlap);
end