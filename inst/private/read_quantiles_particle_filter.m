% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{Q} = } read_quantiles_particle_filter (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{qs})
%
% Read quantiles from NetCDF file of particle filter schema.
%
% @itemize
% @item @var{nc} NetCDF file.
%
% @item @var{name} Name of the variable.
%
% @item @var{coord} Dimension indices.
%
% @item @var{ps} Path indices.
%
% @item @var{ts} Time indices.
%
% @item @var{qs} Quantiles.
% @end itemize
% @end deftypefn
%
function Q = read_quantiles_particle_filter (nc, name, coord, ps, ts, qs)
    % check arguments
    if nargin != 6
        print_usage ();
    end
    
    Q = zeros (length (ts), length (qs));
    for t = 1:length (ts)
        x = bi_read_var (nc, name, coord, ps, ts(t));
        [x is] = sort (x);
        lw = bi_read_var (nc, 'logweight', [], ps, ts(t));
        lw = lw(is);
        w = exp (lw - max (lw));
        W = cumsum (w);
        W = W/W(end); % normalise
        
        for q = 1:length (qs)
            is = find (W <= qs(q));
            if length (is) > 0
                k = is(end);
            else
                k = 1;
            end
            Q(t,q) = x(k);
        end
    end
end
