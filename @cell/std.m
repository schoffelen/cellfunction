function [sd] = std(x, normalizeflag, dim, flag)

% [M] = STD(X, NORMALIZEFLAG, DIM, FLAG) computes the standard deviation,
% across all cells in x along the dimension dim. Normalizeflag = 1 normalizes
% by N, normalizeflag = [] or 0 normalizes by N-1. 
% 
% X should be an linear cell-array of matrices for which the size in at 
% least one of the dimensions should be the same for all cells. If flag==1, the mean will
% be subtracted first (default behaviour, but to save time on already demeaned data, it
% can be set to 0).

nx = size(x);
if ~iscell(x) || length(nx)>2 || all(nx>1),
  error('incorrect input for cellstd');
end

if nargin<2 || isempty(normalizeflag)
  normalizeflag = 0;
end

if nargin<3,
  [scx1, scx2] = size2(x, [], 'cell');
  if     all(scx1==scx1(1)), dim = 2;
  elseif all(scx2==scx2(1)), dim = 1; %let second dimension prevail
  else   error('no dimension to compute mean for');
  end
elseif nargin<4,
  flag = 1;
end

if flag,
  m    = mean(x, dim);
  x    = cellvecadd(x, -m);
end

nx   = max(nx);
nsmp = size2(x, dim, 'cell');
ssmp = cellfun(@sumsq,   x, repmat({dim},1,nx), 'UniformOutput', 0);

if normalizeflag
  N = sum(nsmp);
else
  N = sum(nsmp)-1;
end

sd   = sqrt(sum(cell2mat(ssmp), dim)./N);  

function [s] = sumsq(x, dim)

s = sum(x.^2, dim);
