[1] Compile:

module purge
module load slurm
module load cpu
module load gcc/10.2.0
module load openmpi/4.0.4

mpif90 -o hello_mpi hello_mpi.f90

[2a] Run using Slurm:

sbatch hellompi-slurm.sb


[2b] Run using Interactive CPU Node

srun  --pty  --nodes=1  --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash

