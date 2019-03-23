%     num_trees = 50;
%     % data is the data matrix with row being an observation and column % represents a feature, class is class label
%     random_forest_model = TreeBagger(num_trees, data, class);

TreeObject=TreeBagger(50,TrainData,class,'method ','classification','NVarToSample','all');
[YFIT,scores] = predict(TreeObject,TestVector)