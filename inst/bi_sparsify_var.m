% Copyright (C) 2011-2013-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} bi_sparsify_var (@var{infile}, @var{outfile}, @var{name}, @var{coords}, @var{ps}, @var{ts})
%
% Read variable from dense NetCDF file and output to sparse NetCDF file.
%
% @itemize
% @item @var{infile} Input NetCDF file name.
%
% @item @var{outfile} Output NetCDF file name.
%
% @item @var{name} Name of the variable.
%
% @item @var{coord} (optional) Dimension indices.
%
% @item @var{ps} (optional) Path indices.
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
    nci = netcdf (infile, 'r');
    
    P = nci('np')(:);
    if isempty (ps)
        ps = [1:P];
    end
    
    T = nci('nr')(:);
    if isempty (ts)
        ts = [1:T];
    end
    
    if isempty (coords)
        ncoords = 1;
    else
        ncoords = rows (coords);
    end
    
    % output file
    if exist (outfile, "file")
        nco = netcdf (outfile, 'w');
    else
        nco = netcdf (outfile, 'c', '64bit-offset');
    end

    % dimensions
    rdim = sprintf ('nr_%s', name);
    cdim = sprintf ('nc_%s', name);
    
    nco(rdim) = ncoords*length (ts);
    if columns (coords) > 1
        nco(cdim) = columns (coords);
    end
    if !nc_has_dim (nco, 'np') && length (ps) > 1
        nco('np') = length (ps);
    end
    
    % time variable
    tvar = sprintf ('time_%s', name);
    nco{tvar} = ncdouble (rdim);
    nco{tvar}(:) = repmat (nci{'time'}(ts)', ncoords, 1)(:);
    
    % coordinate variable
    % (note -1 to convert base one indices for Octave to base zero for LibBi)
    cvar = sprintf ('coord_%s', name);
    if columns (coords) > 1
        nco{cvar} = ncdouble (rdim, cdim);
        nco{cvar}(:,:) = repmat (coords - 1, length (ts), 1);
    elseif columns (coords) > 0
        nco{cvar} = ncdouble(rdim);
        nco{cvar}(:) = repmat (coords(:) - 1, length (ts), 1);
    end
    
    % construct data
    if length (ps) > 1
        nco{name} = ncdouble (rdim, 'np');
    else
        nco{name} = ncdouble (rdim);
    end
    for t = 1:length (ts)
        for j = 1:ncoords
            if columns (coords) > 0
                coord = coords(j,:);
                x = bi_read_var (nci, name, coord, ps, ts(t));
            else
                x = bi_read_var (nci, name, [], ps, ts(t));
            end
            if length (ps) > 1
                nco{name}((t - 1)*ncoords + j,:) = x;
            else
                nco{name}((t - 1)*ncoords + j) = x;
            end
        end
    end
    
    ncclose (nci);
    ncclose (nco);
end
