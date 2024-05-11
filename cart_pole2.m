%  cart_pole:  ��������ѧģ�ͺ��������������Ƕȡ��Ƕȼ��ٶȡ�λ�á�λ�ü��ٶȡ������и���״̬����
function [thetaNext,thetaDotNext,thetaacc,xNext,xDotNext] = cart_pole2(force,theta,thetaDot,x,xDot)
%���õ����ڲ���
GRAVITY = 9.8;      %�������ٶ�
MASSCART = 1;       %��������
MASSPOLE = 0.1;     %���˵�����
TOTAL_MASS = (MASSPOLE + MASSCART); %���Ӹ��ӵ�����
LENGTH = 0.5; % �ڸ˵���������ת���ĵľ���
POLEMASS_LENGTH = (MASSPOLE*LENGTH); 
TAU = 0.02; %����ʱ����
FOURTHIRDS = 1.3333333333333;

% ��������ѧģ��
temp = (force + POLEMASS_LENGTH*thetaDot*thetaDot*sin(theta))/TOTAL_MASS;
thetaacc = (GRAVITY*sin(theta) - cos(theta)*temp)/(LENGTH*(FOURTHIRDS - MASSPOLE*cos(theta)*cos(theta)/TOTAL_MASS));
xacc = temp - POLEMASS_LENGTH*thetaacc*cos(theta)/TOTAL_MASS;

%ʹ��Euler's���������ĸ�״̬������
xNext = x + TAU*xDot;
xDotNext = xDot + TAU*xacc;
thetaNext = theta + TAU*thetaDot;
thetaDotNext = thetaDot + TAU*thetaacc;

return;
