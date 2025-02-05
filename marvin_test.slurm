#!/bin/bash

### section 1 - SLURM params

### #SBATCH --account=ag_aifa_bertoldi
#SBATCH --partition=intelsr_devel  # cluster specific / intelr_short
### https://wiki.hpc.uni-bonn.de/en/running_jobs
### #SBATCH --ntasks 4      # number of procs to start
### or
#SBATCH --ntasks-per-node 4 # max tasks per node
#SBATCH --cpus-per-task 2 # number of cores per task

#SBATCH --nodes 1  # number of nodes

### #ntasks = #nodes x #tasks-per-node
### #ncores_total = #ntasks x #cpus-per-task
### #ncores_total_pernode = #ntasks-per-node x #cpus-per-task

#SBATCH --mem-per-cpu=200MB # mem per proc
### #SBATCH --mem=1G                # max mem requested, per node
### Maximum requested time (days-hrs:min:sec)
#SBATCH --time 0-00:05:00 #estimated runtime max

#SBATCH --job-name marvin_test_slurm  # Job name
### #SBATCH --mail-type=ALL   # notifications for job done & fail
### #SBATCH --mail-user=adev@astro.uni-bonn.de #user email for updates
#SBATCH --output ./logs/%j.out   # stdout file (overwrite)
#SBATCH --error ./logs/%j.err     # stdout file (overwrite)

##################################
### REDUNDANT
### section 2 - Runtime env set-up
### module purge
### load all modules needed for Job
###module load GCC/13.2.0
###module load OpenMPI/4.1.6-GCC-13.2.0
###module load Anaconda3
######conda init bash
###source /opt/software/easybuild-INTEL/software/Anaconda3/2022.05/etc/profile.d/conda.sh
###conda deactivate
###conda activate toast3
###### module list # list for debugging
###### export paths
###export LD_LIBRARY_PATH=/opt/software/easybuild-INTEL/software/GCCcore/13.2.0/lib64:$LD_LIBRARY_PATH
###### Ensure the HPC OpenMPI path is exported
###export PATH=/opt/software/easybuild-INTEL/software/OpenMPI/4.1.6-GCC-13.2.0/bin:$PATH
######export LD_LIBRARY_PATH=/opt/software/easybuild-INTEL/software/OpenMPI/4.1.6-GCC-13.2.0/lib64:$LD_LIBRARY_PATH
###### Exporting mpi4py path
###export PYTHONPATH=/opt/software/easybuild-INTEL/software/mpi4py/3.1.4-gompi-2023a/lib64/python3.11/site-packages:$PYTHONPATH
##################################

### section 2 - Runtime env set-up
module purge
### load all modules needed for Job
module load mpi4py
### initiate conda
### source /opt/software/easybuild-INTEL/software/Anaconda3/2022.05/etc/profile.d/conda.sh
source /opt/software/easybuild-INTEL/software/Miniforge3/24.1.2-0/etc/profile.d/conda.sh
conda deactivate
###conda activate toast3
conda activate mlmap
echo "$(module list)"

### section 3 - Job Logging
echo ""
echo "*************"
echo "Running Job..."
echo "Starting at `date`"
echo "Hostname $HOSTNAME"
echo "Job Name: $SLURM_JOB_NAME"
echo "Job ID: $SLURM_JOB_ID"
echo "Node List: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running on $SLURM_NPROCS processors."
echo "Slurm Ntasks: $SLURM_NTASKS"
echo "Number of Tasks per Node: $SLURM_NTASKS_PER_NODE"
echo "Number of CPUs per Task: $SLURM_CPUS_PER_TASK"
echo "Cores per Node: $SLURM_CPUS_ON_NODE"
echo "Total Number of Nodes: $SLURM_JOB_NUM_NODES"
echo "Current working directory is `pwd`"
echo "Python path: $(which python)"
echo "Using MPI lib: $(which mpirun)"
echo "Using GCC lib: $(which gcc)"
echo ""

### section 4 - Job Run
echo "***** EXEC SCRIPT *****"
echo `date '+%F %H:%M:%S'`
echo "***********************"
echo ""
###python3 matplotlib_test.py
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
mpirun -np $SLURM_NTASKS python3 mpi_matplotlib_test.py

echo ""
echo "******** DONE *********"
echo `date '+%F %H:%M:%S'`
echo "***********************"
echo ""
