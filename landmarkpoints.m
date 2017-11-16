function [landmark] = landmarkpoints(V,CONT,varv,landcont)

Elandmark =  V(1,:);
Dlandmark =  V(2,:);
Slandmark =  V(3,:);
Ilandmark =  V(4,:);
newposIlandmark =  V(5,:);
newposSlandmark =  V(6,:);
existe = CONT(2);

if (landcont == 4)
    
    if (existe == 1)
        
        a = [Elandmark(2)+varv(1,1) Elandmark(1)+varv(1,2)];
        b = [Dlandmark(2)+varv(1,1),Dlandmark(1)+varv(1,2)];
        c = [newposIlandmark(2)+varv(1,1) newposIlandmark(1)+varv(1,2)];
        d = [newposSlandmark(2)+varv(1,1) newposSlandmark(1)+varv(1,2)];
        landmark = [a;b;c;d];
    else
        a = [Elandmark(2)+varv(1,1) Elandmark(1)+varv(1,2)];
        b = [Dlandmark(2)+varv(1,1) Dlandmark(1)+varv(1,2)];
        c = [Slandmark(2)+varv(1,1) Slandmark(1)+varv(1,2)];
        d = [Ilandmark(2)+varv(1,1) Ilandmark(1)+varv(1,2)];
        landmark = [a;b;c;d];
    end
end

if (landcont == 5)
    
    Elandmark =  V(1,:);
    Dlandmark =  V(2,:);
    Slandmark =  V(3,:);
    Ilandmark =  V(4,:);
    newposIlandmark =  V(5,:);
    newposSlandmark =  V(6,:);
    existe = CONT(2);
    de2 = CONT(3);
    
    if (existe == 1)
        a = [Elandmark(2)+varv(1,1) Elandmark(1)+varv(1,2)];
        b = [Dlandmark(2)+varv(1,1) Dlandmark(1)+varv(1,2)];
        c = [newposIlandmark(2)+varv(1,1) newposIlandmark(1)+varv(1,2)];
        d = [newposSlandmark(2)+varv(1,1) newposSlandmark(1)+varv(1,2)];
        e = [newposSlandmark(2)+varv(1,1) newposSlandmark(1)+varv(1,2)+de2];
        landmark = [a;b;c;d;e];
    else
        a = [Elandmark(2)+varv(1,1) Elandmark(1)+varv(1,2)];
        b = [Dlandmark(2)+varv(1,1) Dlandmark(1)+varv(1,2)];
        c = [Slandmark(2)+varv(1,1) Slandmark(1)+varv(1,2)];
        d = [Ilandmark(2)+varv(1,1) Ilandmark(1)+varv(1,2)];
        e = [Slandmark(2)+varv(1,1) Slandmark(1)+varv(1,2)+de2];
        landmark = [a;b;c;d;e];
    end
end

if (landcont == 2)
    
    Elandmark =  V(1,:);
    Dlandmark =  V(2,:);
    
    a = [Elandmark(2)+varv(1,1) Elandmark(1)+varv(1,2)];
    b = [Dlandmark(2)+varv(1,1) Dlandmark(1)+varv(1,2)];
    landmark = [a;b];
    
end

end