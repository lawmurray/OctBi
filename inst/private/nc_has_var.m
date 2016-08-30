% Copyright (C) 2011-2013
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
    if nargin ~= 2
        print_usage ();
    end

    check = 0;
    info = ncinfo(nc);
    vars = info.Variables;
    for i = 1:length (vars)
	var = vars(i);
        if strcmp (name, var.Name)
            check = 1;
        end
    end
end
