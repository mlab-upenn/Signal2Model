function [ connected_cells ] = connected_cells( cell_idx, path_table )
% Function to find the connected cells in the Heart graph
% cell_idx - Current cell identifier
% path_table - the Heart graph
% returns an array with the cell ids
connected_cells = [];

for idx=1:size(path_table,1),
    if cell2mat(path_table(idx,3)) == cell_idx,
        connected_cells = [connected_cells cell2mat(path_table(idx,4))];
    end
end

end

