%  cart_pole:  倒立摆数学模型函数，输入力，角度、角度加速度、位置、位置加速度。并进行更新状态量。
function [thetaNext,thetaDotNext,thetaacc,xNext,xDotNext] = cart_pole2(force,theta,thetaDot,x,xDot)
%设置倒立摆参数
GRAVITY = 9.8;      %重力加速度
MASSCART = 1;       %车的质量
MASSPOLE = 0.1;     %车杆的质量
TOTAL_MASS = (MASSPOLE + MASSCART); %车加杆子的重量
LENGTH = 0.5; % 摆杆的质心与旋转中心的距离
POLEMASS_LENGTH = (MASSPOLE*LENGTH); 
TAU = 0.02; %仿真时间间隔
FOURTHIRDS = 1.3333333333333;

% 倒立摆数学模型
temp = (force + POLEMASS_LENGTH*thetaDot*thetaDot*sin(theta))/TOTAL_MASS;
thetaacc = (GRAVITY*sin(theta) - cos(theta)*temp)/(LENGTH*(FOURTHIRDS - MASSPOLE*cos(theta)*cos(theta)/TOTAL_MASS));
xacc = temp - POLEMASS_LENGTH*thetaacc*cos(theta)/TOTAL_MASS;

%使用Euler's方法更新四个状态变量。
xNext = x + TAU*xDot;
xDotNext = xDot + TAU*xacc;
thetaNext = theta + TAU*thetaDot;
thetaDotNext = thetaDot + TAU*thetaacc;

return;
