#!/bin/bash 
# "Si" "AlAs" "AlP" "AlSb" "GaAs" "GaP" "GaSb" "InAs" "InP" "InSb"

for m in "Al-BCC" "Al-FCC" "Al-SC" "Li-BCC" "Li-FCC" "Li-SC" "Mg-BCC" "Mg-FCC" "Mg-SC"
do
cd $m/

echo "calculating for $m" 

#mv den.$m.try02.xsf den.$m.KGE2.lda.xsf
#mv den.$m.PG.xsf den.$m.PGS.lda.xsf
#mv den.$m.LKT.xsf den.$m.LKT.lda.xsf

natoms=8

# setting the lattice constant

# Check conditions using multiple if-else statements
if [ "$m" == "Al-BCC" ]; then
    lattice=5.46
elif [ "$m" == "AlAs" ]; then
    lattice=5.733
elif [ "$m" == "AlP" ]; then
    lattice=5.507
elif [ "$m" == "AlSb" ]; then
    lattice=6.233760
elif [ "$m" == "GaAs" ]; then
    lattice=5.75
elif [ "$m" == "GaP" ]; then
    lattice=5.506300
elif [ "$m" == "GaSb" ]; then
    lattice=6.219
elif [ "$m" == "InAs" ]; then
    lattice=6.181
elif [ "$m" == "InP" ]; then
    lattice=5.956
elif [ "$m" == "InSb" ]; then
    lattice=6.633
else
    echo "for Metals"
fi

# Function to split string into substrings
split_string() {
    local input_string=$1
    local pattern='[[:upper:]][[:lower:]]*'
    local substrings=()

    while [[ $input_string =~ $pattern ]]; do
        substrings+=( "${BASH_REMATCH[0]}" )
        input_string=${input_string/${BASH_REMATCH[0]}/}
    done

    for substring in "${substrings[@]}"; do
        echo "$substring"
    done
}
#$elements[0] $elements[1]

elements=($(split_string "$m"))
echo "${elements[0]}"                  #elements is an array that contains element names

#cp config.ini $A/dftpy.ini
#echo $A $Z >>a.txt

cat <<EOF >dftpy.ini
[JOB]
task = Optdensity
;task = Calculation
;calctype = Both Force Stress

[PATH]
pppath = ../../../DATA/ 
cellpath = ../POSCARS/

[MATH]
linearie = T
linearii = T
;twostep = T

[PP]
${elements[0]} = ${elements[0],,}.lda.recpot     

[CELL]
cellfile = $m.vasp
elename = ${elements[0]}
zval = 3.0 5.0
format = vasp

[GRID]
;ecut = 1200
nr = 30 30 30

[DENSITY]
densityoutput = den.$m.KGE2.lda.xsf

[EXC]
xc = LDA

[KEDF]
;kedf = x_TF_y_vW
kedf = KGE2
;x=1.0
;y=1.0
;gap = $EgK
params = 1.481 1.0      
;alpha = 5/6
;beta  = 5/6
;alpha = $alpha
;beta = $beta
;lumpfactor = 0 0

[OPT]
;method = TN
;method = CG-HS
;method = LBFGS
;algorithm = EMM
algorithm = OESCF
;vector = Scaling
;c1 = 1e-4
;c2 = 2e-1
;maxls = 10
maxiter = 200
maxfun = 50
econv = 1e-6
;h0 = 1.0
;h0 = 0.025
EOF


dftpy dftpy.ini > dftpy.KGE2.lda.out
#rm -v !("den.*")
#done
cd ../
done #ends material loop
