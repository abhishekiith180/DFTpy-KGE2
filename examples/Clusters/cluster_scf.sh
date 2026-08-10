#!/bin/bash 
# "Si" "AlAs" "AlP" "AlSb" "GaAs" "GaP" "GaSb" "InAs" "InP" "InSb"
#"Si8" "Ga4As4" "Li8" "In4P4" "Al4Sb4" "Ga25As25" "Mg8" "Mg50" "Mg30" "Si30" "Li30"

for m in "Mg8" "Mg50" "Si1" "Si30" "GaAs8" 
do
#mkdir $m
#cd $m/

#rm *.out
#for Eg in `seq -w 0.0 0.2 10`
#do
echo "calculating for $m" 

rm -rf 2.* 3.* 4.* 5.* 6.* 7.* 8.* 9.* 10.* 11.* 12.* 13.* 14.* 15.* 16.* 17.* 18.* 19.* 

rm -rf EvsA EvsV EOS.in bulk_dat aENERGY_VOLUME_DFT.dat ENERGY_VOLUME_FIT.dat ENTHALPY_VOLUME_FIT.dat PRESSURE_VOLUME_DFT.dat PRESSURE_VOLUME_FIT.dat

# Check the first two letters of the string
if [[ "${m:0:2}" == "Si" ]]; then
    pot="si.lda.recpot"
    pot1=";"
elif [[ "${m:0:2}" == "Mg" ]]; then
    pot="mg.lda.recpot"
    pot1=";"
elif [[ "${m:0:2}" == "Ga" ]]; then
    pot="ga.lda.recpot"
    pot1="As = as.lda.recpot"
else
    echo "Unrecognized element"
    exit 1
fi

cat <<EOF >temp.ini

[JOB]
task = Optdensity

[PATH]
pppath = ../DATA/ 
cellpath = .

[MATH]
linearie = T
linearii = T

[PP]
${m:0:2}=$pot  
$pot1

[CELL]
cellfile = $m.pava.vasp
elename = $m

[GRID]
ecut = 1200

#[DENSITY]
#densityoutput = den.$m.xsf

[EXC]
xc = LDA

[KEDF]
;kedf = x_TF_y_vW
;kedf = GGA_PG_INT
kedf = KGE2
;x = 1.0
;y = 1.0
;gap = 0.01
params = 1.481 1.0
;alpha = 5/6
;beta  = 5/6
;lumpfactor = 0 0

[OPT]
;method = TN
;method = CG-HS
;method = LBFGS
;algorithm = EMM
algorithm = OESCF
maxiter = 200
maxfun = 50
econv = 1e-6
EOF

cat temp.ini > dftpy.ini
dftpy dftpy.ini > dftpy.$m.out

#done

#done # ends zeta loop

#cd ../
done #ends material loop
