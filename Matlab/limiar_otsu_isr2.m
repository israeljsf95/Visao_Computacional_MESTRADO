function [T] = limiar_otsu_isr2(im_hist)

    p_i = im_hist(:);
    K = 0:255;
    K = K(:);
    P1_k = cumsum(p_i);
    P2_k = 1 - P1_k;
    M1_k = cumsum(p_i.*K)./P1_k;
    M_k = cumsum(p_i.*K);
    mg = K'*p_i;
    sig_b_2 = ((mg*P1_k - M_k).^2)./(P1_k.*P2_k);
    [~, I] = max(sig_b_2);
    T = K(I(1)+1);
end