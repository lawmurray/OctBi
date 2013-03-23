% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {[@var{xs}, @var{ns}] = } read_hist_particle_filter (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{t}, @var{bins}, @var{threshold})
%
% Implementation of bi_read_hist() for particle filter schema.
%
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
