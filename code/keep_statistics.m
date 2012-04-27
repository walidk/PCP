%KEEP_STATISTICS: 
%
%   This function keeps track of statistics, it is there mainly to keep 
%   the bench_synthetic script clean

% Copyright:   227A project group
% Last edited:   Apr 20, 2012


function resultarray = keep_statistics(resultarray,result,j,options)

    if j==1
        if options.intpt.active
            resultarray.intpt.trun_avg = result.intpt.t_run;
            resultarray.intpt.numIter_avg = result.intpt.numIter;
            resultarray.intpt.errL_avg = result.intpt.errL;
            resultarray.intpt.errS_avg = result.intpt.errS;
        end            
        if options.itth.active
            resultarray.itth.trun_avg = result.itth.t_run;
            resultarray.itth.numIter_avg = result.itth.numIter;
            resultarray.itth.errL_avg = result.itth.errL;
            resultarray.itth.errS_avg = result.itth.errS;
        end
        if options.apg.active
            resultarray.apg.trun_avg = result.apg.t_run;
            resultarray.apg.numIter_avg = result.apg.numIter;
            resultarray.apg.errL_avg = result.apg.errL;
            resultarray.apg.errS_avg = result.apg.errS;
        end
        if options.papg.active
            resultarray.papg.trun_avg = result.papg.t_run;
            resultarray.papg.numIter_avg = result.papg.numIter;
            resultarray.papg.errL_avg = result.papg.errL;
            resultarray.papg.errS_avg = result.papg.errS;
        end
        if options.dpga.active
            resultarray.dpga.trun_avg = result.dpga.t_run;
            resultarray.dpga.numIter_avg = result.dpga.numIter;
            resultarray.dpga.errL_avg = result.dpga.errL;
            resultarray.dpga.errS_avg = result.dpga.errS;       
        end
        if options.ealm.active
            resultarray.ealm.trun_avg = result.ealm.t_run;
            resultarray.ealm.numIter_avg = result.ealm.numIter;
            resultarray.ealm.errL_avg = result.ealm.errL;
            resultarray.ealm.errS_avg = result.ealm.errS;
        end
        if options.ialm.active
            resultarray.ialm.trun_avg = result.ialm.t_run;
            resultarray.ialm.numIter_avg = result.ialm.numIter;
            resultarray.ialm.errL_avg = result.ialm.errL;
            resultarray.ialm.errS_avg = result.ialm.errS;
        end
        if options.BLWSialm.active
            resultarray.BLWSialm.trun_avg = result.BLWSialm.t_run;
            resultarray.BLWSialm.numIter_avg = result.BLWSialm.numIter;
            resultarray.BLWSialm.errL_avg = result.BLWSialm.errL;
            resultarray.BLWSialm.errS_avg = result.BLWSialm.errS;
        end
    else
        if options.intpt.active
            resultarray.intpt.trun_avg = (resultarray.intpt.trun_avg*(j-1)+result.intpt.t_run)/j;
            resultarray.intpt.numIter_avg = (resultarray.intpt.numIter_avg*(j-1)+result.intpt.numIter)/j;
            resultarray.intpt.errL_avg = (resultarray.intpt.errL_avg*(j-1)+result.intpt.errL)/j;
            resultarray.intpt.errS_avg = (resultarray.intpt.errS_avg*(j-1)+result.intpt.errS)/j;
        end
        if options.itth.active
            resultarray.itth.trun_avg = (resultarray.itth.trun_avg*(j-1)+result.itth.t_run)/j;
            resultarray.itth.numIter_avg = (resultarray.itth.numIter_avg*(j-1)+result.itth.numIter)/j;
            resultarray.itth.errL_avg = (resultarray.itth.errL_avg*(j-1)+result.itth.errL)/j;
            resultarray.itth.errS_avg = (resultarray.itth.errS_avg*(j-1)+result.itth.errS)/j;
        end
        if options.apg.active
            resultarray.apg.trun_avg = (resultarray.apg.trun_avg*(j-1)+result.apg.t_run)/j;
            resultarray.apg.numIter_avg = (resultarray.apg.numIter_avg*(j-1)+result.apg.numIter)/j;
            resultarray.apg.errL_avg = (resultarray.apg.errL_avg*(j-1)+result.apg.errL)/j;
            resultarray.apg.errS_avg = (resultarray.apg.errS_avg*(j-1)+result.apg.errS)/j;
        end
        if options.papg.active
            resultarray.papg.trun_avg = (resultarray.papg.trun_avg*(j-1)+result.papg.t_run)/j;
            resultarray.papg.numIter_avg = (resultarray.papg.numIter_avg*(j-1)+result.papg.numIter)/j;
            resultarray.papg.errL_avg = (resultarray.papg.errL_avg*(j-1)+result.papg.errL)/j;
            resultarray.papg.errS_avg = (resultarray.papg.errS_avg*(j-1)+result.papg.errS)/j;
        end
        if options.dpga.active
            resultarray.dpga.trun_avg = (resultarray.dpga.trun_avg*(j-1)+result.dpga.t_run)/j;
            resultarray.dpga.numIter_avg = (resultarray.dpga.numIter_avg*(j-1)+result.dpga.numIter)/j;
            resultarray.dpga.errL_avg = (resultarray.dpga.errL_avg*(j-1)+result.dpga.errL)/j;
            resultarray.dpga.errS_avg = (resultarray.dpga.errS_avg*(j-1)+result.dpga.errS)/j;     
        end
        if options.ealm.active
            resultarray.ealm.trun_avg = (resultarray.ealm.trun_avg*(j-1)+result.ealm.t_run)/j;
            resultarray.ealm.numIter_avg = (resultarray.ealm.numIter_avg*(j-1)+result.ealm.numIter)/j;
            resultarray.ealm.errL_avg = (resultarray.ealm.errL_avg*(j-1)+result.ealm.errL)/j;
            resultarray.ealm.errS_avg = (resultarray.ealm.errS_avg*(j-1)+result.ealm.errS)/j;
        end
        if options.ialm.active
            resultarray.ialm.trun_avg = (resultarray.ialm.trun_avg*(j-1)+result.ialm.t_run)/j;
            resultarray.ialm.numIter_avg = (resultarray.ialm.numIter_avg*(j-1)+result.ialm.numIter)/j;
            resultarray.ialm.errL_avg = (resultarray.ialm.errL_avg*(j-1)+result.ialm.errL)/j;
            resultarray.ialm.errS_avg = (resultarray.ialm.errS_avg*(j-1)+result.ialm.errS)/j;
        end
        if options.BLWSialm.active
            resultarray.BLWSialm.trun_avg = (resultarray.BLWSialm.trun_avg*(j-1)+result.BLWSialm.t_run)/j;
            resultarray.BLWSialm.numIter_avg = (resultarray.BLWSialm.numIter_avg*(j-1)+result.BLWSialm.numIter)/j;
            resultarray.BLWSialm.errL_avg = (resultarray.BLWSialm.errL_avg*(j-1)+result.BLWSialm.errL)/j;
            resultarray.BLWSialm.errS_avg = (resultarray.BLWSialm.errS_avg*(j-1)+result.BLWSialm.errS)/j;
        end
    end
    
end