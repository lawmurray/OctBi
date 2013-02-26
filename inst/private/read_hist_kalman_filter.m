% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {[@var{xs}, @var{ns}] = } read_hist_kalman_filter (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{t}, @var{bins}, @var{threshold})
%
% Read histogram from NetCDF file of Kalman filter schema.
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
% @item @var{t} (optional) Time index.
%
% @item @var{bins} (optional) Number of bins. Default 20.
%
% @item @var{threshold} (optional) Relative threshold on total mass for bin
% removal at start and end. Default 5.0e-3.
%
% @end itemize
% @end deftypefn
%
function [xs, ns] = read_hist_kalman_filter (nc, name, coord, ps, t, bins, threshold)
    % check arguments
    if nargin != 7
        print_usage ();
    end
    
    % mean and std dev
    ix = coord2serial (nc, name, coord);
    id = nc{strcat('index.', name)}(:) + ix;
    mu = bi_read_var (nc, name, coord, ps, t);
    rs = full_squeeze(nc{'S_'}(t,id,:));
    sigma = sqrt(rs'*rs);
    
    % construct histogram
    xmin = mu - 3*sigma;
    xmax = mu + 3*sigma;
    xs = xmin:(xmax - xmin)/bins:xmax;
    ns= normpdf(xs, mu, sigma);
end
