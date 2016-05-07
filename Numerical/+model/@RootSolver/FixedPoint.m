function [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = FixedPoint(obj,initialGuess)
% initialization
numOfIterations = 0;
executionTime = tic;
allIteration = [];
precision = 100;
theoError = 0;
aproxRoot = initialGuess;

% my implementation goes here
syms x
df = diff(obj.equation, x);
df = inline(df);
temp = initialGuess;
% check if g'(x) must be less than 1
if (abs(df(initialGuess)) > 1)
    message = 'Error divergence occurred';
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
    message = strcat(message, 'no root at this precision');
else
    message = 'Success';
end
executionTime = toc(executionTime);
end