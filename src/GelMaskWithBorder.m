function [masks, area, perimeter] = GelMaskWithBorder(Ntrials,images, xyScale,masks,area,perimeter)
for n=1:Ntrials
    if area(n) == 0
        imlimits = stretchlim(images{n});
        [nrows,ncols,~] = size(images{n});
        x = zeros(nrows+400,ncols+400);
        x(201:end-200,201:end-200,:) = images{n};
        figure
        imshow(x,imlimits);
        pause(3)
        accept = input('Is this going to work? (y/n) \n','s');
        if strcmp(accept,'y')
            close all
            figure
        imshow(x,imlimits);
        [~, ~, masks{n}, ~, ~] = roipoly();
        close(gcf)
        area(n) = xyScale*xyScale*sum(sum(masks{n})); % 1.58 microns per pixel at 4x
        perimeter(n) = xyScale*sum(sum(bwperim(masks{n}))); % sum over perimeter segments
        end
    end
end

end