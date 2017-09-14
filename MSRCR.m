% sigma, stds of gaussian filters in different scales, m*1
% w, weight of each scales, m*1
function img_out = MSRCR( img_in, sigma, w, alpha, d )
    e = 0.004;
    
    img_in = img_in + e;
    if ~exist('sigma','var') || isempty(sigma)
        sigma = [2 90 180];
    end
    if ~exist('w','var') || isempty(w)
        w = [1 1 1]/3;
    end
    if ~exist('alpha','var') || isempty(alpha)
        alpha = 128;
    end
    if ~exist('d','var') || isempty(d)
        d = 1.2;
    end
    
    % multi-scale Retinex, color restore
    scale = max(size(sigma,1),size(sigma,2));
    S = log(img_in);
    R = cell(scale,1);
    for is = 1 : scale
        R{is} = S - imgaussfilt(S,sigma(is));
    end
    R_sum = w(1)*R{1};
    for is = 2 : scale
        R_sum = R_sum + w(is)*R{is};
    end
    
    % dynamics of the colors
    C = log(alpha*img_in) - repmat(log(sum(img_in,3)),[1,1,3]);
    Rcr = C.*R_sum;
    
    meani = mean(Rcr(:));
    vari  = var(Rcr(:));
    mini = meani - d*vari;
    maxi = meani + d*vari;
    range = maxi - mini;
    img_out = (Rcr - mini)/range;
    
end

