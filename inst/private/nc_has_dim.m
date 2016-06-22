% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{check} = } nc_has_dim (@var{nc}, @var{dim})
%
% Does NetCDF file have a particular dimension?
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{dim} Dimension name.
% @end itemize
% @end deftypefn
%
function check = nc_has_dim (nc, dim)
    % check arguments
    if nargin ~= 2
        print_usage ();
    end

    check = 0;
    dims = ncinfo (nc).Dimensions;
    for i = 1:length (dims)
        if strcmp (dim, dims(i).Name)
            check = 1;
        end
    end
end
