export UN='dockeruser'
source /home/$UN/python_env/bin/activate
export PS1="%n@%m [%3~] ▷ "
export CUBLAS_WORKSPACE_CONFIG=:4096:8
tab='    '
export greeting="\n\u001b[36mWelcome to the DeepKS docker image! \n\nConsider running\n\u001b[34m${tab}cd DeepKS && git pull && cd ..\n\u001b[36mto update DeepKS to the latest version.\n\nTo use the development branch of DeepKS, run \u001b[34m\n${tab}cd DeepKS && git switch dev && cd .. \n\n"

printf $greeting