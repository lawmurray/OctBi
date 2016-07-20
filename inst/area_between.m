% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} area_between (@var{x}, @var{y1}, @var{y2}, @var{c}, @var{fd}, @var{alpha})
%
% Plot the area between two curves.
%
% @itemize @bullet
% @item @var{x} X-coordinates.
%
% @item @var{y1} Y-coordinates of first curve.
%
% @item @var{y2} Y-coordinates of second curve.
%
% @item @var{c} Color.
%
% @item @var{fd} Opaque fade.
%
% @item @var{alpha} Alpha.
% @end itemize
% @end deftypefn
%
function area_between (x, y1, y2, c, fd, alpha)
    % check arguments
    if (nargin < 4 || nargin > 6)
        print_usage ();
    end
    if nargin < 5
        fd = 1.0;
    end
    if nargin < 6
        alpha = 0.5;
    end
    if ~isvector(x)
        error ('x must be vector');
    end
    if ~isvector(y1)
        error ('y1 must be vector');
    end
    if ~isvector(y2)
        error ('y2 must be vector');
    end
    
    % plot
    a = [flipud(x(:)); x(:); x(end)];
    b = [flipud(y1(:)); y2(:); y1(end) ];
    % ^ flipud orders points clockwise so that correct faces are shaded
        
    bg = fade(c, fd)';
    patch(a, b, bg, 'linewidth', 0.5, 'edgecolor', c, 'edgealpha', 0, ...
        'facealpha', alpha);
end
