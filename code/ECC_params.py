def get_t(err, N, get_DFR):
    ERR = ["10**-6"]
    ans = []
    for dfr in ERR:
        dfr = eval(dfr)
        l, r = -1, N+1
        while r-l > 1:
            t = (l+r)//2
            DFR = get_DFR(err, N, t)
            if DFR < dfr:
                r = t
            else:
                l = t
        ans.append(r)
    return ERR, ans


def python_t(noise, n, q, Qs, err_f, DFR_f):
    print("params = {")
    for Q in Qs:
        err = err_f(noise, q, Q)
        ERR, T = get_t(err, n, DFR_f)
        print(f"    {Q}: {{{repr(ERR[0])}: {T[0]}}},")
    print("}")


def latex_t(noise, n, q, Qs, err_f, DFR_f):
    print("\\begin{table}[h]\n\\centering")
    print("\\begin{minipage}{0.48\\textwidth}")
    print("\\centering\n\\begin{tabular}{|c|c|c|}")
    print("\\hline Q & t & err \\\\ \\hline")
    for Q in Qs:
        err = err_f(noise, q, Q)
        ERR, T = get_t(err, n, DFR_f)
        print(f"{Q} & {T[0]} & {err:.4f} \\\\ \\hline")
    print("\\end{tabular}\n\\end{minipage}\n\\end{table}")
