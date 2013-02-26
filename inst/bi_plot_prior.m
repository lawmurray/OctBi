% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3203 $
% $Date: 2012-10-10 16:50:00 +0800 (Wed, 10 Oct 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_hist (@var{in}, @var{name}, @var{coord}, @var{ps}, @var{t})
%
% Plot LibBi output. For non-temporal variables this plots a histogram. For
% temporal variables this plots a single time marginal as a histogram.
%
% @itemize
% @item @var{in} Input file. Gives the name of a NetCDF file output by LibBi.
%
% @item @var{name} Name of variable from input file to plot.
%
% @item @var{coord} (optional) Vector of spatial coordinates of zero
% to three elements, giving the x, y and z coordinates of a
% component of @var{name} to plot.
%
% @item @var{ps} (optional) Vector of indices of samples to
% plot. All samples plotted if not specified.
%
% @item @var{logn} (optional) True to histogram log of variable, false
% otherwise.
%
% @item @var{priorpdf} (optional) Name of pdf of prior distribution.
%
% @item @var{priorparams} (optional) Cell array of arguments to
% @var{priorpdf}.
%
% @end itemize
% @end deftypefn
%
function hist_mcmc (priorpdf, priorparams)
    % check arguments
    if (nargin != 2)
        print_usage ();
    end
    
    % data
    xdelta = xsize / 100; % res for prior distro plot
    x = [min(xx):xdelta:max(xx)];
    y = feval(priorpdf, x, priorparams{:});
    %peak = max(max(nn) / sum(xsize/BINS*mm), max(y));
        
    % plot
    plot(x, y, 'linewidth', 3, 'color', gray()(48,:));
end
