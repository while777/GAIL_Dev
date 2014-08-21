%UT_MEANMCBERNOULLI_G  unit test for meanMCBernoulli_g
classdef ut_meanMCBernoulli_g < matlab.unittest.TestCase
    
    methods(Test)
        
        function meanMCBernoulli_gOfabs(testCase)
            in_param.abstol=1e-3;
            in_param.alpha = 0.01;
            in_param.errtype = 'abs';
            p=1/90;
            Yrand=@(n) rand(n,1)<p;
            meanp = meanMCBernoulli_g(Yrand,in_param);
            actualerr = abs(meanp-p);
            testCase.verifyLessThanOrEqual(actualerr,in_param.abstol);
        end
        
        function meanMCBernoulli_gOfrel(testCase)
            p=1/90;
            Yrand=@(n) rand(n,1)<p;
            in_param.reltol = 5e-2;
            meanp = meanMCBernoulli_g(Yrand,'errtype','rel','reltol',in_param.reltol);
            actualerr = abs(meanp-p)/p;
            testCase.verifyLessThanOrEqual(actualerr,in_param.reltol);
        end
        
        function meanMCBernoulli_gOfparsing(testCase)
            p=1/90;
            in_param.abstol = -1e-2;
            in_param.errtype = 'abs';
            meanp = testCase.verifyWarning(@()meanMCBernoulli_g...
                (@(n) (rand(n,1)<p).^2,...
                in_param),'MATLAB:meanMCBernoulli_g:abstolneg');
            actualerr = abs(meanp-p);
            testCase.verifyLessThanOrEqual(actualerr,abs(in_param.abstol));
        end
    end
end
