% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3446 $
% $Date: 2013-02-06 02:44:37 +0800 (Wed, 06 Feb 2013) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{tvar} = } get_time_var (@var{nc}, @var{name})
%
% Get the time variable associated with a given variable.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Variable name.
% @end itemize
% @end deftypefn
%
function tvar = get_time_var (nc, name)
    if nargin ~= 2
        print_usage ();
    end

    [s e te m txt mn] = regexp (name, '(?<prefix>.*?)_?obs$');
    if ~isempty (s)
        prefix = mn.prefix;
    else
        prefix = '';
    end
    tvars = {
        (sprintf ('time_%s', name));
        (sprintf ('time%s', name));
        (sprintf ('time_%s', prefix));
        (sprintf ('time%s', prefix));
        (sprintf ('time'));
        };

        tvar = [];
    for i = 1:length (tvars)
        nm = tvars{i};
        if nc_has_var (nc, nm)
            tvar = nm;
            break;
        end
    end
end
