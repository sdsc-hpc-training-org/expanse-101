[1] Compile:


### MODULE ENV: updated 01/28/2020 (MPT)
 module purge 
 module load slurm 
 module load cpu
 module load gcc/10.2.0
 module load openmpi/4.0.4

mpif90 -o hello_mpi hello_mpi.f90

[2a] Run using Slurm:

sbatch hellompi-slurm.sb


[2b] Run using interactive node:

# obtain an interactive node
srun --partition=debug  --pty --account=use300--nodes=1 --ntasks-per-node=4  --mem=8G -t 00:30:00 --wait=0 --export=ALL /bin/bash

# On the node:
module purge 
module load slurm
module load cpu
module load gcc/10.2.0 
module load openmpi/4.0.4
mpirun -np 8 ./hello_mpi_f_gnu
