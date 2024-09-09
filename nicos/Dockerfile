FROM debian:latest

WORKDIR /root

# packages from official debian repos
RUN apt update && apt upgrade -y && apt autoremove -y && \
    apt install -y git htop nano wget \
    pyqt5-dev pyqt5-dev-tools python3-dev python3-pip python3-pytest python3-pytest-repeat python3-pytest-rerunfailures python3-pytest-timeout \
    python3-aiohttp python3-astropy python3-ciso8601 python3-docutils python3-h5py python3-html2text python3-keyring python3-keyrings.alt \
    python3-ldap3 python3-mock python3-numpy python3-psutil python3-pyqt5.qsci python3-pyqt5.qtwebkit python3-requests python3-rsa \
    python3-scipy python3-tango python3-toml python3-uncertainties python3-zmq

# gr framework from their repo
RUN echo 'deb [trusted=yes] https://download.opensuse.org/repositories/science:/gr-framework/Debian_12/ /' | tee /etc/apt/sources.list.d/science:gr-framework.list && \
    apt update && \
    apt install -y gr python3-gr --allow-unauthenticated

# nicos-pyctl from source
RUN git clone https://github.com/mlz-ictrl/nicos-pyctl.git && \
    cd nicos-pyctl && \
    python3 setup.py install

# nicos-quickyaml from source
RUN git clone https://github.com/mlz-ictrl/nicos-quickyaml.git && \
    cd nicos-quickyaml && \
    python3 setup.py install

# lttb
RUN wget https://files.pythonhosted.org/packages/7c/88/696d67f73051e23b18b12702b8cf3da46224c824575eaa53c1963c7778ce/lttb-0.2.2.tar.gz && \
    tar -xvf lttb-0.2.2.tar.gz && \
    cd lttb-0.2.2 && \
    python3 setup.py install

# influxdb 1.41
RUN wget https://files.pythonhosted.org/packages/bf/80/8f5dab7bfe55e65181cbc1e268806ae1ddc935a1b2ae612ed7f41d8bd0c1/influxdb_client-1.41.0.tar.gz && \
    tar -xvf influxdb_client-1.41.0.tar.gz && \
    cd influxdb_client-1.41.0 && \
    python3 setup.py install && \
    wget https://files.pythonhosted.org/packages/e3/89/3eb2edcb6ea6cf91c99be1f315a7260d2f1f41806e3aecc4e07638690cc5/aiocsv-1.3.1.tar.gz && \
    tar -xvf aiocsv-1.3.1.tar.gz && \
    cd aiocsv-1.3.1 && \
    python3 setup.py install

# kafka
RUN apt install -y librdkafka-dev python3-confluent-kafka python3-flatbuffers && \
    wget https://files.pythonhosted.org/packages/07/4c/2595fb5733c3ac01aef3dacce17ff07f7f3336d9f96548bcf723b9073e5c/kafka-python-2.0.2.tar.gz && \
    tar -xvf kafka-python-2.0.2.tar.gz && \
    cd kafka-python-2.0.2 && \
    python3 setup.py install && \
    wget https://files.pythonhosted.org/packages/35/97/5659d3003aa4eeaac0c6e1c856ce2f46ff03a7bc1e3e3e0ea5984659737d/kafka-logging-handler-0.2.5.tar.gz && \
    tar -xvf kafka-logging-handler-0.2.5.tar.gz && \
    cd kafka-logging-handler-0.2.5 && \
    python3 setup.py install && \
    wget https://files.pythonhosted.org/packages/ea/0e/9f9e985cbde276c02b2e7f7827ccce498066c9f3f874f21b74cd24cf7708/ess_streaming_data_types-0.23.1.tar.gz && \
    tar -xvf ess_streaming_data_types-0.23.1.tar.gz && \
    cd ess_streaming_data_types-0.23.1 && \
    python3 setup.py install

RUN groupadd -g 1001 nicos && \
    useradd -m -u 1001 -g 1001 -d /home/nicos -s /bin/bash nicos && \
    echo "nicos:nicos" | chpasswd

COPY files/ /
USER 1001
WORKDIR /home/nicos

RUN cd /home/nicos && \
    git clone "https://forge.frm2.tum.de/review/frm2/nicos/nicos"

ENTRYPOINT [ "entrypoint.sh" ]
