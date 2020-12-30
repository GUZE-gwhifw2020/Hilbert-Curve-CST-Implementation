%% Birth Certificate
% ===================================== %
% DATE OF BIRTH:    2020.12.28
% NAME OF FILE:     HilbertCurve_CST
% FILE OF PATH:     /..
% FUNC:
%   CST工程中绘制Hilbert Curve
% ===================================== %
clear CSTLineMake
%% ====== Global Variable ====== %%
% 阶数
N = 7;
% 类型(0~3)
type = 2;
% 打开cst文件
cst=actxserver('CSTStudio.Application');
mws = cst.invoke('OpenDesign',fullfile(pwd,'HilbertCurve.cst'));

L = 100;
W = 10 * 0.0254;


% Solid部分
brick = invoke(mws,'Brick');

%%
HilberCurvePlotCST(N,mod(type,4));

function HilberCurvePlotCST(N, type, depth, bias)
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
        CSTLineMake(xC([1,2]),yC([1,1]));
    end
    if(type ~= 1)
        CSTLineMake(xC([2,2]),yC([1,2]));
    end
    if(type ~= 2)
        CSTLineMake(xC([1,2]),yC([2,2]));
    end
    if(type ~= 3)
        CSTLineMake(xC([1,1]),yC([1,2]));
    end
    
else
    % 递归下一级
    typeNext = [
        0 3 1 0;
        1 1 0 2;
        3 2 2 1;
        2 0 3 3;
        ];
    HilberCurvePlotCST(N, typeNext(type+1,1), depth + 1, bias + [-1 1] / 2^(depth+1));
    HilberCurvePlotCST(N, typeNext(type+1,2), depth + 1, bias + [-1 -1] / 2^(depth+1));
    HilberCurvePlotCST(N, typeNext(type+1,3), depth + 1, bias + [1 -1] / 2^(depth+1));
    HilberCurvePlotCST(N, typeNext(type+1,4), depth + 1, bias + [1 1] / 2^(depth+1));
    
    % 连接线
    if(type == 2)
        CSTLineMake(-[1 1] / 2^(depth) + [1 1]/2^(N+1) +bias(1), [-1 1]/2^(N+1)+bias(2));
        CSTLineMake([-1 1] / 2^(N+1)+bias(1), [-1 -1]/2^(N+1)+bias(2));
        CSTLineMake([1 1] / 2^(depth) - [1 1]/2^(N+1) +bias(1), [-1 1]/2^(N+1)+bias(2));
    elseif(type == 0)
        CSTLineMake(-[1 1] / 2^(depth) + [1 1]/2^(N+1) +bias(1), [-1 1]/2^(N+1)+bias(2));
        CSTLineMake([-1 1] / 2^(N+1)+bias(1), [1 1]/2^(N+1)+bias(2));
        CSTLineMake([1 1] / 2^(depth) - [1 1]/2^(N+1) +bias(1), [-1 1]/2^(N+1)+bias(2));
    elseif(type == 1)
        CSTLineMake([-1 1]/2^(N+1)+bias(1), -[1 1] / 2^(depth) + [1 1]/2^(N+1) +bias(2));
        CSTLineMake([-1 -1] / 2^(N+1)+bias(1), [-1 1]/2^(N+1)+bias(2));
        CSTLineMake([-1 1]/2^(N+1)+bias(1), [1 1] / 2^(depth) + -[1 1]/2^(N+1) +bias(2));
    elseif(type == 3)
        CSTLineMake([-1 1]/2^(N+1)+bias(1), -[1 1] / 2^(depth) + [1 1]/2^(N+1) +bias(2));
        CSTLineMake([1 1] / 2^(N+1)+bias(1), [-1 1]/2^(N+1)+bias(2));
        CSTLineMake([-1 1]/2^(N+1)+bias(1), [1 1] / 2^(depth) + [-1 -1]/2^(N+1) +bias(2));
    end
end
    
end

function CSTLineMake(xc,yc)
persistent iName
if(isempty(iName))
    iName = 0;
end

brickF = evalin('base','brick');
LF = evalin('base','L');
WF = evalin('base','W');

invoke(brickF,'Reset');
invoke(brickF,'Name',strcat('Line',int2str(iName)));
invoke(brickF,'component','HilbertCurve');
invoke(brickF,'Material','PEC');

invoke(brickF,'Xrange',num2str(xc(1)*LF - WF/2),num2str(xc(2)*LF + WF/2));
invoke(brickF,'Yrange',num2str(yc(1)*LF - WF/2),num2str(yc(2)*LF + WF/2));
invoke(brickF,'Zrange','0','T');

invoke(brickF,'Create');

iName = iName + 1;

end