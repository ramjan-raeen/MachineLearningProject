
# coding: utf-8

# In[1]:


import pandas as pd
#import numpy as np


# In[2]:


bmi_life_data=pd.read_csv("F:\Anaconda\life.csv")


# In[3]:


from sklearn.linear_model import LinearRegression
bmi_life_model=LinearRegression()
bmi_life_model.fit(bmi_life_data[['BMI']],bmi_life_data[['Life expectancy']])


# In[4]:


laos_life_exp=bmi_life_model.predict(21.07931)


# In[5]:


laos_life_exp


# # TODO: Add import statements
# import pandas as pd
# 
# 
# # Assign the dataframe to this variable.
# # TODO: Load the data
# bmi_life_data = pd.read_csv("bmi_and_life_expectancy.csv")
# 
# # Make and fit the linear regression model
# #TODO: Fit the model and Assign it to bmi_life_model
# from sklearn.linear_model import LinearRegression
# bmi_life_model = LinearRegression()
# bmi_life_model.fit(bmi_life_data[['BMI']],bmi_life_data[['Life expectancy']])
# 
# 
# # Make a prediction using the model
# # TODO: Predict life expectancy for a BMI value of 21.07931
# laos_life_exp = bmi_life_model.predict(21.07931)
