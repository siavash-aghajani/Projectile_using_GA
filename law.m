function [X,Y]=law(gama,v0,t,fr,mass)
g=9.8; %gravity




X=v0*t*cos(gama)-(fr*v0*cos(gama)/mass);
Y=v0*t*sin(gama)-(.5*g*t*t)-(fr*v0*sin(gama)/mass);

