clear,clc, close all
datapath='E:\Dataset\';
imds=imageDatastore('E:\Dataset\',  'IncludeSubfolders',true, 'LabelSource','foldernames');
total_split=countEachLabel(imds)
[imdsTrain,imdsTest] = splitEachLabel(imds,.7,'randomized');
numClasses = numel(categories(imdsTrain.Labels))


load('vggmodel_16.mat')
% plot(mobnet_Transfer)

vggmodel_16.Layers(1)
vggmodel_16.Layers(end)
% Number of class names for ImageNet classification task
imageSize = vggmodel_16.Layers(1).InputSize;
augmentedTrainingSet = augmentedImageDatastore(imageSize, imdsTrain, 'ColorPreprocessing', 'gray2rgb');
augmentedTestSet = augmentedImageDatastore(imageSize, imdsTest, 'ColorPreprocessing', 'gray2rgb');

featureLayer = 'fc7';

trainingFeatures = activations(vggmodel_16, augmentedTrainingSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
trainingLabels = imdsTrain.Labels;

classifier = fitcecoc(trainingFeatures, trainingLabels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns')

testFeatures = activations(vggmodel_16, augmentedTestSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
predictedLabels = predict(classifier, testFeatures, 'ObservationsIn', 'columns');
testLabels = imdsTest.Labels;
% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);
% Convert confusion matrix into percentage form
confMat = bsxfun(@rdivide,confMat,sum(confMat,2))
mean(diag(confMat))

