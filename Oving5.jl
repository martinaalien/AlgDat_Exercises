##########################################################################
#
#   Sammenlike DNA-sekvenser
#
##########################################################################


function dnasimilarity(s1, s2)
simnum = 0;
for i in 1:length(s1)
    if (s1[i] == s2[i])
        simnum += 1
    end
end
return simnum
end

println(dnasimilarity("CAATAAGGATCTGGTAGCTT", "CCTTACTGAAGCCGCTATGC"))
##########################################################################