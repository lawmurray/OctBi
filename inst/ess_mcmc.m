% Copyright (C) 2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{ss} = } ess_mcmc (@var{x}, @var{lags})
%
% Compute the effective sample size (ESS) of a Markov chain using given
% lags for the autocorrelation function.
% @end deftypefn
%
function ess = ess_mcmc (x, lags)
    N = length(x);
    mu = mean(x(:));
    sigma2 = var(x(:));
    y = x - mu;
    a = zeros(length(lags), 1);
    for i = 1:length(lags)
        l = lags(i);
        a(i) = (y(1:(end-l))'*y((l+1):end)./N)./sigma2;
    end
    ess = N/(1 + 2*sum(a(2:end)));
end
