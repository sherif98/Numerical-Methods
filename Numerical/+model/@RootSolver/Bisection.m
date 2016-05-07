function [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = Bisection(obj,lower,upper)
% initialization
% tic
numOfIterations = 0;
executionTime = tic;
allIteration = [];
precision = 100;
theoError = 0;
aproxRoot = 0;
if ((obj.equation(lower) * obj.equation(upper)) > 0)
    message = 'error';
    return;
end
% allIteration = ['Lower','Upper','mid','f(mid)','relativeError'];
for i=1:1:obj.maxNumOfIterations
    numOfIterations = numOfIterations + 1;
    mid = (lower + upper) / 2;
    precision = (abs(abs(upper - lower) / lower)) * 100;
    test = obj.equation(lower) * obj.equation(mid);
    allIteration = [allIteration;lower,upper,mid,obj.equation(mid),precision];
    aproxRoot = mid;
    if (test < 0)
        upper = mid;
    else
        lower = mid;
    end
    if (test == 0)
        aproxRoot = mid;
        precision = 0; % relative approximate error
    end
    if (precision < obj.precision)
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