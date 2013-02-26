% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{times} = } read_times_input (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts})
%
% Read times from a NetCDF file that are associated with some variable.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Name of the variable.
%
% @item @var{coord} (optional) Dimension indices.
%
% @item @var{ts} (optional) Time indices.
% @end itemize
% @end deftypefn
%
function times = read_times_input (nc, name, coord, ts)
    tvar = get_time_var (nc, name);
    args = get_sparse_indices (nc, name, coord, [], ts);
    times = nc{tvar}(args{:});
end


