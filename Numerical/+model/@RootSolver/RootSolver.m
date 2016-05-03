classdef RootSolver
    %RootSolver : Responsible for solving a given equation
    %   Detailed explanation goes here
    
    properties (Access = private)
        equation = [];
        maxNumOfIterations = 0;
        precision = 0;
    end
    
    methods
        % @param eq: matlab equation
        % @param maxnumItr: maximum number of iterations
        % @param preci: required precision
        function obj = RootSolver(eq, maxnumItr, preci)
            obj.equation = eq;
            obj.maxNumOfIterations = maxnumItr;
            obj.precision = preci;
        end
        % @return allIterations: array of strings representing the
        % iteration table
        
        % @return precision: last relative error in the calculations
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = Bisection(obj,lower,upper);
        % we will consider the g(x) = the input equation
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = FixedPoint(obj,initialGuess);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = Newton(obj,initialGuess);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = FalsePosition(obj,lower,upper);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = Secant(obj,firstGuess,secondGuess);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = BrigeVeta(obj,initialGuess);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = getAllRoots(obj,lower,upper);
    end
end

