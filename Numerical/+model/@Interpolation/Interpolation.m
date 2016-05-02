classdef Interpolation
    %Interpolation Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        points = []; % example [1,2;1,3] first point = x= points(1,1); f(x)=points(1,2)
    end
    
    methods
        % @param pp: array of the initial points
        function obj = Interpolation(points)
            obj.points = points;
        end
        % @param queries: array of the points on x axis
        % @return polynomail: array of the coeffcients sorted in descending
        % order
        % @return solution: array for each query in the same order
        % @return exeTime: the time of performing the calculation
        [exeTime,polynomial,solution] = Newton(obj, queries);
        [exeTime,polynomial,solution] = Lagrang(obj, queries);
    end 
end

