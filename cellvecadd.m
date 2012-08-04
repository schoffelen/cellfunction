function [y] = cellvecadd(x, v)

% [Y]= CELLVECADD(X, V) - add vector to all rows or columns of each matrix 
% in cell-array X

% check once and for all to save time
persistent bsxfun_exists;
if isempty(bsxfun_exists); 
  bsxfun_exists=(exist('bsxfun',5)); 
  if ~bsxfun_exists; 
    error('bsxfun not found.');
  end
end

nx = size(x);
if ~iscell(x) || length(nx)>2 || all(nx>1),
  error('incorrect input for cellmean');
end

if ~iscell(v),
  v = repmat({v}, nx);
end

% sx1 = cellfun('size', x, 1);
% sx2 = cellfun('size', x, 2);
% sv1 = cellfun('size', v, 1);
% sv2 = cellfun('size', v, 2);
% if all(sx1==sv1) && all(sv2==1),    
%   dim = mat2cell([ones(length(sx2),1) sx2(:)]', repmat(2,nx(1),1), ones(nx(2),1)); 
% elseif all(sx2==sv2) && all(sv1==1),
%   dim = mat2cell([sx1(:) ones(length(sx1),1)]', repmat(2,nx(1),1), ones(nx(2),1));
% elseif all(sv1==1) && all(sv2==1),
%   dim = mat2cell([sx1(:) sx2(:)]'', nx(1), nx(2));
% else   error('inconsistent input');
% end  
% y = cellfun(@vplus, x, v, dim, 'UniformOutput', 0);

y  = cellfun(@bsxfun, repmat({@plus}, nx), x, v, 'UniformOutput', 0);

% function y = vplus(x, v, dim)
% 
% y = x + repmat(v, dim);
