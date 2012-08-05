function [ssmp] = sum(x, dim)

% [S] = SUM(X, DIM) computes the sum, across all cells in x along 
% the dimension dim.
% 
% X should be an linear cell-array of matrices for which the size in at 
% least one of the dimensions should be the same for all cells 

nx = size(x);
if ~iscell(x) || length(nx)>2 || all(nx>1),
  error('incorrect input for cellmean');
end

if nargin==1,
  [scx1, scx2] = size2(x,[],'cell');
  if     all(scx1==scx1(1)), dim = 2;
  elseif all(scx2==scx2(1)), dim = 1; %let second dimension prevail
  else   error('no dimension to compute mean for');
  end
end

nx   = max(nx);
nsmp = cellfun('size', x, dim);
ssmp = cellfun(@sum,   x, repmat({dim},1,nx), 'UniformOutput', 0);
ssmp = sum(cell2mat(ssmp), dim);  
