% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{Q} = } read_quantiles_kalman_filter (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{qs})
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
function Q = read_quantiles_kalman_filter (nc, name, coord, ps, ts, qs)
    % check arguments
    if nargin != 6
        print_usage ();
    end
    
    ix = coord2serial (nc, name, coord);
    Q = zeros (length (ts), length (qs));
    for t = 1:length (ts)
        id = nc{strcat('index.', name)}(:) + ix;
        mu = bi_read_var (nc, name, coord, ps, ts(t));
        rs = full_squeeze(nc{'S_'}(ts(t),id,:));
        sigma = sqrt(rs'*rs);
        if sigma > 0
            Q(t,:) = norminv(qs, mu, sigma);
        else
            Q(t,:) = mu;
        end
    end
end