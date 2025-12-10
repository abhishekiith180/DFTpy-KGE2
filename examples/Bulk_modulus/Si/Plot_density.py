# Written by xuecheng

from dftpy.formats import io
import matplotlib.pyplot as plt


rho_HC = io.read_density('den.Si.HC.xsf')
#rho_HC = io.read_density('tmp.HC.xsf')

lineHC = rho_HC.get_cut([1,1,1], origin=[0,0,0], nr=100).ravel()


plt.plot(lineHC,label='original')


plt.legend()
plt.show()
