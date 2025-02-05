#!/bin/bash

### section 1 - SLURM params

#SBATCH --partition=intelsr_short  # cluster specific / intelr_short
#SBATCH --ntasks-per-node 1 # max tasks per node
#SBATCH --cpus-per-task 1 # number of cores per task

#SBATCH --nodes 1  # number of nodes

#SBATCH --mem=200MB                # max mem requested, per node
### Maximum requested time (days-hrs:min:sec)
#SBATCH --time 0-00:45:00 #estimated runtime max

#SBATCH --job-name marvin_test_slurm  # Job name
### #SBATCH --mail-type=ALL   # notifications for job done & fail
### #SBATCH --mail-user=adev@astro.uni-bonn.de #user email for updates
#SBATCH --output ./logs/%j.out   # stdout file (overwrite)
#SBATCH --error ./logs/%j.err     # stdout file (overwrite)



echo "Starting time printing job at $(date)"

for ((i=0; i<50; i++)); do
    echo "Current time: $(date)"
    sleep 120  # Sleep for 2 minutes
done

echo "Job completed at $(date)"

