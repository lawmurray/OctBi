% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{ix} = } coord2serial (@var{nc}, @var{name}, @var{coord})
%
% Convert coordinate to serial index.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Name of the variable.
%
% @item @var{coord} Coordinate.
% @end itemize
% @end deftypefn
%
function ix = coord2serial (nc, name, coord)
    lens = nc_var_size (nc, name);
    len = 1;
    ix = 1;
    for i = 1:length (coord)
        ix = ix + (coord(i) - 1)*len;
        len = len*lens(i + 1);
    end
end
