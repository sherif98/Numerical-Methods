function [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = Newton(obj,initialGuess)
% implementation goes here
tic
syms x
df = diff(obj.equation, x);
df = inline(df);
var = obj.equation(initialGuess);
previous = var;
numOfIterations = 0;
allIteration = [];
precision = -1;
executionTime = 0;
message = 'Success';
theoError = 0;

for i=1:1:obj.maxNumOfIterations
    numOfIterations = numOfIterations + 1;
    %x = previous;
    var = previous - ((obj.equation(previous) / df(previous)));
    precision = (abs(abs(var - previous) / var)) * 100;
    allIteration = [allIteration;previous,var,precision];
    if (precision <= obj.precision)
        aproxRoot = var;
        return;
    end
    previous = var;
    aproxRoot = var;
end
if (numOfIterations >= obj.maxNumOfIterations)
    message = 'no root found at this precision';
end
executionTime = toc;
end