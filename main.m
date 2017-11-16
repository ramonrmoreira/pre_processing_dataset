# pre_processing_dataset
clear all
close all
clc
%%
files_path_in = {'inputpath'}
files_path_out = {'outputpath'}
%%

for i = 1:numel(files_path_in)
    files = dir([files_path_in{i},'*.mov'])
    for j = 1:numel(files)
        j
        [pathstr, name, ext] = fileparts(files(j).name);
        name
        video_file = [files_path_in{i}, name, '.mov'];
        if ~exist(strcat(files_path_out{i},name),'dir')
            Faces = Extract_faces(video_file);
            if Faces.flag >= 35
                mkdir(strcat(files_path_out{i},name))
                for a = 1:size(Faces.data,2)
                    h = size(Faces.data{a});
		                if h(1) > 0
                        imwrite(Faces.data{a},strcat(files_path_out{i},name,'\',num2str(a),'.jpg'));
                    end
                end
            end
        end
    end
end
