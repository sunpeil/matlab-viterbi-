function [f,sf]= T2F(t,st)
%利用FFT计算信号的频谱并与信号的真实频谱的抽样比较。
%脚本文件T2F.m定义了函数T2F，计算信号的傅立叶变换。
%Input is the time and the signal vectors,the length of time must greater
%than 2
%Output is the frequency and the signal spectrum
dt = t(2)-t(1);
T=t(end);
df = 1/T;
N = length(st);
f=-N/2*df : df : N/2*df-df;
sf = fft(st);
sf = T/N*fftshift(sf);
