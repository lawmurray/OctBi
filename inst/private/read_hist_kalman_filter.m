% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {[@var{xs}, @var{ns}] = } read_hist_kalman_filter (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{t}, @var{bins}, @var{threshold})
%
% Implementation of bi_read_hist() for Kalman filter schema.
%
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
    rs = full_squeeze(nc{'U2_'}(t,id,:));
    sigma = sqrt(rs'*rs);
    
    % construct histogram
    xmin = mu - 3*sigma;
    xmax = mu + 3*sigma;
    xs = xmin:(xmax - xmin)/bins:xmax;
    ns= normpdf(xs, mu, sigma);
end
