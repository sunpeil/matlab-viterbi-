function [b,R]=convolutional_code(a)
%a: 输入序列
%记为(n,k,m)卷积码
n=2;%n: 输出码字长度
k=1;%k: 输入信息长度
m=3;%m: 记忆深度
l=m+1;%约束长度
R=k/n;%码率
%卷积码（2，1，3）
%生成多项式为(15,17)8=(13,15)10
%二进制为1101，1111
g1=[1,1,0,1];
g2=[1,1,1,1];
b1=mod(conv(g1,a),2);
b2=mod(conv(g2,a),2);
[~,c]=size(b1);
b=[];
%b：输出序列
for i=1:c
    b=[b,b1(i),b2(i)];
end
