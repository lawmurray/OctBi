% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_plot_trace (@var{file}, @var{name}, @var{coord}, @var{ps}, @var{t}, @var{col}, @var{sty})
%
% Plot LibBi output. This plots a trace of samples, typically used to visualise
% the mixing of an MCMC algorithm.
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
% @item @var{t} (optional) Time index.
%
% @item @var{col} (optional) Colour index.
%
% @item @var{sty} (optional) Style index.
% @end itemize
% @end deftypefn
%
function bi_plot_trace (file, name, coord, ps, t, col, sty)
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
        t = 1;
    elseif !isempty (t) && !isscalar (t)
        error ('t must be a scalar');
    end
    if nargin < 6
        col = [];
    end
    if nargin < 7
        sty = [];
    end

    % input file
    nc = netcdf (file, 'r');
    P = length (nc('np'));
    if isempty (ps)
        ps = [1:P];
    end
    
    % data
    X = bi_read_paths (nc, name, coord, ps, t);

    % plot
    style = get_style (col, sty, file, name);
    style.linewidth = 1;
    plot (ps, X, struct2options (style){:});
    
    ncclose (nc);
end
