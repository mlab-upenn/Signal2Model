clear all
close all
load case3_AVNRT
% loading parameters of virtual heart model (VHM)
 clk=0;
 % global clock (one iteration represents 1 ms)
 data=[];
 % virtual electrogram that we want to print (matrix containing activation
 % state of each node
 % 1 = activated
 % 0 = inactivated
 while clk<3000
     % run this algorithm for 3000 iterations (i.e. 3 seconds)
     clk=clk+1;
     if clk==1 || mod(clk,380)==0 %==1 || clk==600 || clk==940
         node_table{1,10}=1;
         % activate node one (SA node) on the first iteration and every 380 ms thereafter
     end
     data=[data,[node_table{1,10},node_table{2,10},node_table{4,10},node_table{7,10},node_table{3,4}]'];
     % importing the activation states of the nodes for which there are
     % probes
    [node_table,path_table]=heart_model(node_table,path_table);
    % running heart model for one iteration (and outputting result back
    % into node_table and path_table)
     
    
     
 end
 
 figure
 axes('nextplot','add');
 for i=1:4%size(data,1)
     plot(data(i,:)-i*1.5);
 end