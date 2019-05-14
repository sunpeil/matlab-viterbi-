function dbpsk=DBPSK(bpsk,R,fc,fs,t)
%BPSK��ɽ��
[~,c]=size(bpsk);
B=2*R;
carry = cos(2*pi*fc*t);
dpsk0=bpsk.*carry;
%�˲�������
[f,af] = T2F(t,dpsk0);%����Ҷ�任
[t,dpsk1] = lpf(f,af,B);%ͨ����ͨ�˲���
%�����о�
dbpsk=[];
for m=1:fs/R:c
    s((m-1)/(fs/R)+1) = sum(dpsk1(m:m+fs/R-1));
    if s((m-1)/(fs/R)+1)<0
        dbpsk((m-1)/(fs/R)+1)=1;
    else
        dbpsk((m-1)/(fs/R)+1)=0;
    end
end


