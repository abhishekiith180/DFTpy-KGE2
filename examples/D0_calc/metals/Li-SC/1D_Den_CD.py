from dftpy.formats import io

import matplotlib.pyplot as plt

rho_KS = io.read_density('den.Li-SC.KS-lda.xsf')
rho_TFvW = io.read_density('den.Li-SC.KS.xsf')
rho_WT = io.read_density('den.Li-SC.WT.xsf')
rho_JGM = io.read_density('den.Li-SC.JGM.xsf')
rho_KGAP = io.read_density('den.Li-SC.KGAP.xsf')
#rho_xue = io.read_density('plot_si_cd/den.xsf')
rho_SM = io.read_density('den.Li-SC.SM.xsf')
rho_HC = io.read_density('den.Li-SC.HC.xsf')
rho_try02 = io.read_density('den.Li-SC.try02.xsf')
rho_PG = io.read_density('den.Li-SC.PG.xsf')


###############################################################################
lineKS = rho_KS.get_cut([1,1,1], origin=[0,0,0], nr=100).ravel()
lineTFvW = rho_TFvW.get_cut([1,1,1], origin=[0,0,0], nr=100).ravel()
lineWT = rho_WT.get_cut([1,1,1], origin=[0,0,0], nr=100).ravel()

lineKGAP = rho_KGAP.get_cut([1,1,1], origin=[0,0,0], nr=100).ravel()
lineJGM = rho_JGM.get_cut([1,1,1], origin=[0,0,0], nr=100).ravel()
lineSM = rho_SM.get_cut([1,1,1], origin=[0,0,0], nr=100).ravel()
lineHC = rho_HC.get_cut([1,1,1], origin=[0,0,0], nr=100).ravel()
linetry02 = rho_HC.get_cut([1,1,1], origin=[0,0,0], nr=100).ravel()
linePG = rho_HC.get_cut([1,1,1], origin=[0,0,0], nr=100).ravel()

###############################################################################
#print(lineMGP)
#print(line)
plt.plot(lineKS,label='KS')
plt.plot(lineTFvW,label='TFvW')
plt.plot(lineWT,label='WT')
plt.plot(lineJGM,label='JGM')
plt.plot(lineKGAP,label='KGAP')
plt.plot(lineSM,label='SM')
plt.plot(lineHC,label='HC')
plt.plot(linetry02,'.',label='try02')
plt.plot(linePG,label='PG')


###############################################################################

plt.xlabel('[111] direction', fontsize=20, fontweight='bold')
plt.title('Density plotting of Si-CD', fontsize=20, fontweight='bold')
plt.ylabel('Electron Density', fontsize=20, fontweight='bold',labelpad=25)
plt.legend(fontsize=10, loc='best')

plt.legend()
plt.show()

