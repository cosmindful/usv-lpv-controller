function uM = smat2umat(sM, restrictedMonomialBasis, tolZero, isPolynomial, CoeffsN, N0);
%%

if strcmp(class(sM), 'sym')
    
     params = symvar(sM);
    nparams = length(params);
    
[uParams, sParamNames, uParamNames] = generateuParamsFromsParams(params);
    % Bring the uncertain parameters into workspace.
    for ii = 1:nparams
        eval([uParamNames{ii}, ' = uParams.Uncertainty.', uParamNames{ii}, ';']);
    end
    
    [sN, sD] = numden(vpa(sM, 32));
    paramsN  = symvar(sN);
    paramsD  = symvar(sD);

if nargin < 2
    sMonomialsN = generateMonomialBasisByOccurance(sN, paramsN);
    if ~isPolynomial
        sMonomialsD = generateMonomialBasisByOccurance(sD, paramsD);
    else
        sMonomialsD = [];
    end
%     sMonomialsN = generateMonomialBasisAlternative(paramsN, maxDegreeN);
%     sMonomialsD = generateMonomialBasisAlternative(paramsD, maxDegreeD);
    
%     sMonomialsN = identifyOccurringMonomials(sMonomialsN, sN);
%     sMonomialsD = identifyOccurringMonomials(sMonomialsD, sD);
else
    sMonomialsN = restrictedMonomialBasis;
    if ~isPolynomial
        sMonomialsD = restrictedMonomialBasis;
    else
        sMonomialsD = [];
    end
end
    
if nargin < 5
    [CoeffsN, N0] = collectCoefficients(sN, sMonomialsN);
end
	if ~isPolynomial
        [CoeffsD, D0] = collectCoefficients(sD, sMonomialsD);
    else
        CoeffsD = {};
        D0      = double(sD);
    end
    
    CoeffsN = cleanUpCell(CoeffsN, tolZero);
    CoeffsD = cleanUpCell(CoeffsD, tolZero);

    nmN = length(sMonomialsN);
    nmD = length(sMonomialsD);
    
    % Construct monomial vectors in uncertain real format
    str_monomialsN = {};
    for ii = 1:nmN
       str_monomialsN{ii} = char(sMonomialsN(ii));
       for jj = 1:numel(sParamNames)
           str_monomialsN{ii} = strrep(str_monomialsN{ii}, sParamNames{jj}, uParamNames{jj});
       end
       str_monomialsN{ii} = [str_monomialsN{ii}, ';'];
    end
    str_monomialsD = {};
    for ii = 1:nmD
       str_monomialsD{ii} = char(sMonomialsD(ii));
       for jj = 1:numel(sParamNames)
           str_monomialsD{ii} = strrep(str_monomialsD{ii}, sParamNames{jj}, uParamNames{jj});
       end
       str_monomialsD{ii} = [str_monomialsD{ii}, ';'];
    end
%     eval(['uMonomialsN = [', reshape(char(str_monomialsN(:))', 1, []), '];']);
    uMonomialsNCell = {};
    nmNbits     = ceil(nmN/20);
    for kk = 1:nmNbits
        uMonomialsNCell{kk} = umat();
        fprintf(':');
    for ii = (kk*20-19):min((kk*20), nmN)
        fprintf('.');
        eval(['uMonomialsNCell{kk} = [uMonomialsNCell{kk}; ', reshape(char(str_monomialsN(ii))', 1, []), '];']);
        uMonomialsNCell{kk} = simplify(uMonomialsNCell{kk}, 'full');
    end
    end
    uMonomialsN = umat();
    for kk = 1:nmNbits
        fprintf('_');
        uMonomialsN = [uMonomialsN; uMonomialsNCell{kk}];
        uMonomialsN = simplify(uMonomialsN, 'full');
    end
    fprintf('\n');
    eval(['uMonomialsD = [', reshape(char(str_monomialsD(:))', 1, []), '];']);
%     uMonomialsN seems to be correct, umat2smat doesnt work properly
%     though
    
    [n1, n2] = size(sM);
    
    CoeffsNVectors = cellfun(@(x) reshape(x, [], 1), CoeffsN, 'UniformOutput', false);
    CoeffsNMatVectors = writeFatMatrixFromCoeffCells(CoeffsNVectors);

    % Piece everything together
    uN = umat(double(N0));
    uD = umat(double(D0));
    
    uNVectors = CoeffsNMatVectors*uMonomialsN;
    uNVectors = simplify(uNVectors, 'full');

    uN = umat(O(n1, n2));
    if ~isempty(uMonomialsN)
        for ii = 1:n2
            fprintf('a');
            uN(:, ii) = simplify(uNVectors((ii*n1-(n1-1)):(ii*n1)), 'full');
    %         uN = simplify(umat(uN), 'full'); If this is enabled, uN will turn
    %         out a double!
        end
        uN = simplify(umat(uN), 'full');
        uN = uN + umat(double(N0));
    end
%     for ii = 1:nmN
%         uN = uN + double(CoeffsN{ii})*uMonomialsN(ii);
% %         simplify(uN, 'full');
%     end
    if ~isPolynomial
        for ii = 1:nmD
            uD = uD + double(CoeffsD{ii})*uMonomialsD(ii);
    %         simplify(uD, 'full');
        end

        % Reconstruct the rational function
        % Caution - DOESN NOT SEEM TO WORK
        uMTemp = cell(n1, n2);
        for ii = 1:n1
            for jj = 1:n2
                a = uN(ii, jj);
                b = uD(ii, jj);
                uMTemp{ii, jj} = a/b;
            end
        end

        uM = umat(O(n1, n2));
        for ii = 1:n1
            for jj = 1:n2
                uM(ii, jj) = uMTemp{ii, jj};
            end
        end
    else
        uM = uN;
    end
    
    uM = simplify(umat(uM), 'full');

    

end