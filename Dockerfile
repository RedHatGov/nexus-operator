FROM quay.io/operator-framework/ansible-operator:v1.0.0

COPY requirements.yml ${HOME}/requirements.yml

USER root

RUN dnf -y --setopt=tsflags=nodocs update && \
    dnf -y --setopt=tsflags=nodocs install git && \
    dnf -y clean all --enablerepo='*' && \
    pip3 install --upgrade --no-cache-dir git+https://github.com/jharmison-redhat/devsecops-api-script.git


USER ansible
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/
