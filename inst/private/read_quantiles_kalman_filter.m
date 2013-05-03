% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{Q} = } read_quantiles_kalman_filter (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{qs})
%
% Implementation of bi_read_quantiles() for Kalman filter schema.
%
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
        rs = full_squeeze(nc{'U2_'}(ts(t),id,:));
        sigma = sqrt(rs'*rs);
        if sigma > 0
            Q(t,:) = norminv(qs, mu, sigma);
        else
            Q(t,:) = mu;
        end
    end
end
