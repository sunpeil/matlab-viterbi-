clc;
clear;
%��������a��
%a=[1,1,0,1,1,0,0,0,1,1,1,1];
k=10000;
a=randi(2,1,k)-1;%k���ź�
%�������(2,1,3),���ɾ���[1,1,0,1;1,1,1,1]
G=[1,1,0,1;1,1,1,1];
[b,R]=convolutional_code(a);
%BPSK���ƺ�
fc_s=5;%�����ز�Ƶ��
fs_s=20;%���Ʋ���Ƶ��
[c,t_s]=BPSK(b,R,fc_s,fs_s);
%ͨ��AWGN�ŵ�
snr=10;
d=awgn(c,snr,'measured');
%����ͬ��
%�ز�ͬ��
fc_r = fc_s;
fs_r = fs_s;
t_r = t_s;
%BPSK�����
e=DBPSK(d,R,fc_r,fs_r,t_r);
%���뷽�� Viterbi �㷨
y=viterbi2(e,G,2,1,3);
%y=viterbi(dbpsk)
error=size(find(y~=a),2)/k;
%�������о���Ӳ�о����ܡ�
%�������ܽ��ͼ