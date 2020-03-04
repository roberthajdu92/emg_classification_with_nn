function [dbInput,gestures,dbTest] = generate_test_data()

s = load('S1_A1_E1.mat');
totalSamples = 100000;
sampleRatio = 10;
inputColumnSize = round(totalSamples/sampleRatio);
isTest = 0;

dbInput = calculate_databases(isTest);
isTest = 1;
dbTest = calculate_databases(isTest);

generatedStimulus = s.stimulus(1:2:end,1:2:end);
gestures = generate_gestures_matrix_for_statistics(generatedStimulus,round(totalSamples/2),sampleRatio);


    function input = calculate_databases(isTest)
        input = zeros(inputColumnSize/2,10);
        i=1;
        for j = 1:inputColumnSize
            if mod(j,2) == isTest
                for k = 1:10
                    input(round(j/2),k) = meanabs(s.emg(i:i+sampleRatio,k));
                end
            end
            i = i+sampleRatio;
        end
    end

end