% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{check} = } nc_has_var (@var{nc}, @var{name})
%
% Does NetCDF file have a particular variable?
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Variable name.
% @end itemize
% @end deftypefn
%
function check = nc_has_var (nc, name)
    % check arguments
    if nargin != 2
        print_usage ();
    end

    check = 0;
    vars = ncvar (nc);
    for i = 1:length (vars)
        if strcmp (name, ncname (vars{i}))
            check = 1;
        end
    end
end
