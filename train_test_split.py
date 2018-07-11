
# coding: utf-8

# In[1]:


from sklearn.tree import DecisionTreeClassifier
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score
import pandas as pd
import numpy as np
from sklearn.cross_validation import train_test_split


# In[2]:


data=np.asarray(pd.read_csv('F:\Anaconda\TrainTestcheck.csv',header=None))


# In[3]:


X = data[:,0:2]
X


# In[4]:


y = data[:,2]
y


# In[5]:


X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=0.25,random_state=42)


# In[6]:


X_train


# In[7]:


X_test


# In[8]:


y_train


# In[9]:


y_test


# In[10]:


model=DecisionTreeClassifier()
model.fit(X_train,y_train)


# In[11]:


y_pred=model.predict(X_test)
acc=accuracy_score(y_test,y_pred)


# In[12]:


acc


# In[13]:


model1=SVC(kernel='rbf', degree=300)
model1.fit(X_train,y_train)


# In[14]:


y_pred1=model1.predict(X_test)
acc1=accuracy_score(y_test,y_pred1)

acc1


# In[15]:


#since accuracy of Decision tree is greater than Suport vector Machine (SVM) so decision tree is better than SVM in this example(taken data)

