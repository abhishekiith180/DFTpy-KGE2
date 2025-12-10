#!/bin/bash 
# "Si" "AlAs" "AlP" "AlSb" "GaAs" "GaP" "GaSb" "InAs" "InP" "InSb"

for m in "AlAs" "AlP" "AlSb" "GaAs" "GaP" "GaSb" "InAs" "InP" "InSb" 
do
cd $m/

#for Eg in `seq -w 0.0 0.2 10`
#do
echo "calculating for $m" 

rm -rf 2.* 3.* 4.* 5.* 6.* 7.* 8.* 9.* 10.* 11.* 12.* 13.* 14.* 15.* 16.* 17.* 18.* 19.* 

rm -rf EvsA EvsV EOS.in bulk_dat aENERGY_VOLUME_DFT.dat ENERGY_VOLUME_FIT.dat ENTHALPY_VOLUME_FIT.dat PRESSURE_VOLUME_DFT.dat PRESSURE_VOLUME_FIT.dat

natoms=8

# setting the lattice constant

# Check conditions using multiple if-else statements
if [ "$m" == "Si" ]; then
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
    echo "Something is wrong"
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
cat <<EOF >$m.vasp
$m
1.0
    $lattice  0.000000  0.000000
    0.000000  $lattice  0.000000
    0.000000  0.000000  $lattice
${elements[@]}
4  4
Direct
  0.000000000         0.000000000         0.000000000
  0.000000000         0.500000000         0.500000000
  0.500000000         0.000000000         0.500000000
  0.500000000         0.500000000         0.000000000
  0.250000000         0.250000000         0.750000000
  0.750000000         0.750000000         0.750000000
  0.750000000         0.250000000         0.250000000
  0.250000000         0.750000000         0.250000000
EOF


#cp config.ini $A/dftpy.ini
#echo $A $Z >>a.txt

cat <<EOF >dftpy.ini
[JOB]
task = Optdensity
;task = Calculation
;calctype = Both Force Stress

[PATH]
pppath = ../../DATA/
cellpath = .

[MATH]
linearie = T
linearii = T
;twostep = T

[PP]
${elements[0]} = ${elements[0],,}.lda.recpot     
${elements[1]} = ${elements[1],,}.lda.recpot

[CELL]
cellfile = $m.vasp
elename = ${elements[@]}
zval = 3.0 5.0
format = vasp

[GRID]
;ecut = 1200
nr = 30 30 30

[DENSITY]
densityoutput = den.$m.PGS.lda.xsf

[EXC]
xc = LDA

[KEDF]
kedf = GGA_PG
params = 1.48 1.0

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


dftpy dftpy.ini > dftpy.out
#rm -v !("den.*")
#done
cd ../
done #ends material loop
