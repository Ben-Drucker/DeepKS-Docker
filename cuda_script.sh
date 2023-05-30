#!/bin/zsh

if [ ! nvidia-smi ] 
then
    echo "GPU is available"
    source /home/$UN/python_env/bin/activate && pip install torch --index-url https://download.pytorch.org/whl/cu118
else
    echo "GPU is not available"
    source /home/$UN/python_env/bin/activate && pip install torch --index-url https://download.pytorch.org/whl/cpu
fi