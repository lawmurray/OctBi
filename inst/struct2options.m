% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3446 $
% $Date: 2013-02-06 02:44:37 +0800 (Wed, 06 Feb 2013) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{options} = } struct2options (@var{s})
%
% Convert structure to list of options in key-value order.
%
% @itemize
% @item @var{s} Struct.
% @end itemize
% @end deftypefn
%
function options = struct2options (s)
    if nargin != 1
        print_usage ();
    end

    keys = fieldnames (s);
    values = struct2cell (s);
    options = { keys{:}; values{:} };
end
