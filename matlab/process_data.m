function inputData = process_data(emg,totalSamples,sampleRatio,electrodesNumber,calculateMAV,calculateRMS,calculateSD,calculateWL)

inputColumnSize = round(totalSamples/sampleRatio);
inputData=[];

if calculateMAV > 0
    inputData = cat(2,inputData,calculate_MAV);
end
if calculateRMS > 0
    inputData = cat(2,inputData,calculate_RMS);
end
if calculateSD > 0
    inputData = cat(2,inputData,calculate_SD);
end
if calculateWL > 0
    inputData = cat(2,inputData,calculate_WL);
end


    function input = calculate_MAV()
        input = zeros(inputColumnSize,electrodesNumber);
        i=1;
        for j = 1:inputColumnSize-1
            for k = 1:electrodesNumber
                input(j,k) = meanabs(emg(i:i+sampleRatio,k));
            end
            i = i+sampleRatio;
        end
    end

    function input = calculate_RMS()
        input = zeros(inputColumnSize,electrodesNumber);
        i=1;
        for j = 1:inputColumnSize-1
            for k = 1:electrodesNumber
                input(j,k) = rms(emg(i:i+sampleRatio,k));
            end
            i = i+sampleRatio;
        end
    end

    function input = calculate_SD()
        input = zeros(inputColumnSize,electrodesNumber);
        i=1;
        for j = 1:inputColumnSize-1
            for k = 1:electrodesNumber
                input(j,k) = std(emg(i:i+sampleRatio,k));
            end
            i = i+sampleRatio;
        end
    end

    function input = calculate_WL()
        input = zeros(inputColumnSize,electrodesNumber);
        i=1;
        for j = 1:inputColumnSize-1
            for k = 1:electrodesNumber
                input(j,k) = sum(abs(diff((emg(i:i+sampleRatio,k)))));
            end
            i = i+sampleRatio;
        end
    end

end