% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{times} = } bi_read_times (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts})
%
% Read time from a NetCDF file that is associated with some variable.
%
% @itemize
% @item @var{nc} NetCDF file name.
%
% @item @var{name} Name of the variable.
%
% @item @var{coord} (optional) Dimension indices.
%
% @item @var{ts} (optional) Time indices.
% @end itemize
% @end deftypefn
%
function times = bi_read_times (nc, name, coord, ts)
    % check arguments
    if nargin < 2 || nargin > 4
        print_usage ();
    end
    if !ischar (name)
        error ('name must be a string');
    end
    if nargin < 3
        coord = [];
    end
    if nargin < 4
        ts = [];
    end
    
    % defer to implementation for schema
    switch nc.libbi_schema
    case {'Simulator'; 'FlexiSimulator'; 'ParticleFilter';
        'FlexiParticleFilter'; 'KalmanFilter'; 'ParticleMCMC'; 'SMC2'}
        f = @read_times_simulator;
    otherwise
        f = @read_times_input;
    end
    times = f (nc, name, coord, ts);
end
