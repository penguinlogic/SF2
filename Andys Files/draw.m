function draw(data, map);
% draw_new(data, map)
% displays data as an image with colormap map
% if map is not given, greyscale is assumed

% ensure we have the right input parameters
error(nargchk(1,2, nargin, 'struct'));
if (nargin==1)
  map = [0:255]'*ones(1,3)*(1/255);
end

% ensure the displayed image starts from 0
image(data-min(min(data)));

% draw image in current figure
axis image;  % equal aspect ratio
axis off;       % no axes
set(gca,'Position',[0 0 1 1]); % fill the figure
set(gcf,'Color',[0 0 0]);        % black surround
colormap(map);
