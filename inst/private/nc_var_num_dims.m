% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 1687 $
% $Date: 2011-06-28 11:46:45 +0800 (Tue, 28 Jun 2011) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{n} = } nc_var_num_dims (@var{nc}, @var{name})
%
% Number of dimensions for NetCDF variable.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Name of the variable.
% @end itemize
% @end deftypefn
%
function n = nc_var_num_dims (nc, name)
    n = length (ncdim (nc{name}));
end
