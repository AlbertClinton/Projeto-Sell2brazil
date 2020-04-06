FROM node:latest
COPY ./Vue /app
WORKDIR /app
RUN npm install
CMD [ "npm","start" ]