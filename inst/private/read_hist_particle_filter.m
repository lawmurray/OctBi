% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {[@var{xs}, @var{ns}] = } read_hist_particle_filter (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{t}, @var{bins}, @var{threshold})
%
% Read histogram from NetCDF file of particle filter schema.
%
% @itemize
% @item @var{nc} NetCDF file.
%
% @item @var{name} Name of the variable.
%
% @item @var{coord} (optional) Dimension indices.
%
% @item @var{ps} (optional) Path indices.
%
% @item @var{t} (optional) Time index.
%
% @item @var{bins} (optional) Number of bins. Default 20.
%
% @item @var{threshold} (optional) Relative threshold on total mass for bin
% removal at start and end. Default 5.0e-3.
%
% @end itemize
% @end deftypefn
%
function [xs, ns] = read_hist_particle_filter (nc, name, coord, ps, t, bins, threshold)
    % check arguments
    if nargin != 7
        print_usage ();
    end
    
    % data
    lws = bi_read_var (nc, 'logweight', [], ps, t);
    ws = exp (lws - max (lws));
    ws = ws/sum (ws);
    x = bi_read_var (nc, name, coord, ps, t);
        
    % weighted bins
    xmin = min (x);
    xmax = max (x);
    [nn,xx] = hist (x, bins);
    df = diff (xx);
    edges = [xmin, xx(1:end - 1) + df/2, xmax + 1];
    [nn,ii] = histc (x, edges);
    ww = accumarray (ii, ws', [ bins 1 ]);
    
    xs = xx;
    ns = ww;
end
