function AdjMat = generate_randomAdjacencyMatrix(nH, threshold, demandConnectivity)
% Generates a random symmetric adjacency matrix

    AdjMat = zeros(nH, nH);
    hasOneEigenvalue = find(eig(AdjMat) == 1);

    if demandConnectivity
        while isempty(hasOneEigenvalue)
            AdjMat = generate_randomAdjacencyMatrixUnconnected(nH, threshold);       
            hasOneEigenvalue = find(eig(AdjMat) == 1);
        end
    else
        AdjMat = generate_randomAdjacencyMatrixUnconnected(nH, threshold);
    end

%     AdjMat = colrowNormalizeMatrix(AdjMat);
end



function AdjMatUnnormalized = generate_randomAdjacencyMatrixUnconnected(nH, threshold)

        AdjMatUnnormalized = rand(nH);
        AdjMatUnnormalized = (AdjMatUnnormalized + AdjMatUnnormalized')/2;
        AdjMatUnnormalized = double(AdjMatUnnormalized > threshold);
        for ii = 0:(nH-1)
            AdjMatUnnormalized(1 + ii*(nH+1)) = 0;
        end
end