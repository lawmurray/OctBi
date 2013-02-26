% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{Q} = } read_quantiles_simulator (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{q})
%
% Read quantiles from NetCDF file of simulator schema.
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
% @item @var{q} Quantiles.
% @end itemize
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
