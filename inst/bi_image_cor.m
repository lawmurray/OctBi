% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_image_cor (@var{file}, @var{names}, @var{coords}, @var{ps}, @var{t})
%
% Plot LibBi output. This plots an image of the correlation matrix between
% multiple variables.
%
% @itemize
% @item @var{file} LibBi output file name.
%
% @item @var{names} Cell array of variable names.
%
% @item @var{coords} Cell array of dimension indices.
%
% @item @var{ps} (optional) Sample indices.
%
% @item @var{t} (optional) Time index. Defaults to last time.
% @end itemize
% @end deftypefn
%
function bi_image_cor (file, names, coords, ps, t)    
    % check arguments
    if nargin < 2 || nargin > 5
        print_usage ();
    end
    if nargin < 3
        coords = {};
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
    if !(length (coords) == 0 || length(coords) == length(names))
        error ('Length of names and coords must match');
    end
    
    % input file
    nc = netcdf(file, 'r');

    % defaults
    P = length (nc('np'));
    if isempty (ps)
        ps = [1:P];
    end
    if isempty (t)
        t = length (nc('nr'));
    end

    X = zeros (length (ps), length (names));
    for i = 1:length (names)
        name = names{i};
        if length (coords) >= i
            coord = coords{i};
	else
	    coord = [];
        end
        X(:,i) = bi_read_var (nc, name, coord, ps, t);
    end
    ncclose(nc);

    % compute correlation
    C = corr(X,X);
    
    % plot
    imagesc (C);
    set(gca, 'interpreter', 'tex');
    set(gca, 'xtick', 1:length (names));
    set(gca, 'xticklabel', names);
    set(gca, 'ytick', 1:length (names));
    set(gca, 'yticklabel', names);
end
