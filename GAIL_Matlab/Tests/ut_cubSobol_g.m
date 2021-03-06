%ut_cubSobol_g  unit test for cubSobol_g
classdef ut_cubSobol_g < matlab.unittest.TestCase
  
  methods(Test)
    
    function cubSobol_gOfxsquare(testCase)
      f = @(x) x.^2;
      in_param.abstol = 1e-2;
      hyperbox = [0;1];
      [meanf,out_param] = cubSobol_g(f,hyperbox,in_param);
      exactf = 0.33;
      actualerr = abs(meanf-exactf);
      tolerance = gail.tolfun(out_param.abstol,out_param.reltol,out_param.theta,exactf,out_param.toltype);
      testCase.verifyLessThanOrEqual(actualerr,tolerance);
      testCase.verifyTrue(out_param.d==1);
    end
    
    function cubSobol_gOfexp(testCase)
      f = @(x) exp(x);
      in_param.abstol = 1e-3;
      hyperbox = [0;1];
      [meanf,out_param] = cubSobol_g(f,hyperbox,in_param);
      exactf = exp(1)-1;
      actualerr = abs(meanf-exactf);
      tolerance = gail.tolfun(out_param.abstol,out_param.reltol,out_param.theta,exactf,out_param.toltype);
      testCase.verifyLessThanOrEqual(actualerr,tolerance);
      testCase.verifyTrue(out_param.d==1);
    end
    
    function cubSobol_gOfsin(testCase)
      f = @(x) sin(x);
      in_param.abstol = 1e-3;
      hyperbox = [0;1];
      [meanf,out_param] = cubSobol_g(f,hyperbox,in_param);
      exactf = 1-cos(1);
      actualerr = abs(meanf-exactf);
      tolerance = gail.tolfun(out_param.abstol,out_param.reltol,out_param.theta,exactf,out_param.toltype);
      testCase.verifyLessThanOrEqual(actualerr,tolerance);
      testCase.verifyTrue(out_param.d==1);
    end
    
    function cubSobol_gOfmultierrfun(testCase)
      f = @(x) exp(-x(:,1).^2-x(:,2).^2);
      in_param.abstol = 1e-3;
      hyperbox = [0 0;1 1];
      [meanf,out_param] = cubSobol_g(f,hyperbox,in_param);
      exactf = pi/4*erf(1)^2;
      actualerr = abs(meanf-exactf);
      tolerance = gail.tolfun(out_param.abstol,out_param.reltol,out_param.theta,exactf,out_param.toltype);
      testCase.verifyLessThanOrEqual(actualerr,tolerance);
      testCase.verifyTrue(out_param.d==2);
    end
    
    function cubSobol_gOfwarning(testCase)
        testCase.verifyWarning(@()cubSobol_g,'GAIL:cubSobol_g:fdnotgiven');
    end
    
    function cubSobol_gOdwarning(testCase)
        testCase.verifyWarning(@()cubSobol_g(@(x)x.^2,1.5),'GAIL:cubSobol_g:hyperbox_error1');
    end
    
    function cubSobol_Workouts(testCase)
        [ut_abserr,ut_relerr,abstol,reltol] = Test_cubSobol_g;
        verifyabserr = ut_abserr<=abstol;
        verifyrelerr = ut_relerr<=reltol;
        testCase.verifyTrue(min(min(verifyabserr + verifyrelerr))>0);
    end
  end
end
