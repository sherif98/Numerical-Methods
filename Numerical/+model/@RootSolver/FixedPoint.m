function [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = FixedPoint(obj,initialGuess)
% initialization
tic
numOfIterations = 0;
executionTime = 0;
allIteration = [];
precision = 100;
theoError = 0;
aproxRoot = initialGuess;

% my implementation goes here
syms x
df = diff(obj.equation, x);
df = inline(df);
temp = initialGuess;
if (df(initialGuess) > 1)
    message = 'Error divergence occurred';
    return;
end
allIteration = [allIteration;initialGuess,precision];
for i=1:1:obj.maxNumOfIterations
    numOfIterations = numOfIterations + 1;
    initialGuess = obj.equation(initialGuess);
    precision = (abs(abs(initialGuess - temp) / initialGuess)) * 100;
    aproxRoot = initialGuess;
    allIteration = [allIteration;initialGuess,precision];
    if (precision <= obj.precision)
        break;
    end
    temp = initialGuess;
end
if (numOfIterations >= obj.maxNumOfIterations)
    message = 'no root at this precision';
else
    message = 'Success';
end
executionTime = toc;
end