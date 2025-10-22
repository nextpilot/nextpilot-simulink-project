
function s = signNoZero(val)
% Type-safe signum function with zero treated as positive

s = ((0) <= val) - (val < (0));
