% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{X} = } read_var_input (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts})
%
% Read observation from NetCDF file.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Name of the variable.
%
% @item @var{coord} (optional) Dimensions index.
%
% @item @var{ps} (optional) Path indices.
%
% @item @var{ts} (optional) Time indices.
% @end itemize
% @end deftypefn
%
function X = read_var_input (nc, name, coord, ps, ts)
    args = get_sparse_indices (nc, name, coord, ps, ts);
    if nc_var_has_dim (nc, name, 'ns')
        args = {1; args{:}};
    end
    X = full_squeeze (nc{name}(args{:}));
end
