function imgd = bwdistgeodesicsc3d(im,idx,sc)
%% bwdistgeodesicsc - 2d/3d anisotropic geodesic distance transform
%   
%   REFERENCE:
%       T. M. Scales, B. Obara, M. R. Holt, N. A. Hotchin, 
%       F. Berditchevski, and M. Parsons, α3β1 integrins regulate CD151 
%       complex assembly and membrane dynamics of carcinoma cells within 
%       3D environments, Oncogene, 32, 34, 3965-3979, 2013
%
%   INPUT:
%       im      - 2d/3d binary image
%       idx     - a vector of linear indices of seed locations
%       sc      - 2- or 3-component vector defining the pixel/voxel- aspect-ratio
%
%   OUTPUT:
%       imgd    - 2d/3d 2d/3d anisotropic geodesic distance image
%       immax   - alternating filter 
%       imsum   - max of top-hats 
%
%   AUTHOR:
%       Boguslaw Obara
%

%% setup
img = single(im); % convert binary to single image
img(~im) = Inf;
ind = idx-1; % convert to 0 based linear index to pass to C++ code

%% connectivity
if length(size(im)) == 2
    conn = true(3,3);
    conn(2,2) = 0;
else
    conn = true(3,3,3);
    conn(2,2,2) = 0;
end    

%% anisotropic weights
if length(size(im)) == 2
    weights = false(3,3); 
    weights(2,2) = 1; 
    weightsd = bwdistsc(weights,sc);
    weights = single(weightsd(:)');
    weights(5) = [];
else
    weights = false(3,3,3); 
    weights(2,2,2) = 1; 
    weightsd = bwdistsc(weights,sc);
    weights = single(weightsd(:)');
    weights(14) = [];
end    

%% distance
imgd = graydistmex(img,ind,conn,weights);
imgd(~im) = NaN;

end