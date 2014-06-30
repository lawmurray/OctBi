% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{times} = } read_times_simulator (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts})
%
% Implementation of bi_read_times() for simulation schema.
% @end deftypefn
%
function times = read_times_simulator (nc, name, coord, ts)
    if nc_var_has_dim (nc, 'time', 'nr')
        T = nc_dim_size (nc, 'nr');
    else
        T = 1;
    end
    if isempty (ts)
        ts = [1:T];
    end
    times = ncread (nc, 'time')(ts);
end
