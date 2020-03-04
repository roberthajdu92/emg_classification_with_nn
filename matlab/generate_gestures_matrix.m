function gestures = generate_gestures_matrix(stimulus,totalSamples,gesturesNumber,sampleRatio)

%totalSamples = 100000;
%sampleRatio = 20;
%generating gestures matrix for ANN target
gestures = zeros(round(totalSamples/sampleRatio),gesturesNumber);
i=1;
k=1;

for i = 1:sampleRatio:totalSamples
    
    gestureArray = [];
    for j = i:i+sampleRatio
        
        x=stimulus(j);
        if x == 0
            break;
        end
        gestureArray = [gestureArray, x];
        
    end
    
    if x > 0 && range(gestureArray) == 0
        gestures(k,gestureArray(1)) = 1;
    end
    k = k+1;
    
end

end