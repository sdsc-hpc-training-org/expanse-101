[1] Compile:

module purge
module load slurm
module load cpu
module load gcc/10.2.0
module load openmpi/4.0.4

mpif90 -o hello_mpi hello_mpi.f90

[2] Run:

sbatch hellompi-slurm.sb
