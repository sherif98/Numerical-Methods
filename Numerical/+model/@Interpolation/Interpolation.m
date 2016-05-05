classdef Interpolation
    %Interpolation Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        points = []; % example [1,2;1,3] first point = 1,2 second 1,3
    end
    
    methods
        % @param pp: array of the initial points
        function obj = Interpolation(points)
            obj.points = points;
        end
        % @param queries: array of the points on x axis
        % @return polynomail: The output equation
        % @return solution: array for each query in the same order
        % @return exeTime: the time of performing the calculation
        % @return message: an string equal to sucess or error massage
        [exeTime,polynomial,solution] = Newton(obj, queries);
        [exeTime,polynomial,solution,message] = Lagrang(obj, queries);
    end 
end

