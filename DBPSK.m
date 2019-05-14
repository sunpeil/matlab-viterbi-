function dbpsk=DBPSK(bpsk,R,fc,fs,t)
%BPSK相干解调
[~,c]=size(bpsk);
B=2*R;
carry = cos(2*pi*fc*t);
dpsk0=bpsk.*carry;
%滤波器设置
[f,af] = T2F(t,dpsk0);%傅里叶变换
[t,dpsk1] = lpf(f,af,B);%通过低通滤波器
%抽样判决
dbpsk=[];
for m=1:fs/R:c
    s((m-1)/(fs/R)+1) = sum(dpsk1(m:m+fs/R-1));
    if s((m-1)/(fs/R)+1)<0
        dbpsk((m-1)/(fs/R)+1)=1;
    else
        dbpsk((m-1)/(fs/R)+1)=0;
    end
end


