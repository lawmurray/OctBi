% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3446 $
% $Date: 2013-02-06 02:44:37 +0800 (Wed, 06 Feb 2013) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{tvar} = } get_time_dim (@var{nc}, @var{name})
%
% Get the time dimension associated with a given variable.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Variable name.
% @end itemize
% @end deftypefn
%
function tdim = get_time_dim (nc, name)
    if nargin ~= 2
        print_usage ();
    end

    [s e te m txt mn] = regexp (name, '(?<prefix>.*?)_?obs$');
    if ~isempty (mn.prefix)
        prefix = mn.prefix;
    else
        prefix = '';
    end
    tdims = {
        (sprintf ('nr_%s', name));
        (sprintf ('nr%s', name));
        (sprintf ('n%s', name));
        (sprintf ('nr_%s', prefix));
        (sprintf ('nr%s', prefix));
        (sprintf ('n%s', prefix));
        ('nr');
    };
    for i = 1:length (tdims)
        tdim = tdims{i};
        if nc_has_dim (nc, tdim)
            break;
        end
    end
end
