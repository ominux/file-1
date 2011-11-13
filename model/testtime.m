function [ttt,mxx,mnn]=testtime(sz1,sz2, multi)
% sz1=10;
% sz2=5;
full=zeros(sz1,sz2);
length=20e-6;
rad=1e-6;
tox=50e-9;
ppp=full;
for ii=1:sz1
    for jj=1:sz2
        rr=6.6e3*normrnd(1,0.03)*multi;
        radd=rad*normrnd(1,0.03*multi);
        lengthh=length*normrnd(1,0.002);
        toxx=tox*normrnd(1,0.05*multi);
        cc=2*pi*3.9*8.85e-12*lengthh/log((radd+toxx)/radd);
        tao=0.63*rr*cc;
        if (ii<2) || (sz1-ii<1) || (jj<2) || (sz2-jj<1)
            tao=tao*1.15;
        end
        ppp(ii,jj)=tao;
        full(ii,jj)=(sign(tao-0.5e-9)+1)/2;
    end
end

ar=size(1,sz1*sz2);
kk=1;
for ii=1:sz1
    for jj=1:sz2
        ar(kk)=1-full(ii,jj);
        kk=kk+1;
    end
end
lll=size(ar,2);
eee=1;
stack=[];
current=[1 lll];
bad=0;
bad_ct=0;
ttt=0;
% display(ar)
while 1
    ck=check_failed_tsv(ar,current);
    ttt=ttt+1;
%     stack
%     current
%     eee
    if ck == 1
        if eee < 3
            break;
        end
        current=stack(1,eee-2:eee-1);
        eee=eee-2;
    elseif current(1)==current(2)
        bad_ct=bad_ct+1;
        bad(bad_ct)=current(1);
        if eee < 3
            break;
        end
        current=stack(1,eee-2:eee-1);
        eee=eee-2;
    else
        stack(1,eee:eee+1)=[current(1)+ceil((current(2)-current(1))/2) current(2)];
        eee=eee+2;
        current=[current(1) current(1)+floor((current(2)-current(1))/2)];
    end
end
        

% display(bad)

mxx=max(max(ppp));
mnn=min(min(ppp));