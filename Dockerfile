FROM alpine
WORKDIR /root/app
COPY .stack-work/docker/_home/.local/bin/Covid19Stats-exe Covid19Stats
COPY web/target web/target
CMD ["./Covid19Stats"]
