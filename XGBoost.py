import xgboost as xgb
from numpy import loadtxt
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import numpy as np
# load data
dataset = loadtxt("D:\\pycharm\\ML\\DroneRF-master\\DroneRF-master\\Data\\RF_Data.csv", delimiter=",")
# split data into X and y
X = dataset[0:2048,:]
Y = dataset[0:1,:]

# split data into train and test sets
seed = 7
test_size = 0.2
X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size=test_size, random_state=seed)

params ={'learning_rate': 0.4,
          'max_depth': 20,                # 构建树的深度，越大越容易过拟合
          'num_boost_round':2000,
          'objective': 'binary:logistic',
          'random_state': 7,
          'silent':0,
          'eta':0.8
        }
model = xgb.train(params,xgb.DMatrix(X_train, y_train))
y_pred=model.predict(xgb.DMatrix(X_test))

model.save_model('testXGboostClass.model')  # 保存训练模型

yprob = np.argmax(y_pred, axis=1)  # return the index of the biggest pro

predictions = [round(value) for value in yprob]

# evaluate predictions
accuracy = accuracy_score(y_test, predictions)
print("Accuracy: %.2f%%" % (accuracy * 100.0))

