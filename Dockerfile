FROM hypriot/rpi-node:6.9.4

# Install alsa-utils
RUN apt-get update && apt-get install -yq \
   alsa-utils libasound2-dev && \
   apt-get clean && rm -rf /var/lib/apt/lists/*

# Create sense directory
RUN mkdir -p /usr/src/humix-sense
WORKDIR /usr/src/humix-sense

# Install sense dependencies
COPY package.json /usr/src/humix-sense
RUN npm install

# Bundle sense source
COPY . /usr/src/humix-sense

# Create sense directory
RUN mkdir -p /usr/src/humix-sense/modules/core/humix-spotify-module
WORKDIR /usr/src/humix-sense/modules/core/humix-spotify-module

# Install module dependencies
#COPY ./modules/core/humix-spotify-module/package.json /usr/src/humix-sense/modules/core/humix-spotify-module
#RUN npm install

# Bundle module source
COPY ./modules/core/humix-spotify-module /usr/src/humix-sense/modules/core/humix-spotify-module

# Execute sense
WORKDIR /usr/src/humix-sense
CMD [ "npm", "start" ]
