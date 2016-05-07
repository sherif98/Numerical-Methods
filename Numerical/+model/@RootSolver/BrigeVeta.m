function [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = BrigeVeta(obj,initialGuess)
% initialization
numOfIterations = 0;
executionTime = tic;
allIteration = [];
precision = 100;
theoError = 0;
aproxRoot = initialGuess;

% implementation
g = sym(obj.equation);
% get the coefficients of the polynomial
coefficients = sym2poly(g);
temp = initialGuess;
for itr=1:obj.maxNumOfIterations
    numOfIterations = numOfIterations + 1;
    b = [];
    c = [];
    b(1) = coefficients(1);
    c(1) = coefficients(1);
    allIteration = [allIteration;coefficients(1),b(1),c(1)];
    for i=2:length(coefficients)
       b(i) = b(i-1) * initialGuess + coefficients(i);
       c(i) = c(i-1) * initialGuess + b(i);
       allIteration = [allIteration;coefficients(i),b(i),c(i)];
    end
    allIteration = [allIteration;0,0,0];
    allIteration = [allIteration;0,0,0];
    initialGuess = initialGuess - (b(length(b)) / c(length(c) - 1));
    precision = (abs(abs(initialGuess - temp) / temp)) * 100;
    aproxRoot = initialGuess;
    allIteration = [allIteration;0,temp,initialGuess];
    if (precision <= obj.precision)
        break;
    end
    temp = initialGuess;
    allIteration = [allIteration;0,0,0];
    allIteration = [allIteration;0,0,0];
end
if (numOfIterations >= obj.maxNumOfIterations)
    message = 'no root at this precision';
else
    message = 'Success';
end
executionTime = toc(executionTime);
end