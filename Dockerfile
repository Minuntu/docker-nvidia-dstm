FROM nvidia/cuda:9.0-runtime

ENV DSTM_GDRIVE_ID 1Q8kCklgXS9SctNARYyg48RXv4qEyUcQs
ENV DSTM_SHA1   c5951521699e8f58f339a3a194a8896b27ebfba8

# Install dstm deps :
RUN apt-get update && apt-get install --no-install-recommends -y wget ca-certificates && \
    apt-get clean && rm -Rf /var/lib/apt/lists


RUN mkdir /opt/dstm

# Default dir /opt/dstm
WORKDIR /opt/dstm

RUN echo ${DSTM_SHA1} zm > zm.sha1

RUN wget -q "https://docs.google.com/uc?id=${DSTM_GDRIVE_ID}&export=download" -O dstm.tar.gz && \
    tar --strip=1 -xzvf dstm.tar.gz && \
    sha1sum -c zm.sha1 && \
    rm dstm.tar.gz zm.sha1

ENTRYPOINT [ "/opt/dstm/zm" ]
