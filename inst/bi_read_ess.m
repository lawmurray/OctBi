% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3446 $
% $Date: 2013-02-06 02:44:37 +0800 (Wed, 06 Feb 2013) $

% -*- texinfo -*-
% @deftypefn {Function File} {y = } bi_read_ess (@var{nc}, @var{ps}, @var{ts})
%
% Read effective sample size (ESS) at each time from the output of a particle
% filter.
%
% @itemize
% @item @var{file} NetCDF file name.
%
% @item @var{ps} (optional) Path indices.
%
% @item @var{ts} (optional) Time indices.
% @end itemize
% @end deftypefn
%
function y = bi_read_ess (nc, ps, ts)
    % check arguments
    if nargin < 2 || nargin > 3
        print_usage ();
    end
    if nargin < 2
        ps = [];
    end
    if nargin < 3
        ts = [];
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
    
    for t = 1:length (ts)
        lws = bi_read_var (nc, 'logweight', [], ps, ts(t));
        x{t} = ess (lws);
    end
    y = cell2mat (x);
end
