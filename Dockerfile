FROM debian:bookworm-slim as build

RUN apt-get update && apt-get install -y unzip curl
RUN curl -sLO https://github.com/epi052/feroxbuster/releases/latest/download/feroxbuster_amd64.deb.zip && unzip feroxbuster_amd64.deb.zip

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates gnupg wget

RUN wget -q -O - https://archive.kali.org/archive-key.asc  | apt-key add -
RUN echo "deb https://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" | tee /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip git \
    curl dnsrecon enum4linux \
    gobuster impacket-scripts nbtscan \
    nikto nmap onesixtyone \ 
    oscanner redis-tools smbclient \
    smbmap snmp sslscan  \
    sipvicious tnscmd10g whatweb \
    wkhtmltopdf \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build ./feroxbuster_*_amd64.deb .
RUN apt install ./feroxbuster_*_amd64.deb

RUN python3 -m pip install git+https://github.com/Tib3rius/AutoRecon.git --break-system-packages


CMD ["/bin/bash"]