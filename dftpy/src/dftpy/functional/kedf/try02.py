import numpy as np
from typing import Set

from dftpy.functional.kedf.vw import vW
from dftpy.functional.kedf.gga import GGA
from dftpy.constants import C_TF, TKF0
from dftpy.math_utils import PowerInt
from dftpy.functional.functional_output import FunctionalOutput
from dftpy.field import DirectField
from dftpy.time_data import timer

@timer()
def TRY02(rho: DirectField, calcType: Set[str] = {'E','V'}, params = None, y: float = 1.0, **kwargs) -> FunctionalOutput:
    '''
    try02 functional
    Parameters
    ----------
    rho
    calcType
    params
    y
    kwargs

    Returns
    -------

    '''
    kwargs.pop('functional', None)
    OutFunctional = GGA(rho, functional='TRY02-VW', calcType=calcType, params=params, **kwargs)
    OutFunctional += vW(rho, y=y, calcType=calcType, **kwargs)
    OutFunctional.name = 'TRY02'
    return OutFunctional
