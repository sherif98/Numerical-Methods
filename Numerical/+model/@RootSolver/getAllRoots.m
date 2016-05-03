function [numOfIterations,executionTime,allIteration,allRoots,precision,theoError,message] = getAllRoots(obj,lower,upper)
% initialization
tic
numOfIterations = [];
executionTime = 0;
allIteration = [];
precision = [];
theoError = [];
allRoots = [];
numForRound = 10000.0;
eps = 10.^(-5);
message = 'error';
% Summary: find all the roots in the given region
% spliting the total range into equally spaced ranges
Arr = linspace(lower,upper,1000);
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
           xLower = round(xLower * numForRound) / numForRound;
           allRoots = [allRoots xLower];
           
       elseif (abs(obj.equation(xUpper)) <= eps)
           xUpper = round(xUpper * numForRound) / numForRound;
           allRoots = [allRoots xUpper];
               
       elseif (obj.equation(xLower) * obj.equation(xUpper) < 0)
           [xNumOfIterations,xExecutionTime,xAllIteration,xAproxRoot,xPrecision,xTheoError,xMessage] = obj.Bisection(xLower,xUpper);
           % if Succeeded to find the root then append it to the answer
           if (strcmp(xMessage,'Success'))
               message = 'Success';
               numOfIterations = [numOfIterations;xNumOfIterations];
               allIteration = [allIteration;xAllIteration];
               precision = [precision;xPrecision];
               theoError = [theoError;xTheoError];
               xAproxRoot = round(xAproxRoot * numForRound) / numForRound;
               allRoots = [allRoots xAproxRoot];
           
           else
               [xNumOfIterations,xExecutionTime,xAllIteration,xAproxRoot,xPrecision,xTheoError,xMessage] = obj.FalsePosition(xLower,xUpper);
               if (strcmp(xMessage,'Success'))
                   message = 'Success';
                   numOfIterations = [numOfIterations;xNumOfIterations];
                   allIteration = [allIteration;xAllIteration];
                   precision = [precision;xPrecision];
                   theoError = [theoError;xTheoError];
                   xAproxRoot = round(xAproxRoot * numForRound) / numForRound;
                   allRoots = [allRoots xAproxRoot];
               end
           end 
       end
end
executionTime = toc;
allRoots = unique(allRoots);
end