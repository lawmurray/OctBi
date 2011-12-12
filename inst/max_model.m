% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{mx} =} max_model (@var{model})
%
% Find global maximum of model.
%
% @itemize
% @item @var{model} Model, as output by model_*().
%
% @item @var{attempts} Number of optimisation runs to attempt.
%
% @item @var{maxiters} Maximum number of iterations in each optimisation
% run.
% @end itemize
% @end deftypefn
%
function mx = max_model (model, attempts, maxiters)
    if nargin < 1 || nargin > 3
        print_usage ();
    end
    if nargin < 2
        attempts = ceil(sqrt(rows(model.X)));
    end
    if nargin < 3
        maxiters = 500;
    end

    % optimisation options
    options = zeros (18,1);
    options(2) = 1.0e-6;
    %options(9) = 1; % check gradients
    options(14) = maxiters;
    
    % maxima
    if attempts <= rows (model.X)
        mx = model.X(randperm (rows (model.X))(1:attempts),:);
    else
        mx = model.X(randi (rows (model.X), attempts, 1),:);
    end
    for i = 1:attempts
        mx(i,:) = scg(@maxgp, mx(i,:), options, @dmaxgp, model);
        %mx(i,:) = fmins(@maxgp, mx(i,:), [], [], model);
    end

    % eliminate duplicates
    mx = unique(map(@trim, mx), 'rows');

    % eliminate any that are really just mean of Gaussian process
    vals = mingp(mx, model);
    is = find(trim(vals) != trim(model.hyp.mean));
    mx = mx(is,:);
    
    % sort
    vals = mingp(mx, model);
    [vals is] = sort(vals);
    mx = mx(flipud(is),:);

    % pick global
    %vals = mingp(mx, model);
    %[val i] = max(vals);
    %mx = mx(i,:);
end
