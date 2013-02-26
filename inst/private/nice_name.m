% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{nice} = } nice_name (@var{name}, @var{coord})
%
% Construct human-readable name for variable.
%
% @itemize
% @item @var{name} Name of the variable.
%
% @item @var{coord} zero to three element vector containing dimension
% indices for the desired component of this variable.
% @end itemize
% @end deftypefn
%
function nice = nice_name (name, coord)
    % check arguments
    if nargin < 1 || nargin > 2
        print_usage ();
    elseif nargin == 1
        coord = [];
    elseif nargin == 2 && length(coord) > 3
        error ('coord must be vector of length zero to three');
    end
    
    % handle subscripting
    new_name = '';
    num_subscripts = 0;
    for i = 1:length(name)
        if (name(i) == '_')
            new_name = strcat(new_name, '_{');
            num_subscripts = num_subscripts + 1;
        else
            new_name = strcat(new_name, name(i));
        end
    end
    for i = 1:num_subscripts
        new_name = strcat(new_name, '}');
    end

    % handle greek letters
    nice = strcat('{', nice_greek (new_name));
  
    % handle coordinates
    if length(coord) > 0
        nice = strcat(nice, '(');
    end
    for i = 1:length(coord)
        nice = strcat(nice, num2str(coord(i)));
        if i != length(coord)
            nice = strcat(nice, ',');
        end
    end
    if length(coord) > 0
        nice = strcat(nice, ')');
    end
    nice = strcat(nice, '}');
end

