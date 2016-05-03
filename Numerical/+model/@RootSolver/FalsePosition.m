function [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = FalsePosition(obj,lower,upper)
% Implementation goes here
if ((obj.equation(lower) * obj.equation(upper)) > 0)
    message = 'error';
    % fill with dummy values
    numOfIterations = -1;
    return;
end
message = 'Success';
% allIteration = ['Lower','Upper','mid','f(mid)','relativeError'];
allIteration = [];
tic
aproxRoot = ((lower * obj.equation(upper)) - (upper * obj.equation(lower))) / (obj.equation(upper) - obj.equation(lower));
numOfIterations = 0;
theoError = 0; % tell we know about it
for i=1:1:obj.maxNumOfIterations
    numOfIterations = numOfIterations + 1;
    mid = ((lower * obj.equation(upper)) - (upper * obj.equation(lower))) / (obj.equation(upper) - obj.equation(lower));
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
executionTime = toc;
if (numOfIterations >= obj.maxNumOfIterations)
    message = 'no root found to desired tolerance';
end
end