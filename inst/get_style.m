% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3446 $
% $Date: 2013-02-06 02:44:37 +0800 (Wed, 06 Feb 2013) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{style} = } get_style (@var{col}, @var{sty}, @var{file}, @var{name})
%
% Create cell array of style information for a plot.
%
% @itemize
% @item @var{col} Colour index.
%
% @item @var{sty} Line style index.
%
% @item @var{file} (optional) NetCDF file name.
%
% @item @var{name} (optional) Variable name.
% @end itemize
%
% The final two arguments are used to create defaults in the case that either
% @var{col} or @var{sty} is empty.
% @end deftypefn
%
function style = get_style (col, sty, file, name)
    % check arguments
    if nargin < 2 || nargin > 4
        print_usage ();
    end
    if (isempty (col) || isempty(sty)) && (isempty (file) || isempty (name))
        error ('must specify at least either col and sty, or file and name');
    end
    if !isempty (file) && !ischar (file)
        error ('file must be a string');
    end
    if !isempty (name) && !ischar (name)
        error ('name must be a string');
    end
    
    % gray colour
    gr = gray()(40,:);
    
    % global defaults
    style.linewidth = 2;
    style.color = gr;
    
    % schema defaults
    if !isempty (file) && !isempty (name) && isempty (col) && isempty (sty)
        nc = netcdf (file, 'r');

        switch nc.libbi_schema
        case {'Simulator'}
            if nc_has_dim (nc, 'np') && length (nc('np')) == 1
	        % treat as simulated obs file
                style.linestyle = 'none';
                style.marker = 'o';
                style.markersize = 2;
                style.markerfacecolor = 'w';
                style.markeredgecolor = 'k';
            elseif nc{'time'}(1) > 0
                style.color = watercolour (2);
            else
                style.color = gr;
            end
        case {'FlexiSimulator'}
            if nc{'time'}(1) > 0
                style.color = watercolour (2);
            else
                style.color = gr;
            end
        case {'ParticleFilter'; 'FlexiParticleFilter'; 'KalmanFilter';
            'ParticleMCMC'; 'SMC2'}
            style.color = watercolour (1);
        case {'Optimiser'}
            style.color = watercolour (3);
        otherwise
            % probably an input file, assume obs
            style.linestyle = 'none';
            style.marker = 'o';
            style.markersize = 2;
            style.markerfacecolor = 'w';
            style.markeredgecolor = 'k';
        end
    end
    
    if !isempty (col)
        if col == 0
            style.color = gr;
        else
            style.color = watercolour (col);
        end
    end
    if !isempty (sty)
        if sty == 0
            style.linestyle = 'none';
        else
            style.linestyle = linestyle (sty);
        end
    end
end
