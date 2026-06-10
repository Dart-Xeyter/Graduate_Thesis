from sage.all import *
from scipy.stats import binom
from scipy.signal import fftconvolve

LAC = [1024, 251, 1]
NewHope = [1024, 12289, 8]
Qs = list(range(2, 10))+list(range(10, 21, 2))+[23, 26, 30, 34, 38]


def conv_distrib(a, b):
    c = fftconvolve(a, b)
    ans = [0]*len(a)
    for q in range(len(c)):
        ans[q % len(a)] += c[q]
    return ans


def comp_distrib(a, b, op):
    inds_a = [(q, x) for q, x in enumerate(a) if x != 0]
    inds_b = [(q, x) for q, x in enumerate(b) if x != 0]
    res = [0]*len(a)
    for q1, x in inds_a:
        for q2, y in inds_b:
            res[op(q1, q2)] += x*y
    return res


def pow_distrib(a, n):
    if n == 0:
        return [1]+[0]*(len(a)-1)
    if n % 2 == 0:
        a_2 = conv_distrib(a, a)
        return pow_distrib(a_2, n//2)
    res = pow_distrib(a, n-1)
    return conv_distrib(res, a)


def chi_distrib(q, k):
    Bin = [binom.pmf(q1, k, 0.5) for q1 in range(k+1)]
    Bin += [0]*(q-k-1)
    return comp_distrib(Bin, Bin, minus)


def noise_distrib(chi, n):
    ksi = comp_distrib(chi, chi, mul)
    ksi_pow = pow_distrib(ksi, 2*n)
    return comp_distrib(ksi_pow, chi, plus)
