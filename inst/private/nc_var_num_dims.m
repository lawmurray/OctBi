% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 1687 $
% $Date: 2011-06-28 11:46:45 +0800 (Tue, 28 Jun 2011) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{n} = } nc_var_num_dims (@var{nc}, @var{name})
%
% Get the number of dimensions for a NetCDF variable.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Variable name.
% @end itemize
% @end deftypefn
%
function n = nc_var_num_dims (nc, name)
    if nargin ~= 2
        print_usage ();
    end

    info = ncinfo(nc, name);
    n = length(info.Dimensions);
end
