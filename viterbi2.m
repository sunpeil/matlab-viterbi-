function y=viterbi2(x,G,n,k,m)
%x为收到的编码信号
%G为生成矩阵,二进制
%（n,k,m）卷积码
a=size(x);
s=a(2)*k/n;%译码后的序列为x的k/n
r=zeros(1,s);  %最终结果存放
ra=zeros(2^m,s+1);%2^m条路径
tempra=zeros(2^m,s+1);%每个时刻的最小路径值
Fa=zeros(2^m,1);
%转移矩阵
g=size(G);
q=g(2)-1;
%b1,b2的转移矩阵
T1=inf(2^m,2^m);
T2=inf(2^m,2^m);
for i=0:2^m-1
    z=ten2d(i,q);
    T1(i+1,floor((i+8)/2)+1)=mod(1+sum(z.*G(1,2:end)),2);
    T1(i+1,floor((i+0)/2)+1)=mod(0+sum(z.*G(1,2:end)),2);
    T2(i+1,floor((i+8)/2)+1)=mod(1+sum(z.*G(2,2:end)),2);
    T2(i+1,floor((i+0)/2)+1)=mod(0+sum(z.*G(2,2:end)),2);
end
temp=0;
%8种状态：
%s0-s7(二进制):000,001,010,011,100,101,110,111
%ra储存的是每个时刻的状态（十进制）
%初始状态为s0
next_state=zeros(2^m,n);%每条路该时刻的下一时刻的可能的状态
ra_temp=zeros(2,s+1);
for j=1:s
    if temp >=m
        temp = temp-1;
        %第四次之后的比选
        %找到距离最大的4个行，将将它们删除
        for jj=1:4
            [~,db]=max(tempra(:,j));
            tempra(db,:)=[];
            ra(db,:)=[];
        end
        %第四次之后的加
        for i=1:2^temp
            next_state(i,:)=find(T1(ra(i,j)+1,:)~=inf)-1;%下一可能的状态（每个可能对应2个可能）
            %计算第一个可能和已知的接受的距离
            Fa(i,1)=dis(x(2*j-1),x(2*j),T1(ra(i,j)+1,next_state(i,1)+1),T2(ra(i,j)+1,next_state(i,1)+1));
            %计算第二个可能和已知的接受的距离
            Fa(i,2)=dis(x(2*j-1),x(2*j),T1(ra(i,j)+1,next_state(i,2)+1),T2(ra(i,j)+1,next_state(i,2)+1));
            ra(i+2^temp,:)=ra(i,:);
            tempra(i+2^temp,:)=tempra(i,:);
            ra(i,j+1)=next_state(i,1);
            ra(i+2^temp,j+1)=next_state(i,2);
            %距离累加
            tempra(i,j+1)=tempra(i,j)+Fa(i,1);
            tempra(i+2^temp,j+1)=tempra(i+2^temp,j)+Fa(i,2);
        end
        %第四次之后的比选
        temp=temp+1;
    else
        for i=1:2^temp
            
            %前4次加
            %当前状态：ra(i,j)，该可能的最小路径为tempra(i,j)
            next_state(i,:)=find(T1(ra(i,j)+1,:)~=inf)-1;%下一可能的状态（每个可能对应2个可能）
            %计算第一个可能和已知的接受的距离
            Fa(i,1)=dis(x(2*j-1),x(2*j),T1(ra(i,j)+1,next_state(i,1)+1),T2(ra(i,j)+1,next_state(i,1)+1));
            %计算第二个可能和已知的接受的距离
            Fa(i,2)=dis(x(2*j-1),x(2*j),T1(ra(i,j)+1,next_state(i,2)+1),T2(ra(i,j)+1,next_state(i,2)+1));
            ra(i+2^temp,:)=ra(i,:);
            tempra(i+2^temp,:)=tempra(i,:);
            ra(i,j+1)=next_state(i,1);
            ra(i+2^temp,j+1)=next_state(i,2);
            %距离累加
            tempra(i,j+1)=tempra(i,j)+Fa(i,1);
            tempra(i+2^temp,j+1)=tempra(i+2^temp,j)+Fa(i,2);
        end
        temp=temp+1;
    end
end
%最后将剩下的路径选出最佳的一条
for jj=1:2^temp-1
    [~,db]=max(tempra(:,j+1));
    tempra(db,:)=[];
    ra(db,:)=[];
end
r=ra(2:end);%第一时刻后的状态所在，最初态为0
for i=1:size(r,2)-m
    y(:,i)=ten2d(r(i),m);
end
y=y(1,:);

