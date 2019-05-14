function [t,st]=F2T(f,sf)
%脚本文件F2T.m定义了函数F2T，计算信号的反傅立叶变换。
%This function calculate the time signal using ifft function for the input
df = f(2)-f(1);
Fmx = ( f(end)-f(1) +df);
dt = 1/Fmx;
N = length(sf);
T = dt*N;
%t=-T/2:dt:T/2-dt;
t = 0:dt:T-dt;
sff = fftshift(sf);
st = Fmx*ifft(sff);
