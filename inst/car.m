% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{ss} = } car (@var{lws})
%
% Compute the conditional acceptance rate (CAR) for given log-weights.
%
% @itemize
% @item @var{lws} Log-weights.
% @end itemize
% @end deftypefn
%
function ss = car (lws)
    % check arguments
    if nargin != 1
        print_usage ();
    end
  
    mx = max (lws, [], 1);
    ws = exp (lws - repmat(mx, rows(lws), 1));
    ws = sort(ws);
    c = cumsum(ws);
    ss = (2.0*sum(c)./c(end,:) - 1.0)/rows(lws);
end
