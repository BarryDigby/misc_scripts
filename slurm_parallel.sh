#mainly interested in the body of that for loop. parallel.sh needs to capture input flags chr=$1
#both this and parallel do not need slurm headers, defined in this script already.


for chr in "${list[@]}"; do

        var1=$(echo "$chr")

        sbatch -p normal -N 1 -n 4 -o logs/%j.out -e logs/%j.err --job-name "$chr" --wrap="sh parallel.sh $var1"

        sleep 1

done
