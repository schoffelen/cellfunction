function output = rdivide(input1, input2)

output = cellfun(@rdivide, input1, repmat({input2}, size(input1)), 'uniformoutput', false);
