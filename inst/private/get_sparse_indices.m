% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3446 $
% $Date: 2013-02-06 02:44:37 +0800 (Wed, 06 Feb 2013) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{args} = } get_sparse_indices (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts})
%
% Convert sparse to dense indices for reading variable.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Name of the variable.
%
% @item @var{coord} (optional) Dimensions index.
%
% @item @var{ps} (optional) Path indices.
%
% @item @var{ts} (optional) Time indices.
% @end itemize
% @end deftypefn
%
function args = get_sparse_indices (nc, name, coord, ps, ts)
    % check arguments
    if nargin < 2 || nargin > 5
        print_usage ();
    end
    if !ischar (name)
        error ('name must be a string');
    end
    if nargin < 3
        coord = [];
    elseif !isempty (coord) && !isvector (coord)
        error ('coord must be a vector');
    end
    if nargin < 4
        ps = [];
    elseif !isempty (ps) && !isvector (ps)
        error ('ps must be a vector');
    end
    if nargin < 5
        ts = [];
    elseif !isempty (ts) && !isvector (ts)
        error ('t must be a vector');
    end
    
    % check dimensions
    if nc_var_has_dim (nc, name, 'np')
        P = length (nc('np'));
    else
        P = 1;
    end    
    if isempty (ps)
        ps = [1:P];
    end

    tdim = get_time_dim (nc, name);
    tvar = get_time_var (nc, name);
    cvar = get_coord_var (nc, name);
    dense = isempty (cvar);
    has_tdim = !isempty (tdim);
    
    if !dense
        if length (coord) > 0
            ndims = length (ncdim (nc{name}));
            if ndims == 1
                coords = nc{cvar}(:);
            elseif ndims == 2
                coords = nc{cvar}(:,:);
            else
                error (sprintf ('Variable %s has too many dimensions', cvar));
            end
            coords = coords + 1; % offset from base 0 to base 1 indexing
        else
            coords = [];
        end
    end

    args = {};
    if dense
        if has_tdim
            if isempty (ts)
                T = length (nc(tdim));
                args{length (args) + 1} = [1:T];
            else
                args{length (args) + 1} = ts;
            end
        end
        if length (coord) > 0
            from = length (args) + 1;
            to = from + length (coord) - 1;
            args{from:to} = num2cell (coord){:};
        end
    else
        if length (coord) > 0
            mask = zeros (rows (coords),1);
            for k = 1:rows (coords)
                if coords(k,:) == coord
                    mask(k) = 1;
                end
            end
            if isempty (ts)
                args{length (args) + 1} = find (mask);
            else
                args{length (args) + 1} = find (mask)(ts);
            end
        end
    end
end
