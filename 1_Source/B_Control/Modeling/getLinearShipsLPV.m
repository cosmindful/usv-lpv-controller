function [G,countedRanks,badCombinations] = getLinearShipsLPV(p1,p2,p3,p4)

np1 = numel(p1);
np2 = numel(p2);
np4 = numel(p3);
np5 = numel(p4);

G = ss(zeros(2,2,np1,np2,np4,np5));

index =1;
myEps = 0.1;

badCombinations = zeros(4,40);
otherIndex = 1;
for aa=1:np1
    for bb=1:np2
        %         for cc=1:np3
        for dd=1:np4
            for ee=1:np5
%                 if (abs(p1(aa))<myEps)
%                     p1(aa) = myEps;
%                 end
%                 if (abs(p2(bb))<myEps)
%                     p2(bb) = myEps;
%                 end
%                 if (abs(p3(cc))<myEps)
%                     p3(cc) = myEps;
%                 end
%                 if(abs(p4(dd))<myEps)
%                     p4(dd) = myEps;
%                 end
%                 if(abs(p5(ee))<myEps)
%                     p5(ee) = 0;
%                 end
                %                 G(:,:,aa,bb,cc,dd,ee)= LPVplant(p1(aa),p2(bb),p3(cc),p4(dd),p5(ee),Jac);
                %                 rankList(index) = rank(ctrb(G(:,:,aa,bb,cc,dd,ee).A,G(:,:,aa,bb,cc,dd,ee).B));
                
                G(:,:,aa,bb,dd,ee)= LPVplant(p1(aa),p2(bb),p3(dd),p4(ee));
                rankList(index) = rank(ctrb(G(:,:,aa,bb,dd,ee).A,G(:,:,aa,bb,dd,ee).B));
                if rankList(index)<4
                    badCombinations(:,otherIndex) = [p1(aa);p2(bb);p3(dd);p4(ee)];
                    otherIndex = otherIndex+1;
                end
                index = index +1;
            end
        end
        %         end
    end
end
countedRanks = [histc(rankList,1) histc(rankList,2) histc(rankList,3)...
    histc(rankList,4) histc(rankList,5) histc(rankList,6) ];
badCombinations = badCombinations(:,otherIndex);


function G = LPVplant(u_r,v_r,n_r,delta_r)
syms u v r n delta
% Jac_r = double(subs(Jac, [u v r n delta], [u_r v_r r_r n_r delta_r]));
% A = Jac_r(1:3,1:3);
% B = Jac_r(1:3,4:5);
thetaVector = getqLPVFossen(u_r,v_r,n_r,delta_r);
A11 = thetaVector(:,1);
A12 = thetaVector(:,2);
A13 = thetaVector(:,3);
A21 = thetaVector(:,4);
A22 = thetaVector(:,5);
A23 = thetaVector(:,6);
A31 = thetaVector(:,7);
A32 = thetaVector(:,8);
A33 = thetaVector(:,9);

B11 = thetaVector(:,10);
B12 = thetaVector(:,11);
B21 = thetaVector(:,12);
B22 = thetaVector(:,13);
B31 = thetaVector(:,14);
B32 = thetaVector(:,15);
% generate system matrices
% A = [A11 A12 A13;
%     A21 A22 A23;
%     A31 A32 A33];
% B = [B11 B12; B21 B22; B31 B32];
% C = eye(3);
A = [A11 A12 A13 0;
    A21 A22 A23 0;
    A31 A32 A33 0
    0     0   1 0];
B = [B11 B12; B21 B22; B31 B32; 0 0];
C = [1 0 0 0;
     0 0 0 1];
% C = [ 0 0 0 1];

% get LTI system
G = ss(A,B,C,0);
% G.OutputName={'u','v','r'};
% G.OutputName={'u','v','psi'};
% G.OutputName={'psi'};
G.OutputName={'u','psi'};
G.InputName={'n','delta'};
% G.StateName={'u','v','r'};
G.StateName={'u','v','r','psi'};