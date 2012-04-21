% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {} plot_kf (@var{in}, @var{invar}, @var{coord}, @var{islog})
%
% Plot output of a Kalman filter.
%
% @itemize
% @item @var{in} Input file. Gives the name of a NetCDF file.
%
% @item @var{invar} Name of variable from input file to plot.
%
% @item @var{coord} (optional) Vector of spatial coordinates of zero
% to three elements, giving the coordinates of a component of @var{invar} to
% plot.
% @end itemize
% @end deftypefn
%
function plot_kf (in, invar, coord)
    % check arguments
    if nargin < 2 || nargin > 3
        print_usage ();
    end
    if nargin < 3
        coord = [];
    end

    % input file
    nci = netcdf (in, 'r');
    lens = ncsizedims (nci, invar);

    if length (coord) != length (lens) - 2 % omit nr and np dimensions
        error ('coord has incorrect number of elements');
    end
    
    len = 1;
    offset = 0;
    for i = 1:length (coord)
        offset = offset + (coord(i) - 1)*len;
        len = len*lens(i + 1);
    end
    
    t = nci{'time'}(:)'; % times
    P = [0.025 0.5 0.975]; % quantiles (median and 95%)
    Q = zeros(length(t), length(P));

    id = nci{strcat('index.', invar)}(:) + 1 + offset;
    mu = nci{invar}(:);
    rs = squeeze(nci{'S_'}(:,id,:));
    cs = squeeze(nci{'S_'}(:,:,id));
    
    for n = 1:length(t)
        sigma = sqrt(rs(n,:)*cs(n,:)');
        if sigma > 0
            Q(n,:) = norminv(P, mu(n), sigma);
        else
            Q(n,:) = mu(n);
        end
    end
            
    % plot
    ish = ishold;
    if !ish
        clf % patch doesn't clear otherwise
    end
    area_between(t, Q(:,1), Q(:,3), watercolour(2));
    hold on;
    plot(t, Q(:,2), 'linewidth', 3, 'color', watercolour(2));
    if ish
        hold on
    else
        hold off
    end
    %title(nice_name(name, dims));
    %plot_defaults;
    
    ncclose(nci);
end
