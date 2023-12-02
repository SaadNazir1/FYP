imread=('E:\Dataset\');
imds = imageDatastore('E:\Dataset\', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');
imageSize = netTransfer.Layers(1).InputSize;

augmentedTrainingSet = augmentedImageDatastore(imageSize, imdsTrain, 'ColorPreprocessing', 'gray2rgb');
augmentedTestSet = augmentedImageDatastore(imageSize, imdsValidation, 'ColorPreprocessing', 'gray2rgb');

load('netTransfer.mat')
netTransfer.Layers(1)
netTransfer.Layers(end)
numel(netTransfer.Layers(end).ClassNames)

featureLayer = 'fc7';

trainingFeatures = activations(netTransfer, augmentedTrainingSet , featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');


trainingLabels = imdsTrain.Labels;
classifier = fitcecoc(trainingFeatures, trainingLabels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');

% Extract test features using the CNN
testFeatures = activations(netTransfer, augmentedTestSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

% Pass CNN image features to trained classifier
predictedLabels = predict(classifier, testFeatures, 'ObservationsIn', 'columns');

% Get the known labels
testLabels = imdsValidation.Labels;

% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);

% Convert confusion matrix into percentage form
confMat = bsxfun(@rdivide,confMat,sum(confMat,2))

mean(diag(confMat))


