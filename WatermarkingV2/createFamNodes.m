function [ famNodes ] = createFamNodes(dataSize, family)
    famNodes = cell(1,dataSize);
    err = 0;%0.000000001;
    Mendel_00 = [1 err err];
    Mendel_01 = [0.5 0.5 err];
    Mendel_02 = [err 1 err];
    Mendel_11 = [0.25 0.5 0.25];
    Mendel_12 = [err 0.5 0.5];
    Mendel_22 = [err err 1];
    
    for i=1:length(famNodes)
        if((family(1,i)==0 && family(2,i)==0))
            famNodes{1,i} = Mendel_00;
        end
        if((family(1,i)==1 && family(2,i)==1))
            famNodes{1,i} = Mendel_11;
        end
        if((family(1,i)==2 && family(2,i)==2))
            famNodes{1,i} = Mendel_22;
        end
        if((family(1,i)==0 && family(2,i)==1)||(family(1,i)==1 && family(2,i)==0))
            famNodes{1,i} = Mendel_01;
        end
        if((family(1,i)==0 && family(2,i)==2)||(family(1,i)==2 && family(2,i)==0))
            famNodes{1,i} = Mendel_02;
        end
        if((family(1,i)==1 && family(2,i)==2)||(family(1,i)==2 && family(2,i)==1))
            famNodes{1,i} = Mendel_12;
        end
    end
    famNodes = famNodes';
end