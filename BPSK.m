function [bpsk,t]=BPSK(b,R,fc,fs)
%fc�� �ز�Ƶ��
%fs:   ��������
A=1;%A��  ��ֵ
[~,k]=size(b);%k��  Ϊ��Ԫ����
%R����Ԫ����
N = k/R*fs;
Npc = 1/R*fs;
l = 0;
bpsk = zeros(1,N);
carry1 = zeros(1,N);
carry2 = zeros(1,N);
t = zeros(1,N);
for i=1:k
   for j = l:l+Npc-1
       t(1,j+1) = j/fs;
       carry1(1,j+1) = cos(2*pi*fc*t(1,j+1));
       carry2(1,j+1) = cos(2*pi*fc*t(1,j+1) + pi);
       if b(1,i)==0
         bpsk(1,j+1) = A*carry1(1,j+1);
       elseif b(1,i)==1
         bpsk(1,j+1) = A*carry2(1,j+1);
       end
   end
   l = l+Npc;
end
