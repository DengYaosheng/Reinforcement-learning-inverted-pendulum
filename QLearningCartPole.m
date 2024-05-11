%清除工作空间
clc;clear all;close all;
NUM_BOXES = 163;          %建立Q表的行
ALPHA = 0.5;              %学习率为0.5           
GAMMA = 0.999;            %折扣因子0.999        
Q = zeros(NUM_BOXES,2);   %初始化Q表
action = [10 -10];        %设立动作空间
MAX_FAILURES = 1000;      %最大失败次数
MAX_STEPS = 150000;       %最大步数
epsilon = 0;              %初始回合设置为0
steps = 0;                %初始步数设置
failures = 0;             %初始化失败次数
%初始化状态变量
thetaPlot = 0;
xPlot = 0;
theta = 0;
thetaDot = 0;
x = 0;
xDot = 0;
box = getBox4(theta,thetaDot,x,xDot);
%进入循环迭代求Q表
while(steps<=MAX_STEPS && failures<+MAX_FAILURES)
    steps = steps + 1;
   %设置探索度
    if(rand>epsilon)       
        [~,actionMax] = max(Q(box,:));
        currentAction = action(actionMax);
    else                   
        currentAction = datasample(action,1);
    end
    %获取动作索引，方便之后计算Q值更新
    actionIndex = find(action == currentAction); 
    %依据动作更新状态
    [thetaNext,thetaDotNext,thetaacc,xNext,xDotNext] = cart_pole2(currentAction,theta,thetaDot,x,xDot);
    %获取新的离散后的状态表示
    thetaPlot(end + 1) = thetaNext*180/pi;
    xPlot(end + 1) = xNext;
    newBox = getBox4(thetaNext,thetaDotNext,xNext,xDotNext);
    theta = thetaNext;
    thetaDot = thetaDotNext;
    x = xNext;
    xDot = xDotNext;
    %画图
    if(newBox==163)
        r = -1;
        Q(newBox,:) = 0;
        figure(2);
        plot((1:length(thetaPlot)),thetaPlot,'-b');
        figure(3);
        plot((1:length(xPlot)),xPlot,'-b');

        thetaPlot = 0;
        xPlot = 0;
        theta = 0;
        thetaDot = 0;
        x = 0;
        xDot = 0;
        newBox = getBox4(theta,thetaDot,x,xDot);
        failures = failures + 1;
        fprintf('Trial %d was %d steps. \n',failures,steps);
        figure(1);
        plot(failures,steps,'-b');
        hold on;
        steps = 0;
    else
        r = 0;
    end
    %更新Q表
    Q(box,actionIndex) = Q(box,actionIndex) + ALPHA*(r + GAMMA*max(Q(newBox,:)) - Q(box,actionIndex));
    box = newBox;
end
if(failures == MAX_FAILURES)
    fprintf('Pole not balanced. Stopping after %d failures.',failures);
else
    %画相关图
    fprintf('Pole balanced successfully for at least %d steps\n', steps);
    figure(1);
    plot(failures+1,steps,'-b');
    title('failures+1','FontSize',16); 
    hold on;
    figure(2);
    chouxi = 1:length(thetaPlot);
    plot((1:length(thetaPlot)),thetaPlot,'-b');
    title('thetaPlot','FontSize',16); 
    figure(3);
    plot((1:length(xPlot)),xPlot,'-b');
    title('xPlot','FontSize',16); 
    figure(4);
    plot((1:301),thetaPlot(1:301),'-b');
    title('thetaPlot-301','FontSize',16);
    hold on;
    figure(5);
    plot((1:301),xPlot(1:301),'-b');
    title('xPlot-301','FontSize',16);
    hold on;
end