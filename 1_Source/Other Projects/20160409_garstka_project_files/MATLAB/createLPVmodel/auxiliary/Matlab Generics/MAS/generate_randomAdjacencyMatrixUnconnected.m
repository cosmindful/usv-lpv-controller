function AdjMatUnnormalized = generate_randomAdjacencyMatrixUnconnected(nH, threshold)

        AdjMatUnnormalized = rand(nH);
        AdjMatUnnormalized = (AdjMatUnnormalized + AdjMatUnnormalized')/2;
        AdjMatUnnormalized = double(AdjMatUnnormalized > threshold);
        for ii = 0:(nH-1)
            AdjMatUnnormalized(1 + ii*(nH+1)) = 0;
        end
end