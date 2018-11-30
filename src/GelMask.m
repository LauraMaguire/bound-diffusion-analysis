function [masks, area, perimeter] = GelMask(Ntrials,images, xyScale)
masks = cell(Ntrials,1);
area = zeros(Ntrials,1);
perimeter = zeros(Ntrials,1);
%tauD = zeros(Ntrials,1);
for n=1:Ntrials
    imlimits = stretchlim(images{n});
    figure
    imshow(images{n},imlimits);
    accept = input('Is gel entirely within image? (y/n) \n','s');
    if strcmp(accept,'y')
        [~, ~, masks{n}, ~, ~] = roipoly();
        close(gcf)
        area(n) = xyScale*xyScale*sum(sum(masks{n})); % 1.58 microns per pixel at 4x
        perimeter(n) = xyScale*sum(sum(bwperim(masks{n}))); % sum over perimeter segments
%         figure
%         subplot(2,2,1)
%         imshow(images{n},imlimits);
%         subplot(2,2,2)
%         imshow(masks{n});
%         subplot(2,2,3)
%         imshow(bwperim(masks{n}));
    else
        disp(['Skipping experiment ' num2str(n) ' .']);
    end
end
end