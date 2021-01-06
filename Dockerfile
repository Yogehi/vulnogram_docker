FROM ubuntu:focal-20201106

# install appropriate programs
RUN apt-get update && \
	apt-get install -y \
	curl \
	apt-utils \
	git \
	python3 \
	build-essential

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get install -y \
	nodejs

# clone vulnogram github and build
WORKDIR /
RUN git clone https://github.com/Vulnogram/Vulnogram.git
WORKDIR /Vulnogram
RUN npm install
RUN make min

# setup for web server
WORKDIR /Vulnogram/standalone/
COPY startup.sh ./
RUN chmod +x ./startup.sh
CMD ["bash", "./startup.sh"]
