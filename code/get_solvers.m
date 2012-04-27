%GET_SOLVERS: 
%
%   This function just extracts the solver strings from the options
%   structure.

% Copyright:   227A project group
% Last edited:   Apr 20, 2012


function solvers = get_solvers(options)

    solvers = {};

    if options.intpt.active
        solvers = {solvers{:},'intpt'};
    end            
    if options.itth.active
        solvers = {solvers{:},'itth'};
    end
    if options.apg.active
        solvers = {solvers{:},'apg'};
    end
    if options.papg.active
        solvers = {solvers{:},'papg'};
    end
    if options.dpga.active
        solvers = {solvers{:},'dpga'};
    end
    if options.ealm.active
        solvers = {solvers{:},'ealm'};
    end
    if options.ialm.active
        solvers = {solvers{:},'ialm'};
    end
    if options.BLWSialm.active
        solvers = {solvers{:},'BLWSialm'};
    end

end