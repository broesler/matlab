%% path test script a
% matlabrc;   % reset matlab to original startup state
% original_path = path;

version = 'a'; % 'b'

if strcmp(version,'a')
    func_path = genpath('./dir_a');
    addpath(func_path);
elseif strcmp(version,'b')
    func_path = genpath('./dir_b');
    addpath(func_path);
end

c = test_func(7)

% return to original path
% path(original_path);


%% path test script b
version = 'b'; % 'b'

if strcmp(version,'a')
    func_path = genpath('./dir_a');
    addpath(func_path);
elseif strcmp(version,'b')
    func_path = genpath('./dir_b');
    addpath(func_path);
end

c = test_func(7)
