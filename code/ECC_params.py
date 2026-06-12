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
        _, errs = err_f(noise, n, q, Q)
        ERR, T = get_t(errs, n, DFR_f)
        print(f"    {Q}: {{{repr(ERR[0])}: {T[0]}}},")
    print("}")


def latex_t(noise, n, q, Qs, err_f, DFR_f):
    print("\\begin{table}[h]\n\\centering")
    print("\\begin{minipage}{0.48\\textwidth}")
    print("\\centering\n\\begin{tabular}{|c|c|c|}")
    print("\\hline Q & t & err \\\\ \\hline")
    for Q in Qs:
        err, errs = err_f(noise, n, q, Q)
        ERR, T = get_t(errs, n, DFR_f)
        # print(f"{Q} & {T[0]} & {err:.4f} \\\\ \\hline")
        err += [] if len(err) == 3 else [0]
        print(f"{Q} & {T[0]} & {err[1]:.4f} & {err[2]:.2e} \\\\ \\hline")
    print("\\end{tabular}\n\\end{minipage}\n\\end{table}")
