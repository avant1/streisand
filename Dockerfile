FROM williamyeh/ansible:master-debian9

RUN apt-get update && apt-get install -y git python-paramiko python-pip python-pycurl python-dev build-essential \
        && pip install dopy==0.3.5

COPY keys/id_rsa.pub keys/id_rsa /root/.ssh/
RUN chmod 700 /root/.ssh/ && chmod 0644 /root/.ssh/id_rsa.pub && chmod 0600 /root/.ssh/id_rsa

WORKDIR /streisand
