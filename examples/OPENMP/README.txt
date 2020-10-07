[1] Compile:

module purge
module load slurm
module load cpu
module load aocc

flang -fopenmp -o hello_openmp hello_openmp.f90

[2] Run:

sbatch openmp-slurm-shared.sb
