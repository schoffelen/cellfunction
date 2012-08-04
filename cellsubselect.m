function [y] = cellsubselect(x, boolvec)

% [Y] = CELLSUBSELECT(X, BOOLVEC, DIM) outputs a cell-arry Y with the same dimension as X
% but from each input cell a subset of rows or columns are kept according
% to boolvec (which assumes the input data to be concatenated across cells)
% 
% X should be a linear cell-array of matrices for which the size in at 
% least one of the dimensions should be the same for all cells and the sum of samples in
% the other dimension should equal the length of boolvec

nx = size(x);
if ~iscell(x) || length(nx)>2 || all(nx>1),
  error('incorrect input for cellmean');
end

scx1 = cellfun('size', x, 1);
scx2 = cellfun('size', x, 2);

if length(boolvec)==sum(scx1), 
  dim  = 1;
  nsmp = scx1;
elseif length(boolvec)==sum(scx2),
  dim  = 2;
  nsmp = scx2;
else
  error('the length of boolvec should correspond to the summed number of samples across on of the dimensions of the input cells');
end

if dim==1,
  error('subselection along the rows is not yet supported by this function');
end

y = cellfun(@subc, x, mat2cell(boolvec,1,nsmp(:)'), 'UniformOutput', 0);

function [y] = subc(x, boolvec)

%FIXME works only in case of dim=2
y = x(:, boolvec);
