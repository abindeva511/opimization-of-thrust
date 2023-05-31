function B=calculateConfigurationMatrix(T,Az,propNumber,position)
    for i=1:T
        B(1,i)=0;
        B(2,i)=1;
        B(3,i)=position(2*i-1);
    end
    for j=1:Az
        B(1,T+2*j-1)=1;
        B(2,T+2*j-1)=0;
        B(3,T+2*j-1)=-position(2*T+2*j);
        B(1,T+2*j)=0;
        B(2,T+2*j)=1;
        B(3,T+2*j)=position(2*T+2*j-1);
    end
    for k=1:propNumber
        B(1,T+2*Az+3*k-2)=1;
        B(2,T+2*Az+3*k-2)=0;
        B(3,T+2*Az+3*k-2)=-position(2*(T+Az)+2*k);
        B(1,T+2*Az+3*k-1)=0;
        B(2,T+2*Az+3*k-1)=1;
        B(3,T+2*Az+3*k-1)=position(2*(T+Az)+2*k-1);
        B(1,T+2*Az+3*k)=1;
        B(2,T+2*Az+3*k)=0;
        B(3,T+2*Az+3*k)=-position(2*(T+Az)+2*k);
    end
end
