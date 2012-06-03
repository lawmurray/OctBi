% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 2444 $
% $Date: 2012-04-10 13:38:21 +0800 (Tue, 10 Apr 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{X} = } read_flexi_var (@var{nc}, @var{name}, @var{coord}, @var{t})
%
% Read variable from NetCDF file in flexi format.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Name of the variable.
%
% @item @var{coord} (optional) Spatial coordinates. Zero to three
% element vector containing spatial coordinates for the desired component
% of this variable.
%
% @item @var{t} Time index.
% @end itemize
% @end deftypefn
%
function X = read_flexi_var (nc, name, coord, t)
    % check arguments
    if nargin != 4
        print_usage ();
    end    
    if length (coord) > 3
        error ('coord must be vector of length zero to three');
    end
        
    % read
    numdims = ncnumdims (nc, name);
    if numdims == 0
        X = nc{name}(:);
    else
        start = nc{'start'}(t);
        len = nc{'len'}(t);
        ps = [(start + 1):(start + len)];
        
        if numdims == 1
            X = nc{name}(ps);
        else
            if length(coord) == 0
                X = nc{name}(ps);
            elseif length(coord) == 1
                X = nc{name}(coord(1),ps);
            elseif length(coord) == 2
                X = nc{name}(coord(1),coord(2),ps);
            elseif length(coord) == 3
                X = nc{name}(ts,coord(1),coord(2),coord(3),ps);
            end
        end
    end
    
    X = squeeze(X);
end
