# Setup
FROM benndrucker/deepks-r:latest

# Install VSCode for tunnelling
COPY "supporting_scripts/vscode_script.sh" "vscode_script.sh"
RUN chmod +x vscode_script.sh
RUN ./vscode_script.sh

ARG UN=dockeruser
WORKDIR /home/$UN/docker-build

## Potentially install more dependencies after this point
COPY "supporting_scripts/additional-pip-packages.txt" "additional-pip-packages.txt"
RUN ["/bin/zsh", "-c", "source /home/$UN/python_env/bin/activate && pip install -r /home/$UN/DeepKS/requirements.txt"]
RUN ["/bin/zsh", "-c", "source /home/$UN/python_env/bin/activate && pip install \"MarkupSafe>=2.0\" && pip install torch --index-url https://download.pytorch.org/whl/cu118"]
COPY "supporting_scripts/additional-apt-packages.txt" "additional-apt-packages.txt"
RUN apt-get update && apt-get install -y $(cat "additional-apt-packages.txt")
USER $UN
RUN cd /home/$UN/DeepKS && git pull && git switch dev && git switch main && git lfs pull && cd -
USER root

# Install cuda-related items
# COPY "cuda_script.sh" "cuda_script.sh"
# RUN chmod +x cuda_script.sh
# RUN ./cuda_script.sh

# Final Setup
RUN ln -s ~/DeepKS /DeepKS
RUN echo 'dockeruser:dockeruser' | chpasswd 
RUN usermod -aG sudo $UN

USER $UN
WORKDIR /home/$UN
COPY "supporting_scripts/dockeruser-rc.zshrc" /home/$UN/.zshrc
RUN chown -R $UN /home/$UN/DeepKS
CMD /bin/zsh

# Build command: 

# Test on native arch first...
# docker build -f final-steps.dockerfile -t benndrucker/deepks:0.2.0 -t benndrucker/deepks:latest .

# Then build for multiple architectures...
# docker buildx build -f final-steps.dockerfile --platform linux/arm64,linux/amd64 --push -t benndrucker/deepks:VERSION -t benndrucker/deepks:latest .