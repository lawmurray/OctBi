% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_plot_quantiles (@var{file}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{col}, @var{sty})
%
% Plot LibBi output. For temporal variables this plots the time marginals with
% a bold line giving the medians, and shaded region giving the 95% credibility
% intervals.
%
% @itemize
% @item @var{file} NetCDF file.
%
% @item @var{name} Name of the variable to plot.
%
% @item @var{coord} (optional) Dimension indices.
%
% @item @var{ps} (optional) Path indices.
%
% @item @var{ts} (optional) Time indices.
%
% @item @var{col} (optional) Colour index.
%
% @item @var{sty} (optional) Style index.
% @end itemize
% @end deftypefn
%
function bi_plot_quantiles (file, name, coord, ps, ts, col, sty)
% check arguments
    if nargin < 2 || nargin > 7
        print_usage ();
    end
    if !ischar (file)
        error ('file must be a string');
    end
    if !ischar (name)
        error ('name must be a string');
    end
    if nargin < 3
        coord = [];
    elseif !isempty (coord) && !isvector (coord)
        error ('coord must be a vector');
    end
    if nargin < 4
        ps = [];
    elseif !isempty (ps) && !isvector (ps)
        error ('ps must be a vector');
    end
    if nargin < 5
        ts = [];
    elseif !isempty (ts) && !isvector (ts)
        error ('ts must be a vector');
    end
    if nargin < 6
        col = [];
    end
    if nargin < 7
        sty = [];
    end
    
    % input file
    nc = netcdf (file, 'r');
    
    % data
    times = bi_read_times (nc, name, ts);
    qs = [0.025 0.5 0.975]';
    Q = bi_read_quantiles (nc, name, coord, ps, ts, qs);
    
    % plot
    style = get_style (col, sty, file, name);
    ish = ishold;
    if !ish
        clf % patch doesn't clear otherwise
    end
    
    area_between (times, Q(:,1), Q(:,3), style.color, 1.0, 0.3);
    hold on
    plot (times, Q(:,2), struct2options (style){:});
    if ish
        hold on
    else
        hold off
    end
    
    ncclose (nc);
end
