% Algorithm for estimating ERPs time of each node

% ERP_table: table containing the current ERP information of each node
%            format{
%                   'ERP_min': current minimum ERP bound for node 'i' (default value = 0),
%                   'ERP_max': current maximum ERP bound for node 'i' (default value = 1000, 
%                   'Num_stim': number of stimulus in the current iteration,
%                   'Finished': flag to terminate iteration for node 'i'.}

clearvars
load path_params.mat
clc

% Disabling SA node self activation
% node_table{1,8}=9999;
% node_table{1,7}=9999;

new_node_table=node_table;
new_path_table=path_table;


% Error tolerance level that we are willing to accept
tolerance=40;


ERP_table = zeros(size(node_table,1),4);
for i=1:1:size(node_table,1),
    % Assigning default values 
    ERP_table(i,1)=0;
    ERP_table(i,2)=500;
    ERP_table(i,3)=0;
    ERP_table(i,4)=0;
end


% Variable counting the number of pacings
pace_counter=0;
% Variable to check whether there still are nodes with ERP undetermined
execute_while=1;

% Index of SA node
sa_idx=1;


% % SA node is treated separately ... (for now)
% sa_array=connected_cells(sa_idx,path_table);
% current_node=sa_array(1);
% 
% 
% SA_ERP_detec=1;
%     
%     while SA_ERP_detec,
%         % Checking if at least one of the connecting cell has ERP
%          % undetermined.
%          SA_ERP_detec=0;
%          
%              node_table(sa_idx,3)=node_table(sa_idx,4);
%              if ERP_table(sa_idx,4)==0,
%                  pace_min=ERP_table(sa_idx,1);
%                  pace_max=ERP_table(sa_idx,2);
%                  SA_ERP_detec=1;
%              end
%        
%          
%          % Setting the pacing frequency for the next 2 paces 
%          pacing_freq = pace_min + (floor((pace_max-pace_min)/2));
%          
%          if SA_ERP_detec,
%             node_table=new_node_table;
%             path_table=new_path_table;
%             % Delivering the two paces
%             j=0;
%             while j<=(pacing_freq+200),
%                  j=j+1;
%                 [node_table,path_table]=heart_model(node_table,path_table);
% 
%                 if j==1 || j==pacing_freq+1,
%                      node_table{current_node,9}=1;
%                      pace_counter=pace_counter+1;
%                 end
%                 % Checking whether the node k is stimulated or not
%                 
%                      if node_table{sa_idx,9} == 1,
%                          ERP_table(sa_idx,3) = ERP_table(sa_idx,3) +1;
%                      end
%          
%                 % End of the inner while 
%             end
%             
%             % Once we have paced twice we check which node got the stimulus
%             % propagated twice, those will be the nodes with ERP smaller than
%             % the current pacing frequency (and viceversa).
%             
%                  if ERP_table(sa_idx,3)==2 && ERP_table(sa_idx,4)==0 && pacing_freq<=ERP_table(sa_idx,2),
%                          ERP_table(sa_idx,2) = pacing_freq;
%                          SA_ERP_detec=1;
%                 else if ERP_table(sa_idx,3)==1 && ERP_table(sa_idx,4)==0 && pacing_freq>=ERP_table(sa_idx,1),
%                           ERP_table(sa_idx,1) = pacing_freq;
%                           SA_ERP_detec=1;
%                     end
%                  end
%                  
%                 % Checking if we have reached the tolerance bound for each
%                 % node
%                 if (ERP_table(sa_idx,2) - ERP_table(sa_idx,1)) <= tolerance,
%                       ERP_table(sa_idx,4) = 1;
%                 end
%                 ERP_table(sa_idx,3)=0;
%             
%         end
%     end
%     

% Reset the counter that will iterate until the ERP of each node is found
current_node=sa_idx;


while execute_while,

    % Retrieve all the cells connected to the current cell.
    connected_nodes = connected_cells(current_node,path_table);
    
    ERP_detec=1;
    
    % While loop iterating until all the ERPs of the cells connected to the
    % current node are detected.
    while ERP_detec,
     
         % Checking if at least one of the connecting cell has ERP
         % undetermined.
         ERP_detec=0;
         for k=1:1:size(connected_nodes,2),
             node_table(connected_nodes(1,k),3)=node_table(connected_nodes(1,k),4);
             if ERP_table(connected_nodes(1,k),4)==0,
                 pace_min=ERP_table(connected_nodes(1,k),1);
                 pace_max=ERP_table(connected_nodes(1,k),2);
                 ERP_detec=1;
             end
         end
         
         % Setting the pacing frequency for the next 2 paces 
         pacing_freq = pace_min + (floor((pace_max-pace_min)/2));
         first_activation_flag=0;
         if ERP_detec,
            node_table=new_node_table;
            path_table=new_path_table;
            % Delivering the pace
            j=0;
            i=0;
            while j<=(pacing_freq+200),
                i=i+1;
                if first_activation_flag,
                    j=j+1;
                end
                [node_table,path_table]=heart_model(node_table,path_table);
                for t=1:size(node_table,1),
                    if node_table{t,9}==1,
                     stop=1;
                    end
                end
                if node_table{current_node,9}==1,
                    first_activation_flag=1;
                end
                if j==pacing_freq,
                     node_table{current_node,9}=1;
                     pace_counter=pace_counter+1;
                end
                % Checking whether the node k is stimulated or not
                for k=1:1:size(connected_nodes,2),
                     if node_table{connected_nodes(1,k),9} == 1,
                         ERP_table(connected_nodes(1,k),3) = ERP_table(connected_nodes(1,k),3) +1;
                     end
                end
                % End of the inner while 
            end
            
            % Once we have paced twice we check which node got the stimulus
            % propagated twice, those will be the nodes with ERP smaller than
            % the current pacing frequency (and viceversa).
            for k=1:1:size(connected_nodes,2),
                 if ERP_table(connected_nodes(1,k),3)>=2 && ERP_table(connected_nodes(1,k),4)==0 && pacing_freq<=ERP_table(connected_nodes(1,k),2),
                         ERP_table(connected_nodes(1,k),2) = pacing_freq;
                         ERP_detec=1;
                else if ERP_table(connected_nodes(1,k),3)==1 && ERP_table(connected_nodes(1,k),4)==0 && pacing_freq>=ERP_table(connected_nodes(1,k),1),
                          ERP_table(connected_nodes(1,k),1) = pacing_freq;
                          ERP_detec=1;
                    end
                 end
                 
                % Checking if we have reached the tolerance bound for each
                % node
                if (ERP_table(connected_nodes(1,k),2) - ERP_table(connected_nodes(1,k),1)) <= tolerance && connected_nodes(1,k)~=current_node,
                      ERP_table(connected_nodes(1,k),4) = 1;
                end
                ERP_table(connected_nodes(1,k),3)=0;
            end
         else
             current_node=current_node+1;
        end
    end
    
    % Checking if there still are nodes to be analysed
    if current_node == size(node_table,1),
        execute_while=0;
    end

% End of out while loop
end

% while_var=1;
% ad_hoc_counter=0;
% first_act=1;
% j=0;
% k=0;
% node_table{1,3}=500;
% node_table{1,4}=500;
% while while_var,
%     j=j+1;
%     [node_table,path_table]=heart_model(node_table,path_table);
%     if node_table{1,9}==1 & first_act,
%         first_act=0;
%     end
%     if ~first_act,
%         k=k+1;
%         if k==520,
%             node_table{1,9}=1;
%         end
%         if k>= 600,
%            while_var=0;
%         end
%     end
%     if node_table{4,9} == 1,
%         ad_hoc_counter=ad_hoc_counter+1;
%     end
% end
% ad_hoc_counter
