function gestures = generate_gestures_matrix_raw_data(stimulus,totalSamples,gesturesNumber)

%generating gestures matrix for ANN target
gestures = zeros(totalSamples,gesturesNumber);

for i = 1:totalSamples
    j = stimulus(i);
    if j>0
        gestures(i,j)=1;
    end
end

end