% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{Q} = } read_quantiles_simulator (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{q})
%
% Implementation of bi_read_quantiles() for simulation schema.
%
% @end deftypefn
%
function Q = read_quantiles_simulator (nc, name, coord, ps, ts, qs)
    % check arguments
    if nargin != 6
        print_usage ();
    end
    
    Q = zeros (length (ts), length (qs));
    for t = 1:length (ts)
        x = read_var_simulator (nc, name, coord, ps, ts(t));
        Q(t,:) = quantile (x, qs);
    end
end
