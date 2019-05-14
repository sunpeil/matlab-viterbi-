function y=ten2d(x,n)
%将输入的十进制转化为二进制矩阵输出
y=zeros(1,n);
for i=1:n
    y(i)=rem(x,2);
    x=floor(x/2);
end
y=fliplr(y);