function q = normalize(q)

q.data = q.data / sqrt(dot(q.data, q.data));