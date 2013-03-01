% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {[@var{xs}, @var{ns}] = } bi_read_hist (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{t}, @var{bins}, @var{threshold})
%
% Read histogram from NetCDF file.
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
% @item @var{t} (optional) Time index. Defaults to last time.
%
% @item @var{bins} (optional) Number of bins. Default 20.
%
% @item @var{threshold} (optional) Relative threshold on total mass for bin
% removal at start and end. Default 5.0e-3.
%
% @end itemize
% @end deftypefn
%
function [xs, ns] = bi_read_hist (nc, name, coord, ps, t, bins, threshold)
    % check arguments
    if nargin < 2 || nargin > 7
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
        t = [];
    elseif !isempty (t) && !isscalar (t)
        error ('t must be a scalar');
    end
    if nargin < 6
        bins = [];
    end
    if nargin < 7
        threshold = [];
    end
    
    if isempty (bins)
        bins = 20;
    end
    if isempty (threshold)
        threshold = 5.0e-3;
    end
    
    if isempty (t)
        t = length (nc('nr'))
    end
    
    % defer to implementation for schema
    switch nc.libbi_schema
    case {"ParticleFilter", "FlexiParticleFilter"}
        f = @read_hist_particle_filter;
    case {"KalmanFilter"}
        f = @read_hist_kalman_filter;
    otherwise
        f = @read_hist_simulator;
    end
    [xs, ns] = f (nc, name, coord, ps, t, bins, threshold);
end
