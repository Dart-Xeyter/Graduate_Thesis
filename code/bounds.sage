from sage.all import *
from sage import coding


def get_R_Ham(n, Q, t):
    d = 2*t+1
    RF = RealField(100)
    M_down = codes.bounds.gilbert_lower_bound(n, Q, d)
    M_up = codes.bounds.hamming_upper_bound(n, Q, d)
    M_down, M_up = ceil(M_down), floor(M_up)
    R_down, R_up = log(RF(M_down), 2)/n, log(RF(M_up), 2)/n
    return float(R_down), float(R_up)


def get_R_Li(n, Q, t):
    RF = RealField(100)
    R.<x> = PolynomialRing(ZZ)
    coefs = [0]*Q
    for q1 in range(Q):
        coefs[min(q1, Q-q1)] += 1
    nums = (R(coefs)^n).list()
    V_down, V_up = sum(nums[:2*t+1]), sum(nums[:t+1])
    M_down, M_up = Q**n//V_down, Q**n//V_up
    R_down, R_up = log(RF(M_down), 2)/n, log(RF(M_up), 2)/n
    return float(R_down), float(R_up)


def python_R(n, get_R):
    for Q, pr in params.items():
        for DFR, t in pr.items():
            R_down, R_up = get_R(n, Q, t)
            print(Q, ":", t, "-", R_down, R_up)


def latex_R(n, get_R):
    print("\\begin{table}[h]\n\\centering")
    print("\\begin{minipage}{0.48\\textwidth}")
    print("\\centering\n\\begin{tabular}{|c|c|c|}")
    print("\\hline Q & $R_{GV}$ & $R_H$ \\\\ \\hline")
    for Q, pr in params.items():
        for DFR, t in pr.items():
            R_down, R_up = get_R(n, Q, t)
            print(f"{Q} & {R_down:.4f} & {R_up:.4f} \\\\ \\hline")
    print("\\end{tabular}\n\\end{minipage}\n\\end{table}")
