function [ModLapMat] = generate_Laplacian(nH, threshold, demandConnectivity)
% AdjMat = generate_randomAdjacencyMatrix(nF, 0.5, 1);

AdjMatUnnormalized = generate_randomAdjacencyMatrixUnconnected(nH, threshold);

ModLapMat = -diag(AdjMatUnnormalized*ones(nH, 1)) + AdjMatUnnormalized;

% 
%     AdjMat = zeros(nH, nH);
%     hasOneEigenvalue = find(eig(AdjMat) == 1);
% 

isconnected = 0;

    if demandConnectivity
        while ~isconnected
            AdjMatUnnormalized = generate_randomAdjacencyMatrixUnconnected(nH, threshold);
            ModLapMat = diag(AdjMatUnnormalized*ones(nH, 1)) - AdjMatUnnormalized;
            eigs      = sort(eig(ModLapMat));
            isconnected = eigs(2) > eps;
        end
    else
        AdjMatUnnormalized = generate_randomAdjacencyMatrixUnconnected(nH, threshold);
        ModLapMat = diag(AdjMatUnnormalized*ones(nH, 1)) - AdjMatUnnormalized;
    end
% 
% %     AdjMat = colrowNormalizeMatrix(AdjMat);
% end
