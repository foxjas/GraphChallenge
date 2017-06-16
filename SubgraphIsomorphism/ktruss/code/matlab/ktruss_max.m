%KTRUSS Computer the maximal k-truss of a graph
% Inputs:
%       inc_mat_file - path to file containing incidence matrix
%
function [t_ktruss] = ktruss_max(inc_mat_file)

ii = load(inc_mat_file);
t0 = clock;
E = sparse( ii(:,1), ii(:,2), ii(:,3) );
t_read = etime(clock, t0);

t0 = clock;
t1 = clock;
k = 3;
tmp = E.'*E;
R = E* (tmp-diag(diag(tmp)));
s = sum(double(R==2),2);

while 1
    xc = s >= k-2;
    % While edges exist violating k-Truss, delete those edges and take a subgraph.
    while nnz(xc) ~= nnz(any(E,2))
        E(not(xc),:) = 0; % zero out edge-row    
        tmp = E.'*E;
        R = E* (tmp-diag(diag(tmp)));
        s = sum(double(R==2),2);
        xc = s >= k-2;
    end
    t_iter = etime(clock, t1);
    fprintf('k-iter=%d: %f\n', k, t_iter);
%     fprintf('k-iter=%d, |E|=%d\n', k, nnz(E));
    if ~nnz(xc)
        break
    end
    k = k+1;
    t1 = clock;
end

t_ktruss = etime(clock, t0);
fprintf('k=%d: %f\n', k-1, t_ktruss);

