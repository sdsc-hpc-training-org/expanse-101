[1] Compile:


### MODULE ENV: updated 01/28/2020 (MPT)
module purge
module load cpu/0.15.4  
module load intel/19.1.1.217
module load mvapich2/2.3.4

mpif90 -o hello_mpi hello_mpi.f90

[2a] Run using Slurm:

sbatch hellompi-slurm.sb


[2b] Run using Interactive CPU Node

srun  --pty  --nodes=1  --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash

