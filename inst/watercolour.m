% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} watercolour (@var{i})
%
% Retrieve colour from watercolour palette.
%
% @itemize
% @item @var{i} (optional) Colour index. If not given, the whole palette is
% returned, which is useful for passing to colormap().
% @end itemize
%
% Returns the colour at the given index.
%
% @end deftypefn
%
function c = watercolour (i)
    % check arguments
    if (nargin > 1)
        print_usage ();
    end
    if (nargin == 1 && ~isscalar(i))
        error ('i must be scalar');
    end
    
    % full palette
    palette = [0.3373, 0.7059, 0.9137;
               0.8353, 0.3686, 0.0000;
               0.0000, 0.6196, 0.4510;
               0.9020, 0.6235, 0.0000;
               0.8000, 0.4745, 0.6549;
               0.9412, 0.8941, 0.2588;
               0.0000, 0.4471, 0.6980];
    
    % select from palette
    if nargin == 1
        c = palette(mod(i - 1, size(palette,1)) + 1, :);
    else
        c = palette;
    end
end
