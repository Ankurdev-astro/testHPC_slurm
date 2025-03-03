#!/bin/bash

### section 1 - SLURM params

#SBATCH --partition=mpi    # ramses / mpi(mpi+multi-node), smp(no_mpi+single-node), bigsmp(big-mem)
#SBATCH --account=ag-riechers # For Ramses

###SBATCH --ntasks 4      # number of procs to start
### or
#SBATCH --ntasks-per-node 4 # max tasks per node
#SBATCH --cpus-per-task 2 # number of cores per task

#SBATCH --nodes 1  # number of nodes

### #ntasks = #nodes x #tasks-per-node
### #ncores_total = #ntasks x #cpus-per-task
### #ncores_total_pernode = #ntasks-per-node x #cpus-per-task

#SBATCH --mem=2G                # max mem requested, per node
### Maximum requested time (days-hrs:min:sec)
#SBATCH --time 0-00:05:00 #estimated runtime max

#SBATCH --job-name ramses_test_slurm  # Job name
### #SBATCH --mail-type=ALL   # notifications for job done & fail
### #SBATCH --mail-user=adev@astro.uni-bonn.de #user email for updates
#SBATCH --output ./logs/%j.out   # stdout file (overwrite)
#SBATCH --error ./logs/%j.err     # stdout file (overwrite)

### section 2 - Runtime env set-up
module purge
### load all modules needed for Job
module load lang/Miniconda3/23.9.0-0
module load lib/mpi4py/3.1.5-gompi-2023b
### initiate conda
### source /opt/software/easybuild-INTEL/software/Anaconda3/2022.05/etc/profile.d/conda.sh
### source /opt/software/easybuild-INTEL/software/Miniforge3/24.1.2-0/etc/profile.d/conda.sh
conda deactivate
###conda activate toast3
conda activate mpi-test
echo ""
echo "$(module list)"

### section 3 - Job Logging
echo ""
echo "*************"
echo "Running Job..."
echo "Starting at `date`"
echo "SLURM partition: $SLURM_JOB_PARTITION"
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
echo "Python version: $(python --version)"
echo "Using mpi4py: $(python -c 'import mpi4py; print(mpi4py.__file__)' 2>/dev/null || echo '!! mpi4py not found !!')"
echo "Using MPI lib: $(which mpirun)"
echo "Using mpicc lib: $(which mpicc)"
echo "Using GCC lib: $(which gcc)"
echo ""

### section 4 - Job Run
echo "***** EXEC SCRIPT *****"
echo `date '+%F %H:%M:%S'`
echo "***********************"
echo ""

###export OMPI_MCA_btl='^uct,ofi'
###export OMPI_MCA_pml='ucx'
###export OMPI_MCA_mtl='^ofi'

mkdir -p plots
###python3 src/matplotlib_test.py
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
mpirun -np $SLURM_NTASKS python3 src/mpi_matplotlib_test.py

echo ""
echo "******** DONE *********"
echo `date '+%F %H:%M:%S'`
echo "***********************"
echo ""
