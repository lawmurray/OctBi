% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{Q} = } read_quantiles_particle_filter (@var{nc}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{qs})
%
% Implementation of bi_read_quantiles() for particle filter schema.
%
% @end deftypefn
%
function Q = read_quantiles_particle_filter (nc, name, coord, ps, ts, qs)
    % check arguments
    if nargin ~= 6
        print_usage ();
    end

    Q = zeros (length (ts), length (qs));
    for t = 1:length (ts)
        x = bi_read_var (nc, name, coord, ps, ts(t));
        [x is] = sort (x);
        lw = bi_read_var (nc, 'logweight', [], ps, ts(t));
        lw = lw(is);
        w = exp (lw - max (lw));

        % consolidate repeated values
        y = [];
        v = [];
        j = 1;
        y(j) = x(j);
        v(j) = w(j);
        for i = 2:length(x)
          if x(i) == y(j)
            v(j) = v(j) + w(i);
          else
            j = j + 1;
            y(j) = x(i);
            v(j) = w(i);
          end
        end
        V = cumsum (v);
        V = V/V(end); % normalise

        for q = 1:length (qs)
            k = find (V > qs(q), 1);
            if k == 1
              Q(t,q) = y(k);
            else
              % linear interpolation
              a = (qs(q) - V(k-1))/(V(k) - V(k-1));
              Q(t,q) = a*y(k-1) + (1.0 - a)*y(k);
            end
        end
    end
end
