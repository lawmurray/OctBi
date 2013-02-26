% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_plot_ess (@var{file}, @var{ps}, @var{ts})
%
% Compute and plot effective sample size (ESS) at each time from the output
% of a particle filter.
%
% @itemize
% @item @var{file} NetCDF file name.
%
% @item @var{ps} (optional) Path indices.
%
% @item @var{ts} (optional) Time indices.
%
% @item @var{col} (optional) Colour index.
%
% @item @var{sty} (optional) Style index.
%
% @end itemize
% @end deftypefn
%
function bi_plot_ess (file, ps, ts, col, sty)
    % check arguments
    if nargin < 1 || nargin > 2
        print_usage ();
    end
    if nargin < 2
        ps = [];
    end
    if nargin < 3
        ts = [];
    end
    if nargin < 4
        col = [];
    end
    if nargin < 5
        sty = [];
    end
    
    % input file
    nc = netcdf(file, 'r');

    % data
    times = bi_read_times (nc, 'logweight', ps, ts);
    x = bi_read_ess (nc, ps, ts);

    % plot
    style = get_style (col, sty, file, 'logweight');
    plot(times, x, struct2cell (style){:});
    
    ncclose (nc);
end
