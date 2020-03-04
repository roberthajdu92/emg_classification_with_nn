import scipy.io as sio
import numpy as np
import matplotlib.pyplot as plt


def feature_extraction(s_len, window, fname):
    db = sio.loadmat(fname)

    emg = db['emg']
    emg = np.array(emg).transpose().reshape(10, -1)

    size = len(emg[0])
    channels = len(emg)
    end = size - s_len
    emg_array = np.empty((int(size / window) - 1, channels))

    start = 0
    j = 0
    while start < end:
        for i in range(channels):
            emg_array[j][i] = np.mean(emg[i][start:start + s_len])
            # np.sqrt(np.mean(np.square(emg[i][start:start + s_len])))
        start = start + window
        j = j + 1

    # plt.plot(emg)
    # plt.show()
    return emg_array


def extract_stimulus(s_len, window, fname):
    db = sio.loadmat(fname)

    gestures = db['stimulus']
    gestures = np.array(gestures).transpose().reshape(1, -1)
    # np.savetxt("y_raw.csv",gestures,delimiter=",")

    size = len(gestures[0])
    channels = len(gestures)
    end = size - s_len
    gestures_array = np.empty((int(size / window) - 1), dtype=int)
    start = 0
    i = 0

    while start < end:
        max = int(np.amax(gestures[0][start:start + window]))
        if (gestures[0][start:start + s_len] == max).sum() / s_len > 0.9:
            gestures_array[i] = max
        else:
            gestures_array[i] = 0

        i = i + 1
        start = start + window

    return gestures_array

# emg = feature_extraction(500,250,'database/S1_A1_E1.mat')
# gestures = extract_stimulus(500,250,'database/S1_A1_E1.mat')


# np.savetxt("y_train.csv",gestures,delimiter=",")
