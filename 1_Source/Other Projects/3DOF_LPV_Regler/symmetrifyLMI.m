function LMI = symmetrifyLMI(LMI)

LMI = (LMI + LMI')/2;