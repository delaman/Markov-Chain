function [S] = my_simulation(row, col, start, drift, vol, delta_t,paths,image)
%General:   This will do a monte carlo simulation on a given stock.  It
%will also draw paths of the simulation.
%
%Synopsis:
%    stock_price_simulation(row, col, start, drift, vol, delta_t, paths,image )
%Input:
%    row = how many simulations
%    col = how many time steps
%    start = the starting stock price
%    drift = constant drift in decimal format (.15,.40,...etc)
%    vol = constant volatility in decimal format (.43,.2,...etc)
%    delta_t = the delta change 
%                ie) a delta_t for one month of a year would be 1/12
%                ie) a delta-t for one day of a month would be 1/30
%    paths =  number of paths
%    image =  enter 0 to not save the figure.  enter 1 to save the figure.
%
%  Example:   stock_price_simulation(1000,100,25,.15,.20,1/12,50,0);

tic;
%randn('state',129239721);
S = randn(row,col + 1);

S(:,1)=start;

for i=1:row

for j=2:(col + 1)

   S(i,j) = S(i,j-1) + S(i,j-1)* drift *(1/col)*delta_t + S(i,j-1) * sqrt( vol *(1/col)*delta_t)*S(i,j);
end;

end;

%clear previous graph if any
clf(figure(1));
%plot simulated paths
figure(1);
for h=int32(1):int32(row/paths):int32(row);
plot(S(h,1:(col+1)), 'Color',[rand,rand,rand])
xlim([1 (col +1)])
hold all;
end;
title(['Starting stock price=',num2str(start), ',  T=',num2str(col),',  Realizations=',num2str(row),',  \mu=',num2str(drift),',  \sigma=',num2str(vol),',  paths=',num2str(paths)])
xlabel('time step')
ylabel('stock price')

%plot average path

figure(2);

t = mean(S);

color=[rand^3,rand^2,rand^2];
plot(t(1,:), 'Color',color);
xlim([1 (col)]);
title(['Average sampel path',',  Starting stock price=',num2str(start), ',  T=',num2str(col),',  Realizations=',num2str(row),',  \mu=',num2str(drift)]);
text(10*99*vol,t(1,int32(10*99*vol)),['\sigma','=',num2str(vol),', \mu',num2str(drift)],'HorizontalAlignment','center','BackgroundColor',color)
xlabel('time step')
ylabel('Average stock price from simulations')
hold on;
toc;

%option to save the figure automaticly
if image == 1
        print('-dpdf','-r300',['simulations_',num2str(row)]);
else
    return;
end;