FROM quay.io/operator-framework/ansible-operator:v1.0.0

COPY requirements.yml ${HOME}/requirements.yml

USER root
RUN dnf -y --setopt=tsflags=nodocs update && \
    dnf -y --setopt=tsflags=nodocs install git && \
    dnf -y clean all --enablerepo='*' && \
    pip3 install git+https://github.com/andykrohg/devsecops-api-script.git@4735574611c114b49bcc46f52b8ed3a173c94456


USER ansible
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/
