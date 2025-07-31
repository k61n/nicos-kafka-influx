FROM debian:latest

WORKDIR /root

# packages from official debian repos
RUN apt update && apt upgrade -y && apt autoremove -y && \
    apt install -y git htop nano wget \
    python3-build python3-dev python3-venv \
    pyqt5-dev pyqt5-dev-tools python3-pyqt5.qsci python3-pyqt5.qtwebkit \
    python3-pip python3-pytest python3-pytest-repeat python3-pytest-rerunfailures python3-pytest-timeout \
    python3-aiohttp python3-astropy python3-ciso8601 python3-docutils python3-h5py python3-html2text python3-keyring \
    python3-keyrings.alt python3-ldap3 python3-mock python3-numpy python3-psutil python3-requests python3-rsa \
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
RUN wget https://files.pythonhosted.org/packages/fa/af/422282fcfe21179a4e25a03bea607d51f426957956b18fbe97b7bda8ba13/lttb-0.3.2.tar.gz && \
    tar -xvf lttb-0.3.2.tar.gz && \
    cd lttb-0.3.2 && \
    python3 -m build

# influxdb 1.41
RUN wget https://files.pythonhosted.org/packages/2a/f3/9c418215cf399529175ed5b198d15a21c2e29f28d90932107634b375c9ee/influxdb_client-1.49.0.tar.gz && \
    tar -xvf influxdb_client-1.49.0.tar.gz && \
    cd influxdb_client-1.49.0 && \
    python3 setup.py install && \
    wget https://files.pythonhosted.org/packages/33/78/bd4a85d195e57e72837415ef81d26ce6db6fdf185dce8d4f6a7c099ed4af/aiocsv-1.3.2.tar.gz && \
    tar -xvf aiocsv-1.3.2.tar.gz && \
    cd aiocsv-1.3.2 && \
    python3 setup.py install

# kafka
RUN apt install -y librdkafka-dev python3-confluent-kafka python3-flatbuffers && \
    wget https://files.pythonhosted.org/packages/c1/3a/72a2dfcb072c09d8670fb661d0327d9f4ece665fffb49db471d5e63b6b6e/kafka_python-2.2.8.tar.gz && \
    tar -xvf kafka_python-2.2.8.tar.gz && \
    cd kafka_python-2.2.8 && \
    python3 setup.py install && \
    wget https://files.pythonhosted.org/packages/35/97/5659d3003aa4eeaac0c6e1c856ce2f46ff03a7bc1e3e3e0ea5984659737d/kafka-logging-handler-0.2.5.tar.gz && \
    tar -xvf kafka-logging-handler-0.2.5.tar.gz && \
    cd kafka-logging-handler-0.2.5 && \
    python3 setup.py install && \
    wget https://files.pythonhosted.org/packages/f9/02/752f404379f1787c10a318853e90c32df13e5876238c4f16ee696f570c22/ess_streaming_data_types-0.27.0.tar.gz && \
    tar -xvf ess_streaming_data_types-0.27.0.tar.gz && \
    cd ess_streaming_data_types-0.27.0 && \
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
