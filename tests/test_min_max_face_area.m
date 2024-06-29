% test min_max_face_area

clc;

addpath(genpath('../src'));
addpath('../data');


filenames = {'tetrahedron';... % min = 2/sqrt(3);       max = 2/sqrt(3)       -> ok
             'cube';...        % min = 2/3;             max = 2/3             -> ok
             'octahedron';...  % min = sqrt(3)/2;       max = sqrt(3)/2       -> ok
             'icosahedron';... % min = sqrt(3)/(2+phi); max = sqrt(3)/(2+phi) -> ok
             'dodecahedron'    % min =                  max =                                                       
             };

id = 4; % €|[ 1; 5 ]|
filename = strcat(cell2mat(filenames(id,1)),'.mat');         
load(filename);

disp('Minimum face area of the mesh is : ');
minfa = min_face_area(V,T)

disp('Maximum face area of the mesh is : ');
maxfa = max_face_area(V,T)