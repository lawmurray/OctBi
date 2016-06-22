% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_image_density (@var{file}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{res})
%
% Plot LibBi output. For dynamic variables this plots sample paths as a
% density image.
%
% @itemize
% @item @var{file} LibBi output file name.
%
% @item @var{name} Variable name.
%
% @item @var{coord} (optional) Dimension indices.
%
% @item @var{ps} (optional) Sample indices.
%
% @item @var{ts} (optional) Time indices.
%
% @item @var{res} (optional) Resolution of image on y-axis.
% @end itemize
% @end deftypefn
%
function bi_image_density (file, name, coord, ps, ts, res)
    % check arguments
    if nargin < 2 || nargin > 6
        print_usage ();
    end
    if ~ischar (file)
        error ('file must be a string');
    end
    if ~ischar (name)
        error ('name must be a string');
    end
    if nargin < 3
        coord = [];
    elseif ~isempty (coord) && ~isvector (coord)
        error ('coord must be a vector');
    end
    if nargin < 4
        ps = [];
    elseif ~isempty (ps) && ~isvector (ps)
        error ('ps must be a vector');
    end
    if nargin < 5
        ts = [];
    elseif ~isempty (ts) && ~isvector (ts)
        error ('ts must be a vector');
    end
    if nargin < 6
        res = [];
    end

    % data
    times = bi_read_times (file, name, coord, ts);
    X = bi_read_paths (file, name, coord, ps, ts);
    if isempty(res)
        res = floor(sqrt(size(X,2)));
    end
    
    % data extents
    xmin = min(X(:));
    xmax = max(X(:));
    xs = linspace(xmin, xmax, res + 1);
    
    % plot
    nn = histc(X, xs, 2)';
    NN = max(nn, [], 1);
    nn = nn./repmat(NN, size(nn,1), 1);
    imagesc(times(:), xs(:), nn);
    set(gca(), 'ydir', 'normal');
end
