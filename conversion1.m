clear all;
close all;

file=dir('E:\Normal_dataset\');
for i=3 : size(file,1)
s='E:\Normal_dataset\';

f =imread([s file(i).name]);
 f=imresize(f, [512 512]);

k = f(:,:,1);
rtemp = min(k);         % find the min. value of pixels in all the columns (row vector)
rmin = min(rtemp);      % find the min. value of pixel in the image
rtemp = max(k);         % find the max. value of pixels in all the columns (row vector)
rmax = max(rtemp);      % find the max. value of pixel in the image
m = 255/(rmax - rmin);  % find the slope of line joining point (0,255) to (rmin,rmax)
c =255 - m*rmax;       % find the intercept of the straight line with the axis
i_new = m*k + c;        % transform the image according to new slope
% figure,imshow(i);       % display original image
% figure,imshow(i_new);   % display transformed image



se = strel('disk',12);
bottomhatfiltered = imsubtract(imadd(f,imtophat(f,se)),imbothat(f,se));
% figure
% imshow(bottomhatfiltered)

se2 = strel('disk',12)
tophatFiltered = imtophat(bottomhatfiltered,se2);
% figure
% imshow(tophatFiltered)

mrg=cat(3,i_new,bottomhatfiltered,tophatFiltered);
% figure, imshow(mrg);

se2 = strel('disk',16);
improved = imsubtract(imadd(mrg,imtophat(mrg,se2)),imbothat(mrg,se2));
improved=im2double(improved);
%igure,imshow(improved);

 imwrite(improved,[file(i).name '.JPEG']);
% f1{i,1}=f1;


end