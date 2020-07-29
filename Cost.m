function T=Cost(gama ,v0,fr,L,l,h,g,r,mass)
conds=0;
condt=0;
% mikhore be sotoon :????
rr=roots([v0*cos(gama) (-fr*v0*cos(gama)/mass)-l  ]);
[~,makans]=law(gama,v0,rr,fr,mass);

if(makans>h)
   conds=0;
else
    conds=h-makans;
end

 %mikhore to tasht ???
 R=roots ([.5*g  -sin(gama)*v0  fr*v0*sin(gama)/mass]); 
 sort(R);
 [makant,~]=law(gama,v0,R(1),fr,mass);

if(makant>=L-r && makant<=L+r)
 condt=0;
end
 if( makant<L-r )
  condt=L-r-makant;
 end
 if( makant>L+r )
  condt=makant-L-r;
end


    T=v0*cos(gama)*R(1) -(fr*v0*cos(gama)/mass)+(condt*80)+(conds*50);