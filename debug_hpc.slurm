#!/bin/bash

### section 1 - SLURM params

### Marvin
###SBATCH --partition=intelsr_short    # marvin / intelr_short

### Ramses
#SBATCH --partition=mpi    # ramses / mpi(mpi+multi-node), smp(no_mpi+single-node), bigsmp(big-mem)
#SBATCH --account=ag-riechers # For Ramses

#SBATCH --ntasks-per-node 2 # max tasks per node
#SBATCH --cpus-per-task 4 # number of cores per task

#SBATCH --nodes 1  # number of nodes

#SBATCH --mem=200MB                # max mem requested, per node
### Maximum requested time (days-hrs:min:sec)
#SBATCH --time 0-00:15:00 #estimated runtime max

#SBATCH --job-name hpc_test_slurm  # Job name

#SBATCH --mail-type=FAIL,TIME_LIMIT   # notifications for job done & fail
###SBATCH --mail-user=adev@astro.uni-bonn.de #uni-bonn email for updates
#SBATCH --mail-user=adev@uni-koeln.de  #uni-koeln email for updates
#SBATCH --output ./logs/%j.out   # stdout file (overwrite)
#SBATCH --error ./logs/%j.err     # stdout file (overwrite)



echo "Starting time printing job at $(date)"

for ((i=0; i<50; i++)); do
    echo "Current time: $(date)"
    sleep 120  # Sleep for 2 minutes
done

echo "Job completed at $(date)"

