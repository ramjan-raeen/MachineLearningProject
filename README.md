# Content: Supervised Learning
## 1. Project: Finding Donors for CharityML

## Project Overview
In this project, I applyed supervised learning techniques and an analytical mind on data collected for the U.S. census to help CharityML (a fictitious charity organization) identify people most likely to donate to their cause. I first explored the data to learn how the census data is recorded. Next, I applyed a series of transformations and preprocessing techniques to manipulate the data into a workable format. Then I evaluated several supervised learners of my choice on the data, and consider which is best suited for the solution. Afterwards, I optimized the model I've selected and present it as my solution to CharityML. Finally, I explored the chosen model and its predictions under the hood, to see just how well it's performing when considering the data it's given.


## Project Highlights
This project is designed to get you acquainted with the many supervised learning algorithms available in sklearn, and to also provide for a method of evaluating just how each model works and performs on a certain type of data. It is important in machine learning to understand exactly when and where a certain algorithm should be used, and when one should be avoided.

Things I've learned by completing this project:
- How to identify when preprocessing is needed, and how to apply it.
- How to establish a benchmark for a solution to the problem.
- What each of several supervised learning algorithms accomplishes given a specific dataset.
- How to investigate whether a candidate solution model is adequate for the problem.

## 2. Project: Price prediction for new House Sales in King County, USA

## Project Overview
In this project, I've applyed supervised learning techniques and also saw patterns of data analytically to  predict price of new houses sales in King County, USA. Firstly, I explored the data to learn how House sales data is recored and then I applied feature engineering to manupulate the data to workable format. Then I checked correlations of features/attributes to target, and eliminated which is not much relevent indeed I took only ten most relevent features by using [RFE](https://scikit-learn.org/stable/modules/generated/sklearn.feature_selection.RFE.html) and then I moved for train and evalute my model. I trained different - different regression model and also calculated training and testing score to see which model has well trained. I also draw learning curve to see which model well trained which will be the best for final prediction or to avoid Underfitting and Overfitting. And then finally I selected best one for prediction.

## Project Highlights
This project is designed to get you acquainted with the many supervised learning algorithms available in sklearn, as well as to go step by step to choose best one trained model and to also provide for a method of evaluating ust how each model works and performs on a certain type of data. It is important in machine learning to understand exactly when and where a certain algorithm should be used, and when one should be avoided.

Things I've learned by completing this project:
- How to identify when preprocessing is needed, and how to apply it?
- How to eliminate unrelevant and select most relevant features to avoid redundancy? 
- How to train model to avoid Underfitting and Overfitting our model?
- How to select best one model for the final prediction?
## Software Requirements

This project uses the following software and Python libraries:

- [Python 3](https://www.python.org/download/releases/3.0/)
- [NumPy](http://www.numpy.org/)
- [Pandas](http://pandas.pydata.org/)
- [scikit-learn](http://scikit-learn.org/stable/)
- [matplotlib](http://matplotlib.org/)

I'm using [Colaboratory ot colab](https://colab.research.google.com/notebooks/intro.ipynb). It's very easy to use and all libraries are already installed on it.
It'll run online and it's requires internet connection.

If you don't have internet connection then you should install Python or Jupyter notebook and follow the below instruction.
You will also need to have software installed to run and execute a [Jupyter Notebook](http://ipython.org/notebook.html)

If you do not have Python installed yet, it is highly recommended that you install the [Anaconda](http://continuum.io/downloads) distribution of Python, which already has the above packages and more included. Make sure that you select the Python 3 installer and also for the Python 3.x installer.

## To clone the repository for improve score

For this practice , you can find the `src` folder containing the necessary project files on the [MachineLearningProject](https://github.com/ramjan-raeen/MachineLearningProject), under the `MachineLearningProject` folder. You may clone for optimization of accuracy!

This project contains three files:

`finding_donners`
- `01_finding_donors.ipynb`: This is the main file where you will be performing your work on the project.
- `census.csv`: The project dataset. You'll load this data in the notebook.
- `visuals.py`: A Python file containing visualization code that is run behind-the-scenes. Do not modify.

`House_Price`
- `02_HousePrice.ipynb`: This is main notebook file to edit the for improve score.
- `datasets/kc_house_data.csv.zip` Under datasets for you'll get dataset which is used for the House sales predictions.

After clone this project(upload to your google grive), navigate to `01_finding_doners.ipynb` open with `colab` and edit for optimization or improve score.

- For offline

In the Terminal or Command Prompt, navigate to the folder containing the project files, and then use the command `jupyter notebook 01_finding_donors.ipynb` to open up a browser window or tab to work with your notebook. Alternatively, you can use the command `jupyter notebook` or `ipython notebook` and navigate to the notebook file in the browser window that opens. Follow the instructions in the notebook and answer each question presented to successfully complete the project. A **README** file has also been provided with the project files which may contain additional necessary information or instruction for the project.

...














































