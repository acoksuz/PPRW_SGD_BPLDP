function [ final_mssg ] = calculate_c_local_initial(cNodes, c)
    err = 0.000001;
    corCoef = cell2mat(cNodes(c,3)); %Correlation converted into probability
    i = cell2mat(cNodes(c,4));
    j = cell2mat(cNodes(c,5));
    coming_msg = cell2mat(cNodes(c,7));
    prob = coming_msg(i+1) * (corCoef)^2;
    prob2 = (1 - (corCoef)^2)/2; 
    if j == 0 
        final_mssg = [prob prob2*coming_msg(2) prob2*coming_msg(3)] + err;     
    elseif j == 1 
        final_mssg = [prob2*coming_msg(1) prob prob2*coming_msg(3)] + err;     
    elseif j == 2 
        final_mssg = [prob2*coming_msg(1) prob2*coming_msg(2) prob] + err;
    else
        error('Incorrect i value!');
    end
end