% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_plot_autocor (@var{file}, @var{name}, @var{coord}, @var{ps}, @var{lags}, @var{col}, @var{sty})
%
% Plot LibBi output. For sampling output this plots the autocorrelation across
% samples, a useful diagnostic for MCMC mixing rate.
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
% @item @var{lags} (optional) Range of lags for which to compute
% autocorrelation.
%
% @item @var{col} (optional) Colour index.
%
% @item @var{sty} (optional) Style index.
% @end itemize
% @end deftypefn
%
function bi_plot_autocor (file, name, coord, ps, lags, col, sty)
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
        lags = [];
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
    X = bi_read_paths (nc, name, coord, ps);
    if isempty (lags)
        lags = 1:length(X);
    end
    
    N = length(X);
    mu = mean(X(:));
    X = X - mu;
    A = zeros(length(lags), 1);
    for i = 1:length(lags)
        l = lags(i);
        A(i) = X(1:(end-l))'*X((l+1):end)./N;
    end
    
    % plot
    style = get_style (col, sty, file, name);
    style.linewidth = 1;
    plot (lags, A, struct2options (style){:}, 'linewidth', 3);
    
    ncclose (nc);
end
