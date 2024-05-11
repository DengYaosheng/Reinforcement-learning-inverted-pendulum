%状态空间离散化，给定一个状态，返回数字，用于表示当前状态。
function box = getBox4(theta,thetaDot,x,xDot)
theta = rad2deg(theta); % 将角的单位从弧度转换为度
thetaDot = rad2deg(thetaDot); % 将角的单位从弧度转换为度
if (x < -2.4 || x > 2.4  || theta < -12 || theta > 12)     
    box = 163;
else

if (theta<-6&&theta>=-12)
	thetaBucket = 1;
elseif (theta<-1&&theta>=-6)
	thetaBucket = 2;
elseif (theta<0&&theta>=-1)
	thetaBucket = 3;
elseif (theta<1&&theta>=0)	% zero included
	thetaBucket = 4;
elseif (theta<6&&theta>=1)
	thetaBucket = 5;
elseif (theta<=12&&theta>=6)
	thetaBucket = 6;
end

if (x<-0.8&&x>=-2.4)
	xBucket = 1;
elseif (x<=0.8&&x>=-0.8)
	xBucket = 2;
elseif (x<=2.4&&x>0.8)
	xBucket = 3;
end

if (xDot<-0.5)
	xDotBucket = 1;
elseif (xDot>=-0.5&&xDot<=0.5)
	xDotBucket = 2;
else
	xDotBucket = 3;
end

if (thetaDot<-50)
	thetaDotBucket = 1;
elseif (thetaDot>=-50&&thetaDot<=50)
	thetaDotBucket = 2;
else
	thetaDotBucket = 3;
end

box = sub2ind([6,3,3,3],thetaBucket, thetaDotBucket,xBucket,xDotBucket);%将下标转换为线性索引
end
return;