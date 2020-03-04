function y = program()

%NN generator application, compatible with any NinaPro database.

s = load('S1_A1_E2.mat');
stimulus = s.stimulus;
emg = s.emg;

totalSamples = size(emg,1);
electrodesNumber = size(emg,2);
gesturesNumber = max(stimulus);

%segment length
sampleRatio = 50;

%calculate MAV,RMS,SD,WL {0,1}
calculateMAV = 1;
calculateRMS = 0;
calculateSD = 0;
calculateWL = 0;

%number of NNs to generate
numberOfNNs = 1;

hiddenNeuronNumber = 10;

if calculateMAV + calculateRMS + calculateSD + calculateWL == 0
    gestures = generate_gestures_matrix_raw_data(stimulus,totalSamples,gesturesNumber);
    NN_generator(emg,gestures);
else
    gestures = generate_gestures_matrix(stimulus,totalSamples,gesturesNumber,sampleRatio);
    processed_input = process_data(emg,totalSamples,sampleRatio,electrodesNumber,calculateMAV,calculateRMS,calculateSD,calculateWL);
    y = generate_NN_data(numberOfNNs);
end


    function y = generate_NN_data(numberOfNNs)
        
        rowIndex = calculateMAV + calculateRMS + calculateSD + calculateWL;
        A = zeros(rowIndex,numberOfNNs);
        k = 0;
        
        if calculateMAV == 1
            k = k + 1;
            for i = 1:numberOfNNs
                gestures = generate_gestures_matrix(stimulus,totalSamples,gesturesNumber,sampleRatio);
                processed_input = process_data(emg,totalSamples,sampleRatio,electrodesNumber,calculateMAV,calculateRMS,calculateSD,calculateWL);
                A(k,i) = NN_generator(processed_input,gestures,30);
            end
        end
     
        
        
        if calculateSD == 1
            k = k + 1;
            for i = 1:numberOfNNs
                gestures = generate_gestures_matrix(stimulus,totalSamples,gesturesNumber,sampleRatio);
                processed_input = process_data(emg,totalSamples,sampleRatio,electrodesNumber,calculateMAV,calculateRMS,calculateSD,calculateWL);
                A(k,i) = NN_generator(processed_input,gestures,hiddenNeuronNumber);
            end
        end
        
        if calculateWL == 1
            k = k + 1;
            for i = 1:numberOfNNs
                gestures = generate_gestures_matrix(stimulus,totalSamples,gesturesNumber,sampleRatio);
                processed_input = process_data(emg,totalSamples,sampleRatio,electrodesNumber,calculateMAV,calculateRMS,calculateSD,calculateWL);
                A(k,i) = NN_generator(processed_input,gestures,hiddenNeuronNumber);
            end
        end 
        y = A';
    end

    plot(y)
    xlabel('number of samples');
    ylabel('AUC results');
end