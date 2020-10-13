The R script aims at reading a set of training and test data from a group of text files; merging them and then creating a new tidy dataset of means by subject and activity and then creating a text output of the tidy dataset

Step 1: Here we read all the relevant files and create the various dataframes:
1. subj_train is a dateframe that has the list of all the subject on whom the test was carried out
2. subj_test is a similar dateframe as above but contains the subjects in the test set of data
3. x_train is the main dataframe that has the list of all the variables measured. This dataframe pertains to the training part of the data
4. x_test is the main dataframe that has the list of all the variables measured but pertains to the test part of the data
5. y_train/y_test has the activities performed. There are 6 activities. train/test pertain to the training andtesting data respectively.
6. act_labels is the dataframe that has the description of the above activities
7. features contains the names of all the variables measured in the xtrain/xtest dataframe

Step 2: In this we are adding headers to the dataframes where needed. For instance the features dataframe is used to add the names to the variables in the x_train/x_test datasets. Similarly, a subject heading is added to the subj_train and subj_test dataset. The column names are necessary for the subsequent operations

Step 3: In step 3 we are creating a complete training and test data set by combining the variables in the x_train/x_test data set with the subjects and the activities. After that we are merging the train test datasets into one, called "merged_data"

Step 4: Here we are creating a new dataframe - merged_mstd - with only the relevant variables that measure the standard deviations or means. We are also retaining the subject and activity columns

Step 5: Here we are adding a new column call traindescription of the activities. This is done by using the act_lables dataframe that has the activity id and the description. This merged dataframe has the activity ids. So the activity id is the common column that is used to add the activity description to the appropriate rows. The resulting dataframe is "merged"

Step 6: Here we are doing several activities. We are first getting a subset with only the variable columns (all but the subject and traindescription). This is var_columns dataframe. We use it in a melt of the merged dataframe, which results in "merged_melt". After that we are creating the "final" dataframe by dcasting and applying mean to all variable columns based on the id columns of subject and traindescription.

Step 7 : We are creating a text version of the final dataframe
