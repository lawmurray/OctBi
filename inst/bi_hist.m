% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_hist (@var{file}, @var{name}, @var{coord}, @var{ps}, @var{t}, @var{bins}, @var{threshold}, @var{col}, @var{sty})
%
% Plot LibBi output. For static variables this plots a histogram. For
% dynamic variables this plots a single time marginal as a histogram.
%
% @itemize
% @item @var{file} LibBi output file name.
%
% @item @var{name} Variable name.
%
% @item @var{coord} (optional) Dimension indices.
%
% @item @var{ps} (optional) Sample indices.
%
% @item @var{ts} (optional) Time index. Defaults to last time.
%
% @item @var{bins} (optional) Number of bins. Defaults to 20.
%
% @item @var{threshold} (optional) Relative threshold on total mass for bin
% removal at start and end. Defaults to 5.0e-3.
%
% @item @var{col} (optional) Colour index.
%
% @item @var{sty} (optional) Style index.
%
% @end itemize
% @end deftypefn
%
function bi_hist (file, name, coord, ps, t, bins, threshold, col, sty)
    % check arguments
    if (nargin < 2 || nargin > 9)
        print_usage ();
    end
    if nargin < 3
        coord = [];
    end
    if nargin < 4
        ps = [];
    end
    if nargin < 5
        t = [];
    end
    if nargin < 6
        bins = [];
    end
    if nargin < 7
        threshold = [];
    end
    if nargin < 8
        col = [];
    end
    if nargin < 9
        sty = [];
    end
    
    % read
    [xs, ns] = bi_read_hist (file, name, coord, ps, t, bins, threshold);

    % plot
    style = get_style (col, sty, file, name);
    h = bar(xs, ns, 1.0); % normalised histogram
    set(h, 'facecolor', fade(style.color, 0.3), 'edgecolor', style.color);
end
