function [] = plot_bounding_box(bbox)
%% plot_bounding_box : function to plot the bounding box of the mesh (T) in a Matlab (R) figure.
% Use plot_mesh function to plot the mesh before. 
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input argument
%
% - bbox : real row vector double, the bounding box, size(bbox) = [1,6],
%          bbox = [xmin xmax ymin ymax zmin zmax]. Mandatory.


%% Body
xmin = bbox(1,1);
xmax = bbox(1,2);
ymin = bbox(1,3);
ymax = bbox(1,4);
zmin = bbox(1,5);
zmax = bbox(1,6);

patch([xmin xmax xmax xmin],[ymin ymin ymax ymax],[zmin zmin zmin zmin],'yellow'), hold on;
patch([xmin xmax xmax xmin],[ymin ymin ymax ymax],[zmax zmax zmax zmax],'yellow'), hold on;
patch([xmin xmax xmax xmin],[ymin ymin ymin ymin],[zmin zmin zmax zmax],'yellow'), hold on;
patch([xmin xmax xmax xmin],[ymax ymax ymax ymax],[zmin zmin zmax zmax],'yellow'), hold on;
patch([xmin xmin xmin xmin],[ymin ymax ymax ymin],[zmin zmin zmax zmax],'yellow'), hold on;
patch([xmax xmax xmax xmax],[ymin ymax ymax ymin],[zmin zmin zmax zmax],'yellow'), hold on;

axis equal, axis tight;
alpha(0.25);


end % plot_bounding_box