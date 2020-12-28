%% Birth Certificate
% ===================================== %
% DATE OF BIRTH:    2020.12.28
% NAME OF FILE:     HilbertCurve
% FILE OF PATH:     /..
% FUNC:
%   绘制N阶Hierber曲线
% ===================================== %

%% ====== Global Variable ====== %%
% 阶数
N = 4;
% 类型(0~3)
type = 0;

%%
close all
figure(1)
axis([0 1 0 1]);
hold on
HilberCurvePlot(N,mod(type,4));
axis square


function HilberCurvePlot(N, type, depth, bias)
if(nargin <= 2)
    depth = 1;
    bias = [0.5 0.5];
    if(nargin <= 1)
        type = 2;
    end
end
    
if(depth == N)
    
    xC = [-1 1]/2^(depth+1)+bias(1);
    yC = [-1 1]/2^(depth+1)+bias(2);
     
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
    HilberCurvePlot(N, typeNext(type+1,1), depth + 1, bias + [-1 1] / 2^(depth+1));
    HilberCurvePlot(N, typeNext(type+1,2), depth + 1, bias + [-1 -1] / 2^(depth+1));
    HilberCurvePlot(N, typeNext(type+1,3), depth + 1, bias + [1 -1] / 2^(depth+1));
    HilberCurvePlot(N, typeNext(type+1,4), depth + 1, bias + [1 1] / 2^(depth+1));
    
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
