% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3446 $
% $Date: 2013-02-06 02:44:37 +0800 (Wed, 06 Feb 2013) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{args} = } get_sparse_indices (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts})
%
% Convert sparse to dense indices for reading from a NetCDF variable.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Variable name.
%
% @item @var{coord} (optional) Dimension indices.
%
% @item @var{ps} (optional) Sample indices.
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
        P = nc_dim_size (nc, 'np');
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
            ndims = nc_var_num_dims (nc, name);
            if ndims == 1
                coords = ncread (nc, cvar);
            elseif ndims == 2
                coords = ncread (nc, cvar);
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
                T = nc_dim_size (nc, tdim);
                args{length (args) + 1} = [1:T];
            else
                args{length (args) + 1} = ts;
            end
        end
        for i = 1:length (coord)
            args{length (args) + 1} = coord(i);
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
    
    if nc_var_has_dim (nc, name, 'np')
        args{length (args) + 1} = ps;
    end
end
