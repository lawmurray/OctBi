% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {} plot_phase (@var{in}, @var{invar1}, @var{invar2}, @var{coord}, @var{rang})
%
% Plot trajectories output by simulate, predict, pf, mcmc or likelihood
% program.
%
% @itemize
% @item @var{in} Input file. Gives the name of a NetCDF file output by
% simulate.
%
% @item @var{invar1} Name of variable from input file to plot along
% x-axis.
%
% @item @var{invar2} Name of variable from input file to plot along
% y-axis.
%
% @item @var{coord} (optional) Vector of spatial coordinates of zero
% to three elements, giving the x, y and z coordinates of a
% component of @var{invar} to plot.
%
% @item @var{rang} (optional) Vector of indices of trajectories to
% plot. All trajectories plotted if not specified.
% @end itemize
% @end deftypefn
%
function plot_phase (in, invar1, invar2, coord, rang)
    % check arguments
    if nargin < 3 || nargin > 5
        print_usage ();
    end
    if nargin < 4
        coord = [];
        rang = [];
    elseif nargin < 5
        rang = [];
    end
    if !check_coord (coord)
        error ('coord should be a vector with at most three elements');
    end
  
    % input file
    nci = netcdf(in, 'r');

    % data
    if ncdimexists(nci, 'np')
        P = nci('np')(:);
    else
        P = 1;
    end
    if length(rang) == 0
        rang = [1:P];
    end
    
    x1 = read_var (nci, invar1, coord, rang);
    x2 = read_var (nci, invar2, coord, rang);
    
    % plot
    plot(x1, x2, 'linewidth', 1, 'color', watercolour(1));
    %title(nice_name(name, dims));
    %plot_defaults;
    
    ncclose(nci);
end
