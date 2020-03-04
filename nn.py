import tensorflow as tf
import numpy as np
import pandas as pd
import csv
import sklearn.model_selection
import feature_extraction as fe

s_len = 500
window = 250
database = 'database/S1_A1_E3.mat'

x = fe.feature_extraction(s_len, window, database)
y = fe.extract_stimulus(s_len, window, database)

y = tf.keras.utils.to_categorical(y)

x_train, x_valid, y_train, y_valid = sklearn.model_selection.train_test_split(x, y, test_size=0.2)

# keras.util model gráf (dotban, át lehet konvertálni png-be)
model = tf.keras.models.Sequential([
    tf.keras.layers.Dense(30, activation=tf.nn.relu, input_shape=(10,)),

    tf.keras.layers.Dense(len(y_train[0]), activation=tf.nn.softmax)
])

model.compile(optimizer='Adam',
              loss='categorical_crossentropy',
              metrics=['accuracy'], )
# optimizer Nadam, Adagrad

history = model.fit(x_train, y_train, epochs=5, verbose=1, validation_data=(x_valid, y_valid))
