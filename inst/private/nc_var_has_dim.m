% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 1687 $
% $Date: 2011-06-28 11:46:45 +0800 (Tue, 28 Jun 2011) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{check} = } nc_var_has_dim (@var{nc}, @var{name}, @var{dim})
%
% Does NetCDF variable have a particular dimension?
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Variable name.
%
% @item @var{dim} Dimension name.
%
% @end itemize
% @end deftypefn
%
function check = nc_var_has_dim (nc, name, dim)
    % check arguments
    if nargin != 3
        print_usage ();
    end
    
    check = 0;
    dims = ncdim (nc{name});
    for i = 1:length (dims)
        if strcmp (dim, ncname (dims{i}))
            check = 1;
        end
    end
end
