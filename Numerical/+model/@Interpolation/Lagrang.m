function [exeTime,polynomial,solution,message] = Lagrang(obj, queries)
% implementation goes here
sz = size(obj.points);
message = '';
exeTime = tic;
solution = [];
syms x;
polynomial = symfun(0,x);
if sz(2) ~= 2
    message = 'not valid points';
    return;
end
sz = sz(1);
maxX = obj.points(1, 1);
minX = obj.points(1, 1);
for i = 1 : 1 : sz
    if(obj.points(i, 1) > maxX)
        maxX = obj.points(i, 1);
    end
    if(obj.points(i, 1) < minX)
        minX = obj.points(i, 1)
    end
    poly = symfun(1,x);
    for j = 1 : 1 : sz
        if i == j
            continue;
        end
        poly = poly * symfun(x-obj.points(j,1),x);
        poly = poly / symfun(obj.points(i,1)-obj.points(j,1),x);
    end
    poly = poly * symfun(obj.points(i,2),x);
    polynomial = polynomial + poly;
end
sz = size(queries);
flag = 0;
for i = 1 : 1 : sz(2)
    if(queries(i) > maxX || queries(i) < minX)
        message = 'error extrapolation';
        flag = 1;
    end
    val = polynomial(queries(i));
    solution = [solution,double(val)];
end
if(flag == 0)
    message = 'Success';
end
exeTime = toc(exeTime);
end