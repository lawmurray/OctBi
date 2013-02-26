% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_plot_paths (@var{file}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{col}, @var{sty})
%
% Plot LibBi output. For temporal variables this plots sample trajectories as
% lines.
%
% @itemize
% @item @var{file} Name of NetCDF file output by LibBi.
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
function bi_plot_paths (file, name, coord, ps, ts, col, sty)
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
    times = bi_read_times (nc, name, coord, ts);
    X = bi_read_paths (nc, name, coord, ps, ts);
    
    % plot
    style = get_style (col, sty, file, name);
    style.linewidth = 1;
    plot (times, X, struct2options (style){:});
    
    ncclose (nc);
end
