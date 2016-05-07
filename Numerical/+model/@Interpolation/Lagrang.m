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
for i = 1 : 1 : sz
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
for i = 1 : 1 : sz(2)
    val = polynomial(queries(i));
    solution = [solution,double(val)];
end
message = 'Success';
exeTime = toc(exeTime);
end