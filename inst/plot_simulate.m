% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {} plot_simulate (@var{in}, @var{invar}, @var{coord}, @var{ps}, @var{ts})
%
% Plot output of the simulate program.
%
% @itemize
% @item @var{in} Input file. Gives the name of a NetCDF file output by
% simulate.
%
% @item @var{invar} Name of variable from input file to plot.
%
% @item @var{coord} (optional) Vector of spatial coordinates of zero
% to three elements, giving the x, y and z coordinates of a
% component of @var{invar} to plot.
%
% @item @var{ps} (optional) Trajectory indices.
%
% @item @var{ts} (optional) Time indices.
% @end itemize
% @end deftypefn
%
function plot_simulate (in, invar, coord, ps, ts)
    % check arguments
    if nargin < 2 || nargin > 5
        print_usage ();
    end
    if nargin < 3
        coord = [];
    elseif !check_coord (coord)
        error ('coord should be a vector with at most three elements');
    end
    if nargin < 4
        ps = [];
    end
    if nargin < 5
        ts = [];
    end
    
    % input file
    nci = netcdf(in, 'r');

    % data
    P = length (nci('np'));
    T = length (nci('nr'));
    if isempty (ps)
        ps = [1:P];
    end
    if isempty (ts)
        ts = [1:T];
    end

    t = nci{'time'}(ts)'; % times
    q = [0.025 0.5 0.975]'; % quantiles (median and 95%)
    X = read_var (nci, invar, coord, ps, ts);
    Q = quantile (X, q, 2);
    
    % plot
    ish = ishold;
    if !ish
        cla % patch doesn't clear otherwise
    end
    area_between(t, Q(:,1), Q(:,3), gray()(48,:), 1.0, 0.2);
    hold on
    plot(t, Q(:,2), 'linewidth', 3, 'color', gray()(48,:));
    if ish
        hold on
    else
        hold off
    end
    %title(nice_name(name, dims));
    %plot_defaults;
    
    ncclose(nci);
end
