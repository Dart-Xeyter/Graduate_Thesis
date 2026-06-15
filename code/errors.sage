from mapping import max_changes
load("noise.sage")


def err_prob_Ham(noise, n, q, Q):
    ch = max_changes(Q, q)
    err = 1
    for q1 in range(q):
        err -= noise[q1]*(ch[q1] == 0)
    errors.append(err)
    return err, err


def get_DFR_Ham(err, n, t):
    pr = 0
    for q1 in range(t+1, n+1):
        pr += binom.pmf(q1, n, err)
    return pr


def fft_pow(a, n):
    if n == 0:
        return [1]
    if n % 2 == 0:
        a_2 = fftconvolve(a, a)
        return fft_pow(a_2, n//2)
    res = fft_pow(a, n-1)
    return fftconvolve(res, a)


def err_prob_Li(noise, n, q, Q):
    ch = max_changes(Q, q)
    err = [0]*Q
    for q1 in range(q):
        err[ch[q1]] += noise[q1]
    errors.append(err[:3])
    errs = fft_pow(err, n)
    return err, errs


def get_DFR_Li(err, n, t):
    return sum(err[t+1:])
