% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} area_between (x, y1, y2, c, fd, alpha)
%
% Plot area between two curves.
%
% @itemize @bullet
% @item @var{x} X-coordinates.
% @item @var{y1} Y-coordinates of first curve.
% @item @var{y2} Y-coordinates of second curve.
% @item @var{c} Color.
% @item @var{fd} Opaque fade.
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
        fd = 0.5;
    end
    if nargin < 6
        alpha = 1.0;
    end
    if !isvector(x)
        error ('x must be vector');
    end
    if !isvector(y1)
        error ('y1 must be vector');
    end
    if !isvector(y2)
        error ('y2 must be vector');
    end
    
    % plot
    a = [vec(x); vec(x(end:-1:1))];
    b = [vec(y1); vec(y2(end:-1:1))];
        
    bg = fade(c, fd);
    patch(a, b, bg, 'linewidth', 1, 'edgecolor', c, 'facealpha', alpha);
end
