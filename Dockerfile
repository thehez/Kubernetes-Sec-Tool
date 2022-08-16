FROM debian

# Install network utilities and assessment tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        arp-scan \
        curl \
        dnsutils \
        dsniff \
        iproute2 \
        iputils-ping \
        jq \
        net-tools \
        netcat-traditional \
        nmap \
        openssh-client \
        procps \
        socat \
        tcpdump \
        traceroute \
        nano \
        && \
    rm -rf /var/lib/apt/lists/*

# Install kubectl to avoid using Curl for enumeration
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Install DEEPCE (Docker Enumeration)
RUN curl -sL https://github.com/stealthcopter/deepce/raw/main/deepce.sh -o /usr/local/bin/deepce.sh && \
    chmod +x /usr/local/bin/deepce.sh

# Install amicontained
RUN curl -fSL https://github.com/genuinetools/amicontained/releases/download/v0.4.9/amicontained-linux-amd64 -o /usr/local/bin/amicontained && \
	chmod a+x /usr/local/bin/amicontained

# Add Kube Audit
COPY kubeaudit /usr/local/bin/kubeaudit

# Add Peirates
COPY peirates /usr/local/bin/peirates

# Install Lin Exploit Suggester
COPY linux-exploit-suggester.sh /usr/local/bin/linux-exploit-suggester

# Install linPEAS
RUN curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh -o /usr/local/bin/linpeas.sh && \
    chmod +x /usr/local/bin/linpeas.sh

# Install reg
RUN curl -fSL https://github.com/genuinetools/reg/releases/download/v0.16.0/reg-linux-amd64 -o /usr/local/bin/reg && \
    chmod +x /usr/local/bin/reg

# Install Kubeletctl
RUN curl -LO https://github.com/cyberark/kubeletctl/releases/download/v1.7/kubeletctl_linux_amd64 && \
    chmod a+x ./kubeletctl_linux_amd64 && \
    mv ./kubeletctl_linux_amd64 /usr/local/bin/kubeletctl