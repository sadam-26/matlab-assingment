clc; 
img = imread('kkk.jpg'); 
FaceDetect = vision.CascadeObjectDetector; 
FaceDetect.MergeThreshold = 7 ;
BB = step(FaceDetect, img); 
facecount = size(BB, 1);
for i = 1 : facecount
  J = imcrop(img, BB(i, :));
  J = imresize(J,[300, 300]);
  imwrite(J, sprintf('%d.jpg', i));
end

filename = 'gif_animation.gif';
I1 = imread('1.jpg');
[im,map] = rgb2ind(I1,255);
imwrite(im,map,filename,'DelayTime',0,'Loopcount',inf);
n = 10;                                         
for i = 1: facecount - 1                                
    I1 = imread( sprintf('%d.jpg',i) );         
    I2 = imread( sprintf('%d.jpg',i+1) );
    I1 = double(I1);
    I2 = double(I2);
    for j = 1:n                                 
        I = ( I1 * (n - j) + I2 * ( j - 1 )) / (n-1);
        I = uint8(I);
        [im,map] = rgb2ind(I,255);
        imwrite(im,map,filename,'DelayTime',0.1,'WriteMode','Append');
    end
end

