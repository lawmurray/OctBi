% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{X} = } read_var_input (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts})
%
% Implementation of bi_read_var() for input schema.
% @end deftypefn
%
function X = read_var_input (nc, name, coord, ps, ts)
    args = get_sparse_indices (nc, name, coord, ps, ts);
    if nc_var_has_dim (nc, name, 'ns')
        args = {1; args{:}};
    end
    X = ncread(nc, name);
    X = full_squeeze(X(args{end:-1:1}));
end
