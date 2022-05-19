function AdjMat = generate_randomNormalizedDirectedAdjacencyMatrix(nH, threshold, demandConnectivity)
% Generates a random symmetric normalized (row and col) adjacency matrix

    AdjMat = zeros(nH, nH);
    hasOneEigenvalue = find(eig(AdjMat) == 1);

    if demandConnectivity
        while isempty(hasOneEigenvalue)
            AdjMat = generate_randomDirectedAdjacencyMatrix(nH, threshold);       
            hasOneEigenvalue = find(eig(AdjMat) == 1);
        end
    else
        AdjMat = generate_randomDirectedAdjacencyMatrix(nH, threshold);
    end

    AdjMat = colrowNormalizeMatrix(AdjMat);
end



function AdjMatUnnormalized = generate_randomDirectedAdjacencyMatrix(nH, threshold)

        AdjMatUnnormalized = rand(nH);
%         AdjMatUnnormalized = (AdjMatUnnormalized + AdjMatUnnormalized')/2;
        AdjMatUnnormalized = double(AdjMatUnnormalized > threshold);
        for ii = 0:(nH-1)
            AdjMatUnnormalized(1 + ii*(nH+1)) = 0;
        end
end