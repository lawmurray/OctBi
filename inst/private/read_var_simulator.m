% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{X} = } read_var_simulator (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts})
%
% Implementation of bi_read_var() for simulation schema.
%
% @end deftypefn
%
function X = read_var_simulator (nc, name, coord, ps, ts)
    % check arguments
    if nargin < 2 || nargin > 5
        print_usage ();
    end
    if !ischar (name)
        error ('name must be a string');
    end
    if nargin < 3
        coord = [];
    elseif !isempty (coord) && !isvector (coord)
        error ('coord must be a vector');
    end
    if nargin < 4
        ps = [];
    elseif !isempty (ps) && !isvector (ps)
        error ('ps must be a vector');
    end
    if nargin < 5
        ts = [];
    elseif !isempty (ts) && !isvector (ts)
        error ('ts must be a scalar');
    end
    
    % check dimensions
    if nc_var_has_dim (nc, name, 'np')
        P = length (nc('np'));
    else
        P = 1;
    end    
    if isempty (ps)
        ps = [1:P];
    end
    
    if nc_var_has_dim (nc, name, 'nr')
        T = length (nc('nr'));
    else
        T = 1;
    end
    if isempty (ts)
        ts = [1:T];
    end
    
    % read
    args = {};
    if nc_var_has_dim (nc, name, 'nr')
        args{length (args) + 1} = ts;
    end
    if length (coord) > 0
        from = length (args) + 1;
        to = from + length (coord) - 1;
        args{from:to} = num2cell (coord){:};
    end
    if nc_var_has_dim (nc, name, 'np')
        args{length (args) + 1} = ps;
    end
    X = full_squeeze(nc{name}(args{:}));
end
