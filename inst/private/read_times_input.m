% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{times} = } read_times_input (@var{nc}, @var{name}, @var{coord}, @var{ts})
%
% Implementation of bi_read_times() for input schema.
%
% @end deftypefn
%
function times = read_times_input (nc, name, coord, ts)
    if nargin != 4
        print_usage ();
    end

    tvar = get_time_var (nc, name);
    args = get_sparse_indices (nc, name, coord, [], ts);
    times = nc{tvar}(args{:});
end
