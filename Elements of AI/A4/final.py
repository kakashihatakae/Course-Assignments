import pandas as pd
import numpy as np
import random
import time
from scipy.spatial.distance import cdist
import operator
import sys
from scipy import stats
from NNet import Neural_Net
import knn1
import decision_tree1

def process_data(data):
    data1 = data.iloc[:,1:]
    key = data.iloc[:,0]
    return key, data1

def process_data_dt(data):
    data1 = data.iloc[:,1:]
    key = data.iloc[:,0]
    return np.array(key), np.array(data1)

def train_cv_split(data) :
    key, data = process_data(data)
    train = data.sample(frac=0.75,random_state=200)
    cv = data.drop(train.index)
    return train, cv


def choose_K(data):
    train, cv = train_cv_split(data)
    X_train = np.array(train.iloc[:,1:])
    Y_train = np.array(train.iloc[:,0])
    X_cv = np.array(cv.iloc[:,1:])
    Y_cv = np.array(cv.iloc[:,0])
    dist_matrix = cdist(X_cv, X_train)
    accuracy = 0 
    K = [91,101,111]
    for k in K:
        Y_cv_pred = []
        for i in range(len(dist_matrix)):
            closest = np.argsort(dist_matrix[i])[:k]
            class1 = []
            for j in range(len(closest)):
                class1.append(Y_train[closest[j]])
            d = {x:class1.count(x) for x in class1}
            c = max(d.items(), key=operator.itemgetter(1))[0]
            Y_cv_pred.append(c)
        Y_cv1 = Y_cv.tolist()
        accuracy1 = sum(1 for x,y in zip(Y_cv1,Y_cv_pred) if x == y) / len(Y_cv)
        if accuracy1 > accuracy:
            accuracy = accuracy1
            k_opt = k 
        else :
            continue
    return k_opt
     


def knn(train, test):
    train_key,train_data = process_data(train)
    test_key,test_data = process_data(test)
    test_label = np.array(test_data.iloc[:,0])
    test_predictor = np.array(test_data.iloc[:,1:])
    train_label = np.array(train_data.iloc[:,0])
    train_predictor = np.array(train_data.iloc[:,1:])
    dist_matrix =  cdist(test_predictor, train_predictor)
    test_label_pred = []
    k_opt = choose_K(data)
    for i in range(len(dist_matrix)):
        k_small = np.argsort(dist_matrix[i])[:k_opt]
        class1 = []
        for j in range(len(k_small)):
            class1.append(train_label[k_small[j]])
        d = {x:class1.count(x) for x in class1}
        c = max(d.items(), key=operator.itemgetter(1))[0]
        test_label_pred.append(c)
    test_label1 =  test_label.tolist()
    accuracy_test = sum(1 for x,y in zip(test_label1,test_label_pred) if x == y) / len(test_label1)
    test_key1 = test_key.tolist()
    pred_df = pd.DataFrame({'image_id':test_key1,'label':test_label1,'pred_label':test_label_pred})
    return pred_df,accuracy_test


#----------------------------------------------------
# Decision tree
#----------------------------------------------------

def calculate_gini(y):
    unique, counts = np.unique(y, return_counts=True)
    sum_sqr = np.sum([(counts[i]/sum(counts))**2 for i in range(len(unique))])
    gini = 1 - sum_sqr
    return gini
    

def calculate_info_gain(x,y):
    total_gini = calculate_gini(y)
    unique_y, counts_y = np.unique(y, return_counts=True)
    random_x = random.sample(range(min(x), max(x)), 5)
    data = np.column_stack((x,y))
    best_gain = 0
    a = x
    b = y
    for k in random_x:
        q_l = len(a[a <= k])/len(a)
        q_r = len(a[a > k])/len(a)
        subset_l = data[data[:,0] <= k ,:]
        subset_r = data[data[:,0] > k ,:]
        x_l = subset_l[:,0]
        y_l = subset_l[:,1]
        x_r = subset_r[:,0]
        y_r = subset_r[:,1]
        unique_l, counts_l = np.unique(y_l, return_counts=True)
        gini_l = 1 - np.sum([(counts_l[i]/sum(counts_l))**2 for i in range(len(unique_l))])
        unique_r, counts_r = np.unique(y_r, return_counts=True)
        gini_r = 1 - np.sum([(counts_r[j]/sum(counts_r))**2 for j in range(len(unique_r))])
        info_gain = total_gini - (q_l*gini_l + q_r*gini_r)
        if  info_gain > best_gain:
            best_gain = info_gain
            split_value = k
        else:
            continue
    return best_gain, split_value


  
def Decision_tree_classifier(y_sub,x_sub,y,x,d):
    d = d+1
    if len(y_sub) == 0:
        return np.unique(y)[np.argmax(np.unique(y,return_counts=True)[1])]
    
    elif d == 6:
        return np.unique(y_sub)[np.argmax(np.unique(y_sub,return_counts=True)[1])]    
    
    else:
        best_info_gain = 0
        for i in range(len(x_sub[0])):
            gain, split_col_value = calculate_info_gain(x_sub[:,i],y_sub)
            if gain > best_info_gain:
                best_info_gain = gain
                split_value1 = split_col_value
                col_ind = i
            else :
                continue
        best_col = col_ind
        tree = {best_col:{}}
        data = np.column_stack((y_sub,x_sub))
        X = x_sub
        Y = y_sub
        a= [data[data[:,best_col] <= split_value1,:],data[data[:,best_col] > split_value1,:]]
        for j in range(len(a)):
            part = a[j]
            sub_x = part[:,1:]
            sub_y = part[:,0]
            sub_tree = Decision_tree_classifier(sub_y,sub_x,Y,X,d)
            tree[best_col][str(split_value1)+'_'+str(j)] = sub_tree
        return (tree)

def predict(query,tree,default=0):
    for key in list(query.keys()):
        if key in tree.keys():
            try:
                z = list(tree[key])[0]
                n = int(z.rsplit('_', 1)[0])
                if query[key] > n:
                    result = tree[key][str(n)+'_'+str(1)]
                else:
                    result = tree[key][str(n)+'_'+str(0)]
            except:
                return 0
        
            result1 = result
            if isinstance(result1,dict):
                return predict(query,result)
            else:
                return result1
            

            
def test_predict(data,tree):
    data1 = data.iloc[:,2:]
    new_col = [i for i in range(len(data1.columns))]
    data1.columns = new_col
    queries = data1.to_dict(orient = "records")
    predicted = pd.DataFrame(columns=["predicted"])
    for i in range(len(data1)):
        predicted.loc[i,"predicted"] = predict(queries[i],tree,1.0) 
    print('The prediction accuracy is: ',(np.sum(predicted["predicted"] == data.iloc[:,1])/len(data))*100,'%') 
    return predicted

def save_params(model, data):
    if model == 'nearest':
        file = open("model.txt", 'w')
    
    if model == 'nnet':
        file = open("model.txt", 'a')
        file.write(pred_df.to_string())
        file.close()    

    
    if model == 'tree':
        file = open("model.txt", 'w')

def retrieve_params(model):
    if model == 'nearest':
        pass
    
    if model == 'nnet':
        pass
    
    if model == 'tree':
        pass

if __name__== "__main__":
    data = pd.read_table("/u/yashkuma/a4/"+sys.argv[1], delim_whitespace=True, header=None)
    test = pd.read_table("/u/yashkuma/a4/"+sys.argv[1], delim_whitespace=True, header=None)

    if sys.argv[3] == 'nearest':
        if sys.argv[1] == 'train':
            pred, accuracy = knn(data,test)
            print("Classification accuracy")
            print(accuracy*100)
            key1 = test.iloc[:,0]
            actual = test.iloc[:,1]
            pred = test_predict(test,tree)
            pred_df = pd.concat([key1,actual,pred],axis=1)
            file = open("/u/yashkuma/a4/"+sys.argv[3], 'a') 
            file.write(pred_df.to_string())
            file.close()
        
        if sys.argv[1] == 'test':
            pass


    if sys.argv[3] == 'tree':
        if sys.argv[1] == 'train':
            key, data1 = process_data(data)
            tree = Decision_tree_classifier(data1[:,0],data1[:,1:],data1[:,0],data1[:,1:],0)
            key1 = test.iloc[:,0]
            actual = test.iloc[:,1]
            pred = test_predict(test,tree)

            pred_df = pd.concat([key1,actual,pred],axis=1)


            file = open("/u/yashkuma/a4/"+sys.argv[3], 'a')
            file.write(pred_df.to_string())
            file.close()
            
        if sys.argv[1] == 'test':
            pass


    if sys.argv[3] == 'nnet':
        new = Neural_Net([100], 0.4, 10)

        if sys.argv[1] == 'train':
            new.train()
            new.save_params()

        if sys.argv[1] == 'test':
            new.extract_params()
            new.check_test()