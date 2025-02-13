clc; clear all; close all;

% User input for probabilities
probabilities = input('Enter the probabilities as a row vector (e.g., [0.4, 0.2, 0.2, 0.1, 0.1]): ');

% Validate that probabilities sum to 1
if abs(sum(probabilities) - 1) > 1e-6
    error('The probabilities must sum to 1.');
end

% User input for M
M = input('Enter the value of M (e.g., 2 for binary encoding, 3 for ternary encoding): ');

% Validate M
if M < 2 || mod(M, 1) ~= 0
    error('M must be an integer greater than or equal to 2.');
end

% Sort probabilities in descending order
[sorted_probs, indices] = sort(probabilities, 'descend');
symbols = 1:length(probabilities);
symbols = symbols(indices);

% Initialize variables for encoding
codes = cell(1, length(probabilities));

% Generate M-ary symbols
if M == 2
    m_symbols = [0, 1];
elseif M == 3
    m_symbols = [-1, 0, 1];
else
    m_symbols = 0:(M-1);
end

% Start encoding
stack = {{sorted_probs, symbols, []}};

while ~isempty(stack)
    node = stack{end};
    stack(end) = [];

    probs = node{1};
    syms = node{2};
    code_prefix = node{3};

    if length(probs) == 1
        codes{syms(1)} = code_prefix;
        continue;
    end

    % Split probabilities into M groups (balanced groups)
    total = sum(probs);
    cumulative = cumsum(probs);
    groups = cell(1, M);
    group_syms = cell(1, M);

    % Define splitting logic for balanced grouping
    split_points = zeros(1, M-1);
    for i = 1:M-1
        % Find the split point where the group is most balanced
        [~, split_idx] = min(abs(cumulative - total * i / M));
        split_points(i) = split_idx;
    end

    % Assign probabilities and symbols to groups
    start_idx = 1;
    for i = 1:M
        if i == 1
            groups{i} = probs(start_idx:split_points(i));
            group_syms{i} = syms(start_idx:split_points(i));
        elseif i == M
            groups{i} = probs(split_points(i-1)+1:end);
            group_syms{i} = syms(split_points(i-1)+1:end);
        else
            groups{i} = probs(split_points(i-1)+1:split_points(i));
            group_syms{i} = syms(split_points(i-1)+1:split_points(i));
        end
    end

    % Push groups back to stack
    for i = M:-1:1
        if ~isempty(groups{i})
            stack{end + 1} = {groups{i}, group_syms{i}, [code_prefix, m_symbols(i)]};
        end
    end
end

% Display results
fprintf('Symbol\tProbability\tCode\n');
for i = 1:length(symbols)
    fprintf('%d\t%.4f\t\t%s\n', indices(i), probabilities(indices(i)), mat2str(codes{indices(i)}));
end
