% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {[@var{xs}, @var{ns}] = } read_hist_simulator (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{t}, @var{bins}, @var{threshold})
%
% Read histogram from NetCDF file of simulator schema.
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
function [xs, ns] = read_hist_simulator (nc, name, coord, ps, t, bins, threshold)
    % check arguments
    if nargin != 7
        print_usage ();
    end
        
    % data
    x = bi_read_var (nc, name, coord, ps, t);
    
    % bin
    [nn,xx] = hist (x, bins);
    
    % clean up outlier bins from either end
    mask = nn > threshold*length (x);
    found = find (mask, length (mask), "first");
    if length (found) > 1
        % have outliers
        first = found(1);
        last = find (mask, length (mask), "last")(end);
        if last == first
            last = last + 1;
        end
        mask(first:last) = 1; % only want to remove from start and end
        xx = xx(mask);
        nn = nn(mask);
    end
    
    % recompute reference range to restore full number of bins
    [nn,xx] = hist (x, xx(1):(xx(end) - xx(1))/(bins - 1):xx(end));
    [mm,yy] = hist (x, xx);
    % ^ first above should be with reference range
            
    % scale
    xsize = max (xx) - min (xx); % range of x values in histogram
    ysize = mean (mm); % average bar height
    
    % return
    xs = yy;
    ns = mm/(xsize*ysize);
end
