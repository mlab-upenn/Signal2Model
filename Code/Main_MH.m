% Algorithm for estimating ERPs time of each node

% ERP_table: table containing the current ERP information of each node
%            format{
%                   'ERP_min': current minimum ERP bound for node 'i' (default value = 0),
%                   'ERP_max': current maximum ERP bound for node 'i' (default value = 1000, 
%                   'Num_stim': number of stimulus in the current iteration,
%                   'Finished': flag to terminate iteration for node 'i'.}

clearvars
load n4p3.mat
clc

% State Machine:
%       state = 0 Waiting for self activation of current node;
%       state = 1 Waiting for neighbouring activation;
%       state = 2 Delivering pace;
%       state = 3 Waiting for neighbouring activation and reset
%       pacing_freq;


% Maximum conduction delay
MAX_CONDUCT_DELAY=400;

time_elapsed_pace=0;

% Error tolerance level that we are willing to accept
tolerance=40;

ERP_table = zeros(size(node_table,1),2);
for i=1:1:size(node_table,1),
    % Assigning default values 
    ERP_table(i,1)=0;
    ERP_table(i,2)=500;
end


% Variable counting the number of pacings
pace_counter=0;
% Variable to check whether there still are nodes with ERP undetermined
execute_while=1;


% Reset the counter that will iterate until the ERP of each node is found
current_node=1;

pace_min=0;
pace_max=500;
pacing_freq = pace_min + (floor((pace_max-pace_min)/2));
% Time elapsed since the activation of the current cell;
time_elapsed=0;
first_act_flag=0;

state_machine = 0;
current_node_terminated=0;
while execute_while,
    % Retrieve all the cells connected to the current cell.
    connected_nodes = connected_cells(current_node,path_table);
    
    % Moving VHM
    [node_table,path_table]=heart_model(node_table,path_table);

   switch state_machine
        case 0
             if node_table{current_node,9}==1,
               state_machine=1;
             end
         
        case 1
           % Start counting for the next scheduled pace
           time_elapsed=time_elapsed + 1;
           if ~isempty(find(cell2mat(node_table(connected_nodes,9)))),
               state_machine=2; 
           end            
           
        case 2
            time_elapsed=time_elapsed + 1;
            if time_elapsed == pacing_freq,
                  time_elapsed_pace=0;
                  % Deliver the pace
                  node_table{current_node,9}=1;
                  state_machine = 3;
            end
          
        case 3
            time_elapsed_pace=time_elapsed_pace+1;
            if time_elapsed_pace<=MAX_CONDUCT_DELAY && ~isempty(find(cell2mat(node_table(connected_nodes,9)))),               
               % ERP current node lower than pacing frequency
               pace_max = pacing_freq;
               pacing_freq = pace_min + (floor((pace_max-pace_min)/2));
               if pace_max-pace_min <= tolerance,
                   current_node_terminated=1;
               end
               state_machine=0;
               time_elapsed=0;
            else if time_elapsed_pace>MAX_CONDUCT_DELAY,
                    % ERP current node bigger than pacing frequency
                    pace_min = pacing_freq;
                    pacing_freq = pace_min + (floor((pace_max-pace_min)/2));
                    if pace_max-pace_min <= tolerance,
                       current_node_terminated=1;
                    end
                    state_machine=0;
                    time_elapsed=0;
                end
            end        
    end
     if current_node_terminated,
         ERP_table(current_node,1)=pace_min;
         ERP_table(current_node,2)=pace_max;
         current_node=current_node+1;
         if current_node == size(node_table,1),
            execute_while=0;
         else
             pace_min=ERP_table(current_node,1);
             pace_max=ERP_table(current_node,2);
             pacing_freq= pace_min + (floor((pace_max-pace_min)/2));
             current_node_terminated=0;
         end
     end
        

% End of out while loop
end


