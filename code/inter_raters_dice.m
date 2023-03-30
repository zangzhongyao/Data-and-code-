function diceEvery=inter_raters_dice(listname)
hz='.nii.gz';
fid=fopen(listname); % opening the list of subjects'name
diceEvery=zeros(15,456); % saving the dice coeffcient of every region in each subject
lujing1=''; % the path of ROIs of the first rater
lujing2=''; % the path of ROIs of the second rater

for q=1:456
    overlapn=zeros(15,1); % saving the number of overlapped voxels of each region
    % saving the area of each region labeled by two raters
    area_1=zeros(15,1);  
    area_2=zeros(15,1);
    % loading the ROIs labeled by two raters in turn
    roi_name=fgetl(fid);
    roi_nameall=strcat(roi_name,hz);
    roi_1=strcat(lujing1,roi_nameall);
    roi_2=strcat(lujing2,roi_nameall);
    roiimg_1=load_nii(roi_1);
    roiimg_2=load_nii(roi_2);
    image_1=roiimg_1.img;
    image_2=roiimg_2.img;
    
    for i=1:91
    for j=1:109
        for k=1:91
            if(image_1(i,j,k)>0||image_1(i,j,k)>0)
              % counting the area of each region of two raters
              if(image_1(i,j,k)>0)
                  area_1(image_1(i,j,k),1) = area_1(image_1(i,j,k),1)+1;    
              end
              if(image_2(i,j,k)>0)
                  area_2(image_2(i,j,k),1) = area_2(image_2(i,j,k),1)+1;    
              end
              % counting the number of overlapped voxels
              if(image_1(i,j,k)==image_2(i,j,k))
                    overlapn(image_1(i,j,k),1)=overlapn(image_1(i,j,k),1)+1;
              end
            end
        end
    end
    end
    % counting the dice coefficient of each region
    for region_num=1:15
        overlapn(region_num,1)= 2*overlapn(region_num,1)/(area_1(region_num,1)+area_2(region_num,1));
        diceEvery(region_num,q)=overlapn(region_num,1);
    end
   
end

end