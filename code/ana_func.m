function overlap_ana=ana_func(num_list,ana_atlas)
% the input num_list should be a string of subjects list, 
% for example 'num_subject.txt'
% the input ana_atlas should be a string of the anatomical atlas, 
% for exampe 'H0-2-0.nii.gz'

hz='.nii.gz';
lujing1=''; % the path of final ROIs
fid=fopen(num_list); % opening the list of subjects'name 
overlap_ana=zeros(48,15); % saving the overlap rates betwwen anatomical atlas and functional atlas
number_act=zeros(1,15);% saving the number of subjects who activated the corresponding functional region
for x=1:456
% loading the ROI labeled by two raters
num_name=fgetl(fid);
num_n=strcat(num_name,hz);
num_n=strcat(lujing1,num_n);
m1=load_nii(num_n);
image_roi=m1.img;
%loading the anatomical atlas
m2=load_nii(ana_atlas);
image_temp=m2.img;   

overlap_rates=zeros(48,15);% saving the overlap rates of each subject 
area_roi=[];% saving the area of each functional region

  for q=1:15
      nonzerompm=(image_roi==q);
      count_roi=sum(nonzerompm(:)); %counting the area of the corresponding funcional region
      if count_roi==0
         area_roi(1,q)=1;
      else
         area_roi(1,q)=count_roi;
         number_act(1,q)=number_act(1,q)+1;
      end
      % counting the size of intersection between anatomical and functional region 
      for i=1:91
        for j=1:109
            for k=1:91
                if(image_roi(i,j,k)==q&&image_temp(i,j,k)~=0)
                  overlap_rates(image_temp(i,j,k),q)=overlap_rates(image_temp(i,j,k),q)+1;
                end
            end
        end
      end
  end
overlap_rates=overlap_rates./area_roi; % counting the overlap rates of a subject
 
  for i=1:48
      for j=1:15
          overlap_ana(i,j)=overlap_ana(i,j)+overlap_rates(i,j);
      end
  end
end
overlap_ana=overlap_ana./number_act;  % averagin the overlap rates across all subjects
end


              