function LeaderFollowerMat = generate_leaderFollowerPseudoLaplacianMatrix(nF, nL)

LapMatFF = -generate_randomNormalizedLaplacianMatrix(nF);
LapMatLL = -generate_randomNormalizedLaplacianMatrix(nL);
MatLL    = 0*LapMatLL;

MatFL    = rand(nF, nL);
MatFL    = double(MatFL > 0.33);

MatFL    = rowNormalizeMatrix(MatFL);
MatFLrowSum = MatFL*ones(nL, 1);

MatLF    = rand(nL, nF);
MatLF    = double(MatLF > 0.63)*0;

MatLF    = colNormalizeMatrix(MatLF);
MatLFcolSum = ones(1, nL)*MatLF;

MatFF    = LapMatFF - (diag(MatFLrowSum) + diag(MatLFcolSum));
% MatFF    = LapMatFF + I(nF);


LeaderFollowerMat = [ MatLL   , MatFL'
                      MatFL   , MatFF ];
                  
LeaderFollowerMat = colrowNormalizeMatrix(LeaderFollowerMat);

LeaderFollowerMat(1:nL, nL+1:end) = 0;


LeaderFollowerMat(nL+1:end, nL+1:end) = LeaderFollowerMat(nL+1:end, nL+1:end) + 1;
                  