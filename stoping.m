function stoping(S,K)
%General:    stoping(S,K)
%input: S   -  a matrix with time steps and simulations
%input:  K - is the strike price

tic;
t(:,size(S,2))=max(K-S(:,size(S,2)),0);

for j=size(S,2):-1:3  
    
count=1;
for i=1:size(S,1)
    if max(K-S(i,j-1),0) >0
    X(count,:) = [1 S(i,j-1) S(i,j-1)^2];
    count=count+1;
    end;
end;

%create v vector
count=1;
for i=1:size(S,1)
    if max(K-S(i,j-1),0)>0
        v(count,:)=t(i,j);
        count=count+1;
    end;
end;
%calculate the OLS parameters only, beta vector
beta = inv(X'*X)*X'*exp(-.06*1)*v;

%small  CF matrix
CF(:,j)=v;
for i =1:size(X,1)
    if K-X(i,2) > X(i,:)*beta
    CF(i,j)=0;
    CF(i,j-1)=K-X(i,2);
    end;
end;

%big CF matrix
count=1;
for i=1:size(S,1)

    if max(K-S(i,j-1),0)>0
        t(i,j)=CF(count,j);
        t(i,j-1)=CF(count,j-1);
        count =count+1;
    end;
end;

clear beta;
clear X;
clear CF;
clear v;
clear i;
clear j;
clear count;
end;

future=0;
% value of the option
for j=2:size(t,2)
future=sum(t(:,j)*exp(-.06*(j-1)))+future;
end
future=future/size(t,1);
current=num2str(K-max(S(1,1),0));
char(['The discounted value of the put option is ',num2str(future)],['The current value of the put option is ',current])
    if current>future
        char('Hold on to the option.  In other words do not excerise the option now')
   
    else
        char('Excerise the option now!')
    end;
clear j;

toc;

