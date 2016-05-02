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
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError] = Bisection(obj,upper,lower);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError] = FixedPoint(obj,initialGuess);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError] = Newton(obj,initialGuess);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError] = FalsePosition(obj,upper,lower);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError] = Secant(obj,initialGuess);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError] = BrigeVeta(obj,initialGuess);
        [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError] = getAllRoots(obj);
    end
end

