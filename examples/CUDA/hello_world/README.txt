[1] Compile CUDA Code:

(a) Get an interactive GPU debug node:

module load slurm
srun --pty --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 -p gpu-debug --gpus=1 -t 00:10:00 -A sds173 /bin/bash

(b) On the GPU node:
module purge
module load slurm
module load gpu
module load cuda10.2/toolkit/10.2.89

nvcc -o hello_world_device hello_world_device.cu

(Exit out of debug node after this)

[2] Run job:

sbatch  hello-world-gpu.sb
