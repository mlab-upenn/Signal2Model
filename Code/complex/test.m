clear all
close all
load case3_AVNRT
 clk=0;
 data=[];
 while clk<3000
     clk=clk+1;
     if clk==1 || mod(clk,500)==0%==1 || clk==600 || clk==940
         node_table{1,10}=1;
     end
     
  if clk==939
      1
  end
    [node_table,path_table]=heart_model(node_table,path_table); 
     
    data=[data,[node_table{2,10},node_table{4,10},node_table{7,10},node_table{3,4}]'];
     
 end
 
 figure
 axes('nextplot','add');
 for i=1:3%size(data,1)
     plot(data(i,:)-i*1.5);
 end