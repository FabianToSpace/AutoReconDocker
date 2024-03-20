FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates gnupg wget

RUN wget -q -O - https://archive.kali.org/archive-key.asc  | apt-key add -
RUN echo "deb https://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" | tee /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    python3 python3-pip git \
    curl dnsrecon enum4linux \
    feroxbuster gobuster impacket-scripts \
    nbtscan nikto nmap \
    onesixtyone oscanner redis-tools \
    smbclient smbmap snmp \
    sslscan sipvicious tnscmd10g \
    whatweb wkhtmltopdf

RUN python3 -m pip install git+https://github.com/Tib3rius/AutoRecon.git


CMD ["/bin/bash"]