from bound_params import *
load("bounds.sage")


lac = [LAC, LAC_Li_params]
hope = [NewHope, Hope_Li_params]
for task, params in [lac, hope]:
    n, q, k = map(Integer, task)
    print(n, q, k)
    python_R(n, get_R_Li)
    print()
