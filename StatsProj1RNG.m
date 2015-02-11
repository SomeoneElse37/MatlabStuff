% Ok, so here goes: Each person will need to throw a basketball, a
% volleyball, and a soccer ball (or whatever types of balls we end up
% using) ten times in a row, and record how many shots we make. This will
% be repeated for each ball, for each of two different distances, and four
% more times for each combination of ball and distance. Each person is
% going to be doing all this at the same time, and since we're only using
% three balls, I'll need to make sure that no two people are using the same
% ball at the same time. Finally, the order in which things are done must
% be as random as possible.

% Ok, so, recap: 
% Each person (of three) must shoot ten shots with each of three balls, at 
% two distances, four times over. So 24 sets of shots per person.
% And they can't share balls.

clear

%% Constants

PEOPLE = {'Aaron' 'Matt' 'Joshua'};
BALLS = {'Volley     ' 'Basketball ' 'Soccer Ball'};
DISTANCES = {'free' ' 3pt'};
REPLICATES = 4;

numRuns = length(BALLS) * length(DISTANCES) * REPLICATES;   % 24
ballOrders = perms(BALLS);

%% Create list of who's shooting what ball when

allBallOrders = [];
for i = randperm(numRuns)
    allBallOrders = [allBallOrders; ballOrders(rem(i, 6) + 1, :)];
end

%% Create List of Distances
% Do this in such a way as to ensure that each person shoots each ball at
% each distance exactly four (*10) times.

% For each person
    % for each ball type
        % find the times when that person is shooting that ball
        % say they're shooting free-throws half of those times
        % and three-pointers for the rest

allDistances = cell(size(allBallOrders));
for p = 1:length(PEOPLE)
    for b = 1:length(BALLS)
        c = 0;
        indices = find(strcmp(allBallOrders(:, p), BALLS(b)));
        for i = randperm(length(indices))
            allDistances(indices(i), p) = DISTANCES(rem(c, length(DISTANCES)) + 1);
            c = c + 1;
        end
    end
end

%% Combine and Print the Lists

allData = strcat(allBallOrders, {'  '}, allDistances);
disp(['Run', PEOPLE; num2cell((1:numRuns)'), allData])





