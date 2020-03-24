function [result, best_num_inliers, residual] = ransac(XY, XY_, N, estimate_func, transform_func)
% RANSAC - A simple RANSAC implementation.
    best_H = [];
    best_num_inliers = 0;

    for i = 1:N
        % Random permutation
        ind = randperm(size(XY,1)); 
        ind_s = ind(1:4);
        ind_r = ind(5:end);

        XYs = XY(ind_s,:);
        XYs_ = XY_(ind_s,:);

        XYr = XY(ind_r,:);
        XYr_ = XY_(ind_r,:);

        H = estimate_func(XYs, XYs_);
        [XYf_] = transform_func(XYr, H);

        dists = sum((XYr_ - XYf_).^2,2);

        % inliner is defined as dist < 0.3
        ind_b = find(dists<0.3);
        num_inliers = length(ind_b);
        
        % found a better one
        if best_num_inliers < num_inliers
            best_H = H;
            best_num_inliers = num_inliers;
            residual = mean(dists(ind_b));
        end
    end

    result = best_H;
end