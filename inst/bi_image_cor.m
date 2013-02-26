% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {} image_cor (@var{in}, @var{names}, @var{coords}, @var{ps}, @var{logs})
%
% Plot correlation matrix of samples output by mcmc program.
%
% @itemize
% @item @var{in} Input file. Gives the name of a NetCDF file output by
% mcmc.
%
% @item @var{names} Cell array giving names of variables to plot.
%
% @item @var{coords} Cell array giving coordinates of variables to plot,
% each element matching an element of @var{names}.
%
% @item @var{ps} (optional) Vector of indices of samples to
% include. Useful for excluding burn-in periods, for instance.
%
% @item @var{logns} (optional) Vector of true/false values indicating
% log-variables.
% @end itemize
% @end deftypefn
%
function image_cor_mcmc (in, names, coords, ps, logns)    
    % check arguments
    if nargin < 2 || nargin > 5
        print_usage ();
    end
    if nargin < 3
        coords = {};
    end
    if nargin < 4
        ps = [];
    end
    if nargin < 5
        logns = zeros (length(names), 1);
    end
    if !(length (coords) == 0 || length(coords) == length(names))
        error ('Length of names and coords must match');
    end
    
    % input file
    nci = netcdf(in, 'r');

    % data
    P = length (nci('np'));
    if length (ps) == 0
        ps = [1:P];
    end

    X = [];
    names = {};
    for i = 1:length(names)
        name = names{i};
        
        if length (coords) > 0
            coords1 = coords{i};
            if rows (coords1) == 0
                coords1 = zeros(1, 0);
            end
        else
            coords1 = zeros(1, 0);
        end
        
        for j = 1:max(1, rows(coords1))
            coord = coords1(j,:);
            if !check_coord (coord)
                error ('Invalid coordinate');
            else
                x = read_var(nci, name, coord, ps, 1);
                if logns (i)
                    x = log(x);
                end
                X = [ X, x(:) ];
            end
            name = nice_name (name, coord);
            names = { names{:}, name };
        end
    end
    ncclose(nci);        
        
    % compute correlation
    Cor = cor(X,X);
    
    % plot
    imagesc(Cor);
    set(gca, 'interpreter', 'tex');
    set(gca, 'xtick', 1:length(names));
    set(gca, 'xticklabel', names);
    set(gca, 'ytick', 1:length(names));
    set(gca, 'yticklabel', names);
end