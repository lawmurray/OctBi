% Copyright (C) 2012-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 2444 $
% $Date: 2012-04-10 15:38:21 +1000 (Tue, 10 Apr 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {} invgampdf (@var{x}, @var{a}, @var{b})
%
% For each element of @var{x}, return the probability density function
% (PDF) at @var{x} of the Inverse-Gamma distribution with shape parameter
% @var{a} and scale @var{b}.
%
% @end deftypefn
%
function y = invgampdf (x, a, b)
    if nargin ~= 3
        print_usage ();
    end
    
    y = gampdf(1.0./x, a, 1.0./b)./(x.*x);
end
