from mapping import max_changes
load("noise.sage")


def fft_pow(a, n):
    if n == 0:
        return [1]
    if n % 2 == 0:
        a_2 = fftconvolve(a, a)
        return fft_pow(a_2, n//2)
    res = fft_pow(a, n-1)
    return fftconvolve(res, a)


def err_prob_Ham(noise, q, Q):
    ch = max_changes(Q, q)
    err = 1
    for q1 in range(q):
        err -= noise[q1]*(ch[q1] == 0)
    errors.append(err)
    return err


def get_DFR_Ham(err, n, t):
    pr = 0
    for q1 in range(t+1, n+1):
        pr += binom.pmf(q1, n, err)
    return pr


def err_prob_Li(noise, q, Q):
    ch = max_changes(Q, q)
    errs = [0]*Q
    for q1 in range(q):
        errs[ch[q1]] += noise[q1]
    errors.append(errs[:3])
    return errs


def get_DFR_Li(errs, n, t):
    err = fft_pow(errs, n)
    return sum(err[t+1:])
