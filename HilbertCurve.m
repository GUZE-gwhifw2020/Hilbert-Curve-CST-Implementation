%% Birth Certificate
% ===================================== %
% DATE OF BIRTH:    2020.12.28
% NAME OF FILE:     HilbertCurve
% FILE OF PATH:     /..
% FUNC:
%   绘制N阶Hierber曲线
% ===================================== %

%% Global Variable %%
% 阶数
N = 5;
% 类型(1~4)
type = 3;

%%
close all
figure(1)
axis([0 1 0 1]);
hold on
HilberCurvePlot(N)
axis square


function HilberCurvePlot(N, depth, type, bias)
if(nargin == 1)
    depth = 1;
    bias = [0.5 0.5];
    type = 2;
end
    
if(depth == N)
    
    xC = [-1 1]/2^(depth+1)+bias(1);
    yC = [-1 1]/2^(depth+1)+bias(2);
    
    fprintf('\t%0f %0f %0f %0f \n',xC,yC);
    
    % 旋转因子
    if(type ~= 0)
        line(xC([1,2]),yC([1,1]));
    end
    if(type ~= 1)
        line(xC([2,2]),yC([1,2]));
    end
    if(type ~= 2)
        line(xC([1,2]),yC([2,2]));
    end
    if(type ~= 3)
        line(xC([1,1]),yC([1,2]));
    end
    
else
    % 递归下一级
    typeNext = [
        0 3 1 0;
        1 1 0 2;
        3 2 2 1;
        2 0 3 3;
        ];
    HilberCurvePlot(N, depth + 1, typeNext(type+1,1), bias + [-1 1] / 2^(depth+1));
    HilberCurvePlot(N, depth + 1, typeNext(type+1,2), bias + [-1 -1] / 2^(depth+1));
    HilberCurvePlot(N, depth + 1, typeNext(type+1,3), bias + [1 -1] / 2^(depth+1));
    HilberCurvePlot(N, depth + 1, typeNext(type+1,4), bias + [1 1] / 2^(depth+1));
    % 连接线
    if(type == 2)
        line(-[1 1] / 2^(depth) + [1 1]/2^(N+1) +bias(1), [-1 1]/2^(N+1)+bias(2));
        line([-1 1] / 2^(N+1)+bias(1), [-1 -1]/2^(N+1)+bias(2));
        line([1 1] / 2^(depth) - [1 1]/2^(N+1) +bias(1), [-1 1]/2^(N+1)+bias(2));
    elseif(type == 0)
        line(-[1 1] / 2^(depth) + [1 1]/2^(N+1) +bias(1), [-1 1]/2^(N+1)+bias(2));
        line([-1 1] / 2^(N+1)+bias(1), [1 1]/2^(N+1)+bias(2));
        line([1 1] / 2^(depth) - [1 1]/2^(N+1) +bias(1), [-1 1]/2^(N+1)+bias(2));
    elseif(type == 1)
        line([-1 1]/2^(N+1)+bias(1), -[1 1] / 2^(depth) + [1 1]/2^(N+1) +bias(2));
        line([-1 -1] / 2^(N+1)+bias(1), [-1 1]/2^(N+1)+bias(2));
        line([-1 1]/2^(N+1)+bias(1), [1 1] / 2^(depth) + -[1 1]/2^(N+1) +bias(2));
    elseif(type == 3)
        line([-1 1]/2^(N+1)+bias(1), -[1 1] / 2^(depth) + [1 1]/2^(N+1) +bias(2));
        line([1 1] / 2^(N+1)+bias(1), [-1 1]/2^(N+1)+bias(2));
        line([-1 1]/2^(N+1)+bias(1), [1 1] / 2^(depth) + [-1 -1]/2^(N+1) +bias(2));
    end
end
    
end
