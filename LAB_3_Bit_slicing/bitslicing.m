% Created by Mohit Talwar
% Lab task 3 , Bit plane slicing
% Bit Plane Slicing in MATLAB

% Prompt user to select an image file
[file, path] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp', 'Image Files (*.jpg, *.jpeg, *.png, *.bmp)'}, 'Select an Image');
if isequal(file, 0)
    disp('No file selected.');
    return;
end

% Read the selected image
imagePath = fullfile(path, file);
img = imread(imagePath);
originalimg = img;
% Convert to grayscale if the image is not already grayscale
if size(img, 3) == 3
    img = rgb2gray(img);
end


% Initialize a figure for displaying the results
figure;
sgtitle('Bit Plane Slicing and Image Processing Results');

% Display the original image
subplot(3, 4, 1);
imshow(originalimg);
title('Original Image');

% Display the binary (black and white) version of the image
subplot(3, 4, 2);
imshow(img);
title('Grayscale Image');

% Perform bit-plane slicing
for i = 1:8
    % Extract the ith bit-plane
    bitPlane = bitget(img, i);
    
    % Display the bit-plane
    subplot(3, 4, i + 4); % Starting from the 5th position
    imshow(logical(bitPlane));
    title(['Bit Plane ', num2str(i)]);
end
