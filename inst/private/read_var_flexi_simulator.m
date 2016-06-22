% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 2444 $
% $Date: 2012-04-10 13:38:21 +0800 (Tue, 10 Apr 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{X} = } read_var_flexi_simulator (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts})
%
% Implementation of bi_read_var() for flexi simulation schema.
%
% @end deftypefn
%
function X = read_var_flexi_simulator (nc, name, coord, ps, ts)
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
    
    starts = nc{'start'}(:);
    lens = nc{'len'}(:);
    if !isempty (ts)
        starts = starts(ts);
        lens = lens(ts);
    end
    
    minN = min (lens);
    if isempty (ps)
        ps = [1:minN];
        if max (lens) < minN
            warn (sprintf ('The number of samples at each time differs, so reading %d, the smallest', minN));
        end
    else
        if minN < max (ps)
            warn (sprintf ('Some times have less than %d samples, so using only this many at each time', minN));
            ps = find (ps <= minN);
        end
    end
    
    % read
    X = zeros (length (ps), length (ts));
    args = {};
    for t = 1:length (ts)
        if length (coord) > 0
            args{length (args) + 1} = num2cell (coord);
        end
        if nc_var_has_dim (nc, name, 'nrp')
            args{length (args) + 1} = starts(t) + ps;
        end
        X(:,t) = full_squeeze(ncread(file, name)(args{end:-1:1}))(:);
    end
end
