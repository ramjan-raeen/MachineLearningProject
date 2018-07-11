
# coding: utf-8

# In[1]:


import pandas
import numpy


# In[2]:


data = pandas.read_csv('F:\Anaconda\iris.csv')


# In[3]:


X = numpy.array(data[['x1', 'x2']])
y = numpy.array(data['y'])


# In[4]:


X


# In[5]:


y


# In[6]:


#from sklearn.tree import DecisionTreeClassifier
#from sklearn.linear_model import LogisticRegression
#from sklearn.ensemble import GradientBoostingClassifier
#from sklearn.svm import SVC
#classifier=LogisticRegression()
#classifier.fit(X,y)
#classifier=GradientBoostingClassifier()
#classifier.fit(X,y)
#classifier=SVC(kernel = 'rbf', degree = 300)
#classifier.fit(X,y)
#classifier = DecisionTreeClassifier()
#classifier.fit(X,y)
from sklearn.linear_model import LogisticRegression
classifier=LogisticRegression()
classifier.fit(X,y)


# In[7]:


from sklearn.tree import DecisionTreeClassifier
classifier = DecisionTreeClassifier()
classifier.fit(X,y)


# In[8]:


from sklearn.svm import SVC
classifier=SVC(kernel='rbf',degree=300)
classifier.fit(X,y)


# In[9]:


from sklearn.ensemble import GradientBoostingClassifier
classifier=GradientBoostingClassifier()
classifier.fit(X,y)

