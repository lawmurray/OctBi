% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{X} = } full_squeeze (@var{X})
%
% Like squeeze(), but also converts row vectors to column vectors.
%
% @end itemize
% @end deftypefn
%
function X = full_squeeze (X)
  if nargin != 1
    print_usage ();
  end
  X = squeeze (X);
  if isrow (X)
      X = X(:);
  end
end
