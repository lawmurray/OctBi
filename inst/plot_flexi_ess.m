% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 2272 $
% $Date: 2011-12-12 16:53:13 +0800 (Mon, 12 Dec 2011) $

% -*- texinfo -*-
% @deftypefn {Function File} {} plot_flexi_ess (@var{in})
%
% Compute and plot effective sample size (ESS) at each time from the flexi
% output of the pf program.
%
% @itemize
% @item @var{in} Input file. Gives the name of a NetCDF file output by
% pf.
% @end itemize
% @end deftypefn
%
function plot_flexi_ess (in)
    % check arguments
    if nargin != 1
        print_usage ();
    end
    
    % input file
    nci = netcdf(in, 'r');

    % read data and compute
    T = nci('nr')(:);
    esses = zeros(T,1);
    
    for t = 1:T
        start = nci{'start'}(t);
        len = nci{'len'}(t);
        lws = nci{'logweight'}((start + 1):(start + len))';
        esses(t) = ess(lws);
    end
    
    % plot
    plot(esses, 'linewidth', 3, 'color', watercolour(2));
end
