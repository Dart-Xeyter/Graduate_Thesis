def Maps(Q, q):
    return [s*q//Q for s in range(Q)]


def Demaps(Q, q):
    pos = Maps(Q, q)
    a = [(float('inf'), -1)]*q
    for x in range(q):
        for s in range(Q):
            l = abs(pos[s]-x)
            a[x] = min(a[x], (min(l, q-l), s))
    return [q[1] for q in a]


def max_changes(Q, q):
    pos = Maps(Q, q)
    d = Demaps(Q, q)
    ch = [0]*q
    for s in range(Q):
        for x in range(q):
            q1 = (x-pos[s]) % q
            l = abs(d[x]-s)
            ch[q1] = max(ch[q1], min(l, Q-l))
    return ch
