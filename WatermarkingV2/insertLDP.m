function [ldpPersonalData] = insertLDP(personalData,cldpi)
    ldpPersonalData = personalData;
    ldpSet = sort(randperm(length(personalData),floor(cldpi*length(personalData))));
    for i = 1:length(ldpSet)
        choice = ldpPersonalData(ldpSet(i))+1;
        m = [0, 1, 2];
        m(choice) = [];
        ldpPersonalData(ldpSet(i)) = m(randi(2));
    end
end

