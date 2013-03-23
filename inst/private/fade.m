% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} fade (@var{rgb}, @var{amount})
%
% Fade a colour.
%
% @itemize
% @item @var{rgb} RGB triplet.
%
% @item @var{amount} Amount to fade, between 0 and 1.
% @end itemize
%
% Returns colour faded by the given amount.
%
% @end deftypefn
%
function c = fade (rgb, amount)
    % check arguments
    if nargin < 1 || nargin > 2
        print_usage ();
    end
    if nargin < 2
        amount = 1.0;
    end
    if length(rgb) != 3
        error ('rgb must be three component RGB triplet');
    end
    
    c = amount*rgb + (1.0 - amount);
end
