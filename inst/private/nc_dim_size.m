% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 1687 $
% $Date: 2011-06-28 11:46:45 +0800 (Tue, 28 Jun 2011) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{sz} = } nc_var_size (@var{nc}, @var{name})
%
% Get dimension sizes for a NetCDF variable.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Variable name.
% @end itemize
% @end deftypefn
%
function sz = nc_dim_size (nc, name)
    if nargin ~= 2
        print_usage ();
    end

    dims = ncinfo (nc).Dimensions;
    for i = 1:length (dims)
        if strcmp (name, dims(i).Name)
            sz = dims(i).Length;
        end
    end
end
