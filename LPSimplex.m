%% Simplex Method
% Chapter 3. (p.119) Linear Programming I. Simplex Method
% 3.9 Simplex Algorithm
% Engineering Optimization - Theory and Practice, 4th Edition
% Singiresu S. Rao

clear all; clc

%% Initialization: Objective functions subject to constraints
f = [40 100];                   % Maximize function
A = [10 5; 4 10; 2 3];          % Inequality constraints
b = [2500; 2000; 900];
Ae = [];                        % Equality constraints
be = [];

%% Create a simplex matrix
M1 = [A; -f];   x  = size(M1,1);
M2 = eye(x);    M3 = [b; 0];
M = [M1 M2 M3]

%%
for i = 1:x
    m = min(M(size(M,1),1:x-1));                % The most negative
    if m >= 0                                   % Check positive
        if sum(M(size(M,1),1:x-1)) == 0
            disp('This has infinite solution')
            break
        else
            disp('This is the optimum solution')
            break
        end
    else
        n = find(M(size(M,1),1:x)==m);          % Index the most negative
        for j = 1:size(A,1)                     % Collect the pivot data
            if M(j,n) > 0
                temp(j) = M(j,end)/M(j,n);
            else
                temp(j) = Inf;
            end
        end
        pv = find(temp == min(temp));           % Pivot
        if numel(pv) > 1
            pv = pv(1);                         % Pick random/the first
        end
        M(pv,:) = M(pv,:)./M(pv,n);
        d = 1:x;
        d(pv) = [];                             % Remove pivot iteration
        for k = 1:x-1                           % Zeros, except pivot row
            M(d(k),:) = M(d(k),:) - M(d(k),n)*M(pv,:)
        end
    end
end
