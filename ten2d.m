function y=ten2d(x,n)
%�������ʮ����ת��Ϊ�����ƾ������
y=zeros(1,n);
for i=1:n
    y(i)=rem(x,2);
    x=floor(x/2);
end
y=fliplr(y);