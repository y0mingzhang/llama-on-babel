#!/bin/bash

#SBATCH --job-name="llama-inference"
#SBATCH --time=1:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=30GB
#SBATCH --exclude=babel-3-[3,11,32,36],babel-4-[7,11,13,18]

export TRANSFORMERS_CACHE="/scratch/$USER/hf_cache/models" # asks huggingface to cache on data drives instead of user home
srun $@
