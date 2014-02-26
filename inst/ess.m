% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{ss} = } ess (@var{lws})
%
% Compute the effective sample size (ESS) for given log-weights.
%
% @itemize
% @item @var{lws} Log-weights.
% @end itemize
% @end deftypefn
%
function ss = ess (lws)
    % check arguments
    if nargin != 1
        print_usage ();
    end
  
    mx = max (lws, [], 1);
    ws = exp (lws - repmat(mx, rows(lws), 1));
    num = sum (ws).^2;
    den = sum (ws.^2);
    ss = num./den;
end
