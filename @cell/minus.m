function [output] = minus(input1, input2)

output = cellfun(@minus,input1,input2,'uniformoutput',false);