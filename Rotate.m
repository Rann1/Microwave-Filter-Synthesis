function [ M ] = Rotate ( M, k, i, j, opt )
%ROTATE 
%   [ M ] = Rotate ( M, k, i, j, opt )
%   对矩阵M执行以(i, j)为枢轴的旋转操作。
%
%   如果 opt = 'row'，则消除第i行的第k个元素。
%   如果 opt = 'column'，则消除第i列的第k个元素。
%   如果 opt = 'cross'，则消除交叉枢轴元素 M(i,j)。
%

if strcmp(opt, 'row')
    % Eliminate the kth element in row i
    if M(i,k) == 0
        theta = 0;
    elseif M(j,k) == 0
        theta = pi/2;
    else
        theta = atan(M(i,k)/M(j,k));
    end
elseif strcmp(opt, 'column')
    % Eliminate the kth element in column i
    if M(k,i) == 0
        theta = 0;
    elseif M(k,j) == 0
        theta = pi/2;
    else
        theta = atan(M(k,i)/M(k,j));
    end
elseif strcmp(opt, 'cross')
    % Eliminate cross-pivot element (i,j)
    if M(i,j) == 0
        theta = 0;
    elseif M(i,i) == M(j,j)
        theta = pi/4;
    else
        theta = 0.5*atan(2*M(i,j)/(M(j,j)-M(i,i)));
    end
end

N = size(M,1);
R = eye(N);
R(i,j) = -sin(theta);
R(j,i) = sin(theta);
R(j,j) = cos(theta);
R(i,i) = cos(theta);
M = R*M*R.';

end

