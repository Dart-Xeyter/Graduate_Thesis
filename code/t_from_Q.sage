from ECC_params import *
load("errors.sage")


for n, q, k in [LAC, NewHope]:
    errors = []
    plus = lambda x, y: (x+y) % q
    minus = lambda x, y: (x-y) % q
    mul = lambda x, y: (x*y) % q
    chi = chi_distrib(q, k)
    noise = noise_distrib(chi, n)
    print("Noise:", sum(noise))
    err_f, DFR_f = err_prob_Li, get_DFR_Li
    python_t(noise, n, q, Qs, err_f, DFR_f)
    print(*errors, sep='\n')
    print('\n')
