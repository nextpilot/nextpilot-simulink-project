function out = selection(u1, u2, in1, in2)

if single(u1) > single(u2)
    out = in1;
else
    out = in2;
end