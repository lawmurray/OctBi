% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3203 $
% $Date: 2012-10-10 16:50:00 +0800 (Wed, 10 Oct 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_plot_prior (@var{x}, @var{priorpdf}, @var{priorparams})
%
% Plot a prior distribution, where @var{priorpdf} is the name of a pdf
% function and @var{priorparams} a cell array of its parameters.
%
% @itemize
% @item @var{x} Values at which to plot the prior density.
%
% @item @var{priorpdf} Name of the pdf.
%
% @item @var{priorparams} Cell array of arguments to @var{priorpdf}.
%
% @end itemize
% @end deftypefn
%
function bi_plot_prior (x, priorpdf, priorparams)
    % check arguments
    if nargin != 3
        print_usage ();
    end
    
    % data
    y = feval(priorpdf, x, priorparams{:});
        
    % plot
    plot(x, y, 'linewidth', 3, 'color', gray()(48,:));
end
