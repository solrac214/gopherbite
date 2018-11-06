FROM golang:1.11.2
RUN go get github.com/gopherjs/gopherjs
RUN apt update
RUN apt install -y libglu1-mesa-dev libgles2-mesa-dev libxrandr-dev libxcursor-dev libxinerama-dev libxi-dev libasound2-dev
RUN go get github.com/hajimehoshi/ebiten/... 
WORKDIR /go/src/game
COPY . .
RUN gopherjs build -o game.js ./main.go

FROM nginx
WORKDIR /usr/share/nginx/html
COPY --from=0 /go/src/game/game.js .
COPY index.html .
