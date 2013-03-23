% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3253 $
% $Date: 2012-10-23 12:36:13 +0800 (Tue, 23 Oct 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{s} =} linestyles (@var{i})
%
% Retrieve line style.
%
% @itemize
% @item @var{i} (optional) Style index.
% @end itemize
%
% Returns the line style of the given index. If @var{i} is not given, all
% styles are returned as a cell array of strings.
%
% @end deftypefn
%
function s = linestyle (i)
    % check arguments
    if nargin > 1
        print_usage ();
    end
    if nargin == 1 && !isscalar(i)
        error ('i must be scalar');
    end
    
    % all styles
    styles = { '-'; '--'; ':'; '-.' };

    % select from palette
    if nargin == 1
        s = styles{mod(i - 1, length(styles)) + 1};
    else
        s = styles;
    end
end
