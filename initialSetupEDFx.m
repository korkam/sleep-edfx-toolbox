function initialSetupEDFx(download_dir)
%initialSetupEDFx Convenience function to download all EDF and related data
%   initialSetupEDFx(destination_dir) downloads EDF data and annotations in
%   the destination directory, converts the data to Matlab file formats and
%   extractions the hypnogram from the annotations file




% Download EDFx Data
[saved_file, status] = downloadEDFxData(download_dir);

%DEBUG REPORT
%disp('DR: Completed: downloadEDFxData'); pause;

% Download hypnogram + annotations
downloadEDFxAnnotations(download_dir);

%DEBUG REPORT
%disp('DR: Completed: downloadEDFxAnnotations'); pause;

% Convert EDFx Data To Matlab Format
for i=1:length(saved_file)
    convertEDFxToMat(saved_file{i}, status{i});
end

%DEBUG REPORT
%disp('DR: Completed: convertEDFxToMat'); pause;

% Process hypnogram/annotations
for i=1:length(saved_file)
    [test_dir,file_name,~] = fileparts(saved_file{i});
    hyp_file = fullfile(test_dir, 'info', [file_name(1:end-4) '.txt']);
    hypnogram = processEDFxHypnogram( hyp_file );
    % Save hypnogram
    hypnogram_path = fullfile(test_dir, 'matlab', 'hypnogram.mat');
    save(hypnogram_path, 'hypnogram')
end


%DEBUG REPORT
%disp('DR: Completed: processEDFxHypnogram'); pause;

end