% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} bi_sparsify_var (@var{infile}, @var{outfile}, @var{name}, @var{coords}, @var{ps}, @var{ts})
%
% Read a variable from a dense LibBi file and output to a sparse LibBi file.
%
% @itemize
% @item @var{infile} Input file name.
%
% @item @var{outfile} Output file name.
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
function X = bi_sparsify_var (infile, outfile, name, coords, ps, ts)
    % check arguments
    if nargin < 2 || nargin > 6
        print_usage ();
    end
    if nargin < 4
        coords = [];
    elseif !isempty (coords) && !ismatrix (coords)
        error ('coords must be a matrix');
    end
    if nargin < 5
        ps = [];
    end
    if nargin < 6
        ts = [];
    end
    
    % input file
    P = nc_dim_size(infile, 'np');
    if isempty (ps)
        ps = [1:P];
    end
    
    T = nc_dim_size(infile, 'nr');
    if isempty (ts)
        ts = [1:T];
    end
    
    if isempty (coords)
        ncoords = 1;
    else
        ncoords = rows (coords);
    end
    
    % dimensions
    rdim = sprintf ('nr_%s', name);
    cdim = sprintf ('nc_%s', name);
    rdim_size = ncoords*length (ts);
    cdim_size = 0;
    if columns (coords) > 1
        cdim_size = columns (coords);
    end
    npdim_size = 0;
    if length (ps) > 1
        npdim_size = length (ps);
    end
    
    % time variable
    tvar = sprintf ('time_%s', name);
    nccreate (outfile, tvar, 'Dimensions', { rdim, rdim_size });
    ncwrite (outfile, tvar, repmat (ncread(infile, 'time')(ts)', ncoords, 1)(:));
    
    % coordinate variable
    % (note -1 to convert base one indices for Octave to base zero for LibBi)
    cvar = sprintf ('coord_%s', name);
    if columns (coords) > 1
        nccreate (outfile, cvar, 'Dimensions', { rdim, cdim });
        ncwrite (outfile, cvar, repmat (coords - 1, length (ts), 1));
    elseif columns (coords) > 0
        nccreate (outfile, cvar, 'Dimensions', { rdim });
        ncwrite (outfile, cvar, repmat (coords(:) - 1, length (ts), 1));
    end
    
    % construct data
    if length (ps) > 1
        nccreate (outfile, name, 'Dimensions', { rdim, 'np' });
    else
        nccreate (outfile, name, 'Dimensions', { rdim });
    end
    for t = 1:length (ts)
        for j = 1:ncoords
            if columns (coords) > 0
                coord = coords(j,:);
                x = bi_read_var (infile, name, coord, ps, ts(t));
            else
                x = bi_read_var (infile, name, [], ps, ts(t));
            end
            if length (ps) > 1
                ncwrite (outfile, name, x, [(t - 1)*ncoords + j, 1]);
            else
                ncwrite (outfile, name, x, (t - 1)*ncoords + j);
            end
        end
    end
end
