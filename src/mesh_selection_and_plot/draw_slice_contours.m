function [] = draw_slice_contours(srt_itx_vtx_lsts)
%% draw_slice_contours : function to draw the contour(s) of one given mesh
% slice.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input argument
%
% - srt_itx_vtx_lsts, celle array of positive integer row vector double. The sorted intersecting vertex lists. Mandatory.


%% Body
S = size(srt_itx_vtx_lsts{1,1},1);

for i = 1:S
    
    srt_itx_vtx_lst = cell2mat(srt_itx_vtx_lsts{1,1}(i,1));
    
    line(srt_itx_vtx_lst(:,1),...
         srt_itx_vtx_lst(:,2),...
         srt_itx_vtx_lst(:,3),...
         'Color',[1 0 0],'LineWidth',2);        
    
end


end % draw_slice_contours