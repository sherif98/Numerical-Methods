function [exeTime,polynomial,solution,message] = Newton(obj, queries)
    % implementation goes here
    numberOfPoints = size(obj.points);
    message = '';
    if numberOfPoints(2) ~= 2
        message = 'not valid points';
        return;
    end
    
    
    tic;
    syms x;
    polynomial = symfun(0 * x, x);
    
    % newton table
    newtonTable = zeros(numberOfPoints(1), numberOfPoints(1) + 1);
    
    % table initializion 
    for i = 1 : numberOfPoints(1)
        newtonTable(i,1) = obj.points(i,1);
        newtonTable(i,2) = obj.points(i,2);
    end
    
    % creating newton table
    for col = 3 : numberOfPoints(1) + 1
        for row = col - 1 : numberOfPoints(1)
            y = newtonTable(row ,col - 1)-newtonTable(row - 1, col - 1);
            z = newtonTable(row, 1)-newtonTable(row - col + 2, 1);
            newtonTable(row, col) = y / z;
        end
    end
    
    % construct equation
    factorAcc = symfun(x ^ 0, x);
    for b = 1 : numberOfPoints(1)
        %newtonTable(b, b + 1);
        polynomial = polynomial + newtonTable(b, b + 1) * factorAcc;
        factorAcc = factorAcc * symfun(x - obj.points(b), x);
    end
    
    % interpolation
    numberOfQueries = size(queries);
    solution = zeros(1, numberOfQueries(2));
    for i = 1 : numberOfQueries(2)
        solution(i) = polynomial(queries(i));
    end
    
    exeTime = toc;
    message = 'success';
    
end