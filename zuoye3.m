clc;
clear;
%输入序列a：
%a=[1,1,0,1,1,0,0,0,1,1,1,1];
k=10000;
a=randi(2,1,k)-1;%k个信号
%卷积编码(2,1,3),生成矩阵[1,1,0,1;1,1,1,1]
G=[1,1,0,1;1,1,1,1];
[b,R]=convolutional_code(a);
%BPSK调制后
fc_s=5;%调制载波频率
fs_s=20;%调制采样频率
[c,t_s]=BPSK(b,R,fc_s,fs_s);
%通过AWGN信道
snr=10;
d=awgn(c,snr,'measured');
%理想同步
%载波同步
fc_r = fc_s;
fs_r = fs_s;
t_r = t_s;
%BPSK解调后
e=DBPSK(d,R,fc_r,fs_r,t_r);
%译码方法 Viterbi 算法
y=viterbi2(e,G,2,1,3);
%y=viterbi(dbpsk)
error=size(find(y~=a),2)/k;
%包括软判决和硬判决性能。
%误码性能结果图