function [tmp] = check_black_and_error_comparison(rows,S0,K,r,sigma,T)
tic;
B = randn(rows,1);
[c,p]=blsprice(S0,K,r,T,sigma);

%using the ln|S| method equation
for j=1:rows
    tmp(j,1)= S0 * exp(( r - (sigma*sigma/2))*T + sigma*B(j,1)*sqrt(T) );
    tmp(j,2) = exp( -1*r*T )*max(K-tmp(j,1),0);
end;

%calculate the errors
for j=1:rows
    tmp(j,3)=abs(p-mean(tmp(1:j,2)));
end;

% clear previous graph if any
clf(figure(3));
figure(3);
%plot the error graph
plot(tmp(:,3), 'DisplayName', 'N', 'YDataSource', 'error','Color',[rand,rand,rand^2])
title(['S0=',num2str(S0),',  K=',num2str(K), ',  T=',num2str(T),',  N=',num2str(rows),',  r=',num2str(r),',  \sigma=',num2str(sigma),',  Elapsed time=',num2str(toc),'secs'])
xlabel('N')
ylabel('error of put option')
