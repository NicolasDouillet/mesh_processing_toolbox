function [] = draw_slice_contours(srt_itx_vtx_lsts)
% draw_slice_contours : function to draw the contour(s) of one mesh given
% slice.
%
% Author & support : nicolas.douillet (at) free.fr, 2020-2023.


S = size(srt_itx_vtx_lsts{1,1},1);


for i = 1:S
    
    srt_itx_vtx_lst = cell2mat(srt_itx_vtx_lsts{1,1}(i,1));
    
    line(srt_itx_vtx_lst(:,1),...
         srt_itx_vtx_lst(:,2),...
         srt_itx_vtx_lst(:,3),...
         'Color',[1 0 0],'LineWidth',2);        
    
end


end % draw_slice_contours