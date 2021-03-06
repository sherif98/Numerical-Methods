function [numOfIterations,executionTime,allIteration,allRoots,precision,theoError,message] = getAllRoots(obj,lower,upper)
% initialization
numOfIterations = [];
executionTime = [];
allIteration = [];
precision = [];
theoError = [];
allRoots = [];
numForRound = 1000.0;
eps = 10.^(-5);
message = 'error';
divider = 1000;
% Summary: find all the roots in the given region
% spliting the total range into equally spaced ranges
Arr = linspace(lower,upper,divider);
while abs(Arr(2) - Arr(1)) < 0.001
    divider = divider / 2;
    divider = round(divider);
    Arr = linspace(lower, upper, divider);
end
% iterating over this ranges
for i=1:(numel(Arr) - 1)
    % try to find a root in this region
    xLower = Arr(i);
    xUpper = Arr(i+1);
    flag = 0;
    for j=(i+1):(numel(Arr) - 1)
        xUpper = Arr(j);
        if (obj.equation(xUpper) * obj.equation(xLower) < 0)
            flag = 1;
            break;
        end
    end
    if (flag == 0)
        continue;
    elseif (abs(obj.equation(xLower)) <= eps)
        message = 'Success';
        xLower = round(xLower * numForRound) / numForRound;
        tempLength = length(allRoots);
        allRoots = [allRoots xLower];
        allRoots = unique(allRoots);
        if (tempLength < length(allRoots))
            numOfIterations = [numOfIterations 0];
            executionTime = [executionTime 0];
            precision = [precision 0];
            theoError = [theoError 0];
        end
        
    elseif (abs(obj.equation(xUpper)) <= eps)
        message = 'Success';
        xUpper = round(xUpper * numForRound) / numForRound;
        tempLength = length(allRoots);
        allRoots = [allRoots xUpper];
        allRoots = unique(allRoots);
        if (tempLength < length(allRoots))
            numOfIterations = [numOfIterations 0];
            precision = [precision 0];
            executionTime = [executionTime 0];
            theoError = [theoError 0];
        end
        
    elseif (obj.equation(xLower) * obj.equation(xUpper) < 0)
        [xNumOfIterations,xExecutionTime,xAllIteration,xAproxRoot,xPrecision,xTheoError,xMessage] = obj.Bisection(xLower,xUpper);
        % if Succeeded to find the root then append it to the answer
        if (strcmp(xMessage,'Success'))
            message = 'Success';
            tempLength = length(allRoots);
            xAproxRoot = round(xAproxRoot * numForRound) / numForRound;
            allRoots = [allRoots xAproxRoot];
            allRoots = unique(allRoots);
            if (tempLength < length(allRoots))
                numOfIterations = [numOfIterations xNumOfIterations];
                allIteration = [allIteration;xAllIteration];
                precision = [precision xPrecision];
                executionTime = [executionTime xExecutionTime];
                theoError = [theoError xTheoError];
            end
            
        else
            [xNumOfIterations,xExecutionTime,xAllIteration,xAproxRoot,xPrecision,xTheoError,xMessage] = obj.FalsePosition(xLower,xUpper);
            if (strcmp(xMessage,'Success'))
                message = 'Success';
                tempLength = length(allRoots);
                xAproxRoot = round(xAproxRoot * numForRound) / numForRound;
                allRoots = [allRoots xAproxRoot];
                allRoots = unique(allRoots);
                if (tempLength < length(allRoots))
                    numOfIterations = [numOfIterations xNumOfIterations];
                    allIteration = [allIteration;xAllIteration];
                    precision = [precision xPrecision];
                    executionTime = [executionTime xExecutionTime];
                    theoError = [theoError xTheoError];
                end
            end
        end
    end
end
end