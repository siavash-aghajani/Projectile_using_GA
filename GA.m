clc
clear all
close all


prompt = {'Enter L:','Enter l:','Enter r:','Enter h:','Enter fr:','Enter mass:'};
dlg_title = 'conditon of question';
def={'20','10','3','4','.1','1'};
num_lines = 1;
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer = inputdlg(prompt,dlg_title,num_lines,def,options);





g=9.8;
L=str2double(answer(1));
l=str2double(answer(2));
r=str2double(answer(3));
h=str2double(answer(4));
fr=str2double(answer(5));
mass=str2double(answer(6));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt = {'Enter n generation:','Enter n population:','Enter percent of crossover','Enter percent of mutation'};
dlg_title = 'conditon of genetic algorythm';
def={'100','50','.8','.1'};
num_lines = 1;

options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer = inputdlg(prompt,dlg_title,num_lines,def,options);



nGeneration =str2double(answer(1));
nPop=str2double(answer(2));
pc=str2double(answer(3));
pm=str2double(answer(4));
nc=round(pc*nPop/2);


xmin=[pi/6  10];
xmax=[pi/3 30];
nVar=2;

EmptyChromosome.x=[];
EmptyChromosome.Cost=inf;
pop=repmat(EmptyChromosome,nPop,1);
BestCost=[];


% Generate Initial Population
for i=1:nPop
    pop(i).x=rand(1,nVar).*(xmax-xmin)+xmin;
    pop(i).Cost=Cost(pop(i).x(1),pop(i).x(2),fr,L,l,h,g,r,mass);
end


% Main Loop
for i=1:nGeneration
    popc=repmat(EmptyChromosome,nc*2,1);
    for j=1:nc
        parent1=Select(pop);
        parent2=Select(pop);
        [child1,child2]=Crossover(parent1,parent2,fr,L,l,h,g,r,mass);
        if rand<pm
            child1=Mutation(child1,xmin,xmax,nVar,fr,L,l,h,g,r,mass);
        end
        if rand<pm
            child2=Mutation(child2,xmin,xmax,nVar,fr,L,l,h,g,r,mass);
        end
        
        popc(2*j-1).x(1)=child1.x(1);
        popc(2*j-1).x(2)=child1.x(2);
        popc(2*j-1).Cost=child1.cost;
 
        popc(2*j).x(1)=child2.x(1);
        popc(2*j).x(2)=child2.x(2);
        popc(2*j).Cost=child2.cost;
        
    end
    [~,ind]=sort([pop(:).Cost]);
    BestCost(i)=pop(ind(1)).Cost;
    BestSolution=pop(ind(1)).x;
    pause(.1)
    disp(sprintf('Generation %d: Best Cost=%f',i,BestCost(i)))
    
    pop=[popc; pop(ind(1:(nPop-nc*2)))];
end






% rasm naha


% mikhore be sotoon :????
rr=roots([BestSolution(2)*cos(BestSolution(1))  (-fr*BestSolution(2)*cos(BestSolution(1))/mass)-l ]);
[~,makans]=law(BestSolution(1),BestSolution(2),rr,fr,mass);
plot(l,makans,'go','MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10);
hold on

if(makans>h)
 shart1=sprintf('az sotton rad shod dar noqtheye [%f,%f]',l,makans);
 shart1

end

 %mikhore to tasht ???
 R=roots ([.5*g*mass  -sin(BestSolution(1))*BestSolution(2)*mass fr*BestSolution(2)*sin(BestSolution(1))]); 
 sort(R);
 [makant,~]=law(BestSolution(1),BestSolution(2),R(1),fr,mass);
plot(makant,0,'go','MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10)

if(makant>=L-r && makant<=L+r)
 
shart2= sprintf('dakhele zarf shod dar noqtheye [%f,%f]',makant,0);
shart2
end



line([L-r L+r],[0 0],'linewidth',3)  %ax tasht
hold on

line([l l],[0 h],'linewidth',3)  %ax sotoon


for t=0:.01:100
  [x, y]=(law(BestSolution(1),BestSolution(2),t,fr,mass));
    if y>=0
    plot(x,y,'ro','MarkerSize',5);
  end   
   grid on;
end

disp(sprintf('Behtarin [zavie,sorat]: [%f,%f] ',BestSolution(1),BestSolution(2)))
