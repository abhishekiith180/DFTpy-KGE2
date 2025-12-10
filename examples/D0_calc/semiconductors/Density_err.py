#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 27 20:00:34 2024

@author: edft
"""

from dftpy.formats import io
import shutil, os
import numpy as np
import matplotlib.pyplot as plt

# "Si","AlAs","AlP","AlSb","GaAs","GaP","GaSb","InAs","InP","InSb"
materials = ["AlAs","AlP","AlSb","GaAs","GaP","GaSb","InAs","InP","InSb"]
functionals = ["KS","WT","HC","PGS.lda","KGE2.lda","LKT.lda"]

# =============================================================================
# nSi = 8*14
# nAlAs=4*13+4*33; nAlP=4*12+4*15; nAlSb=4*13+4*51; nGaAs=31*4+33*4; nGaP=31*4+15*4
# nGaSb=4*31+4*51; nInAs=4*49+4*33; nInP=4*49+4*15; InSb=4*49+4*51
# Ne = {"Si":nSi,"AlAs":nAlAs,"AlP":nAlP,"AlSb":nAlP,"GaAs":nGaAs,"GaP":nGaP,"GaSb":nGaP,"InAs":nInAs,"InP":nInP,"InSb":{nInP}}
# =============================================================================
Ne = {"Si":112,"AlAs":184,"AlP":108,"AlSb":256,
      "GaAs":256,"GaP":184,"GaSb":328
      ,"InAs":328,"InP":256,"InSb":400}


rho = {m : {fun:{} for fun in functionals} for m in materials}
drho = {m : {fun:{} for fun in functionals} for m in materials}
D0_err = {m : {fun:{} for fun in functionals} for m in materials}

i=0
for m in materials:
    for fun in functionals:
        rho[m][fun] = io.read_density(f'{m}/den.{m}.{fun}.xsf')
        drho[m][fun] = np.abs( rho[m]["KS"]-rho[m][fun] )
        D0_err[m][fun] = sum(sum(sum(drho[m][fun]))) / sum(sum(sum(rho[m]["KS"]))) *100 #/ list(Ne.values())[i]
    i+=1


for m in materials:
    print("D0 "+m ,D0_err[m])


avD0 = {fun:{} for fun in functionals}

i=0; s=0
for fun in functionals:
    s=0
    for m in materials:
        s += list(D0_err[m].values())[i]
    avD0[fun] = s / len(materials) 
    i+=1
print(avD0)
