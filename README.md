# Llama-on-babel

## Setup

- Connect to babel by `ssh [andrewid]@babel.lti.cs.cmu.edu`
- [Install miniconda](https://docs.conda.io/projects/miniconda/en/latest/#quick-command-line-install) for managing python virtual envs
- Clone this repo and install requirements by `pip install -r requirements.txt`
- Login to huggingface by `huggingface-cli login`. The Llama 2 models are gated, so you may need to request access if you haven't done so before.
- (Optional) [setup passwordless login](https://hpc.lti.cs.cmu.edu/wiki/index.php?title=Connecting_to_the_Cluster#Passwordless_Login)
- (Optional, but recommended) huggingface caches files in the home directory, which eats up disk space quickly.
You can ask huggingface to cache model files on `/scratch`, a large shared storage space available on compute nodes, by adding the following lines to your `~/.bashrc` file:

```
if [ -d /scratch ]; then
    mkdir -p /scratch/$USER
    export TRANSFORMERS_CACHE="/scratch/$USER/hf_cache/models"
fi
```

## Start an interactive job and run llama inference

First, request an interactive session with GPU using the following command:
```
srun    --time=1:00:00 \
        --gres=gpu:A6000:1 \
        --mem=30GB \
        --pty \
        bash
```

The `srun` command starts a job in the real-time, and this command will request a node with 1 GPU, 30GB memory, and 1 hour time limit.

Note: slurm documentation can be found [here](https://slurm.schedmd.com/srun.html).

With the appropriate python environment activated, `python src/llama-pipeline.py` should run a llama generation pipeline.

## Submit a job and let it run in the background

You might want to submit a job to run in the background.
`sbatch` does exactly this: it takes a script file that describes how a node is setup and what commands to run, and submits that job for execution.

**Note: the environment inside `sbatch` is by default inherited from the environment where `sbatch` is called.**
So you need to activate the appropriate conda environment before calling sbatch.

`srun` and `sbatch` practically share the same arguments.
`sbatch scripts/submit.sh python src/llama-pipeline.py` submits a job that runs `python src/llama-pipeline.py` in the background.
Stdout and stderr are redirected to a file named `slurm-[jobid].out`.


