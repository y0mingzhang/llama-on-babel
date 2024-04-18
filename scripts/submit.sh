#!/bin/bash

#SBATCH --job-name="llama-inference"
#SBATCH --time=1:00:00
#SBATCH --gres=gpu:A6000:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=30GB

export TRANSFORMERS_CACHE="/scratch/$USER/hf_cache/models" # asks huggingface to cache on data drives instead of user home
srun $@
