% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{Q} = } bi_read_quantiles (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{qs})
%
% Read quantiles from NetCDF file.
%
% @itemize
% @item @var{nc} NetCDF file.
%
% @item @var{name} Name of the variable.
%
% @item @var{coord} (optional) Dimension indices.
%
% @item @var{ps} (optional) Path indices.
%
% @item @var{ts} (optional) Time indices.
%
% @item @var{qs} (optional) Quantiles.
% @end itemize
% @end deftypefn
%
function Q = bi_read_quantiles (nc, name, coord, ps, ts, qs)
    % check arguments
    if nargin < 2 || nargin > 6
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
        error ('ts must be a vector');
    end
    if nargin < 6
        qs = [];
    elseif !isempty (qs) && !isvector (qs)
        error ('qs must be a vector');
    end
    
    % default sizes
    if nc_has_dim (nc, 'nr')
        T = length (nc('nr'));
    else
        T = 1;
    end
    if isempty (ts)
        ts = [1:T];
    end
    
    if isempty (qs)
        qs = [0.025 0.5 0.975]';
    end
    
    % defer to implementation for schema
    switch nc.libbi_schema
    case {"ParticleFilter", "FlexiParticleFilter"}
        f = @read_quantiles_particle_filter;
    case {"KalmanFilter"}
        f = @read_quantiles_kalman_filter;
    otherwise
        f = @read_quantiles_simulator;
    end
    Q = f (nc, name, coord, ps, ts, qs);
end
