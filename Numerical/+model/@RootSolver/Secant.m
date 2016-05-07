function [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = Secant(obj,firstGuess,secondGuess)
% initialization
executionTime = tic;
numOfIterations = 0;
allIteration = [];
precision = 100;
theoError = 0;
aproxRoot = secondGuess;
%executionTime = 0;
% implementation
temp = secondGuess;
for i=2:1:obj.maxNumOfIterations
    numOfIterations = numOfIterations + 1;
    secondGuess = double(secondGuess - ((obj.equation(secondGuess)*(firstGuess - secondGuess)) / (obj.equation(firstGuess) - obj.equation(secondGuess))));
    precision = (abs(abs(secondGuess - firstGuess) / secondGuess)) * 100;
    aproxRoot = secondGuess;
    allIteration = [allIteration;firstGuess,secondGuess,precision];
    firstGuess = temp;
    temp = secondGuess;
    if (precision <= obj.precision)
        break;
    end
end
if (numOfIterations >= obj.maxNumOfIterations)
    message = 'no root found at this precision';
else
    message = 'Success';
end
executionTime = toc(executionTime);
end