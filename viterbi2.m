function y=viterbi2(x,G,n,k,m)
%xΪ�յ��ı����ź�
%GΪ���ɾ���,������
%��n,k,m�������
a=size(x);
s=a(2)*k/n;%����������Ϊx��k/n
r=zeros(1,s);  %���ս�����
ra=zeros(2^m,s+1);%2^m��·��
tempra=zeros(2^m,s+1);%ÿ��ʱ�̵���С·��ֵ
Fa=zeros(2^m,1);
%ת�ƾ���
g=size(G);
q=g(2)-1;
%b1,b2��ת�ƾ���
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
%8��״̬��
%s0-s7(������):000,001,010,011,100,101,110,111
%ra�������ÿ��ʱ�̵�״̬��ʮ���ƣ�
%��ʼ״̬Ϊs0
next_state=zeros(2^m,n);%ÿ��·��ʱ�̵���һʱ�̵Ŀ��ܵ�״̬
ra_temp=zeros(2,s+1);
for j=1:s
    if temp >=m
        temp = temp-1;
        %���Ĵ�֮��ı�ѡ
        %�ҵ���������4���У���������ɾ��
        for jj=1:4
            [~,db]=max(tempra(:,j));
            tempra(db,:)=[];
            ra(db,:)=[];
        end
        %���Ĵ�֮��ļ�
        for i=1:2^temp
            next_state(i,:)=find(T1(ra(i,j)+1,:)~=inf)-1;%��һ���ܵ�״̬��ÿ�����ܶ�Ӧ2�����ܣ�
            %�����һ�����ܺ���֪�Ľ��ܵľ���
            Fa(i,1)=dis(x(2*j-1),x(2*j),T1(ra(i,j)+1,next_state(i,1)+1),T2(ra(i,j)+1,next_state(i,1)+1));
            %����ڶ������ܺ���֪�Ľ��ܵľ���
            Fa(i,2)=dis(x(2*j-1),x(2*j),T1(ra(i,j)+1,next_state(i,2)+1),T2(ra(i,j)+1,next_state(i,2)+1));
            ra(i+2^temp,:)=ra(i,:);
            tempra(i+2^temp,:)=tempra(i,:);
            ra(i,j+1)=next_state(i,1);
            ra(i+2^temp,j+1)=next_state(i,2);
            %�����ۼ�
            tempra(i,j+1)=tempra(i,j)+Fa(i,1);
            tempra(i+2^temp,j+1)=tempra(i+2^temp,j)+Fa(i,2);
        end
        %���Ĵ�֮��ı�ѡ
        temp=temp+1;
    else
        for i=1:2^temp
            
            %ǰ4�μ�
            %��ǰ״̬��ra(i,j)���ÿ��ܵ���С·��Ϊtempra(i,j)
            next_state(i,:)=find(T1(ra(i,j)+1,:)~=inf)-1;%��һ���ܵ�״̬��ÿ�����ܶ�Ӧ2�����ܣ�
            %�����һ�����ܺ���֪�Ľ��ܵľ���
            Fa(i,1)=dis(x(2*j-1),x(2*j),T1(ra(i,j)+1,next_state(i,1)+1),T2(ra(i,j)+1,next_state(i,1)+1));
            %����ڶ������ܺ���֪�Ľ��ܵľ���
            Fa(i,2)=dis(x(2*j-1),x(2*j),T1(ra(i,j)+1,next_state(i,2)+1),T2(ra(i,j)+1,next_state(i,2)+1));
            ra(i+2^temp,:)=ra(i,:);
            tempra(i+2^temp,:)=tempra(i,:);
            ra(i,j+1)=next_state(i,1);
            ra(i+2^temp,j+1)=next_state(i,2);
            %�����ۼ�
            tempra(i,j+1)=tempra(i,j)+Fa(i,1);
            tempra(i+2^temp,j+1)=tempra(i+2^temp,j)+Fa(i,2);
        end
        temp=temp+1;
    end
end
%���ʣ�µ�·��ѡ����ѵ�һ��
for jj=1:2^temp-1
    [~,db]=max(tempra(:,j+1));
    tempra(db,:)=[];
    ra(db,:)=[];
end
r=ra(2:end);%��һʱ�̺��״̬���ڣ����̬Ϊ0
for i=1:size(r,2)-m
    y(:,i)=ten2d(r(i),m);
end
y=y(1,:);

