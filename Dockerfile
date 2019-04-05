FROM gliderlabs/alpine:3.5
RUN apk update && apk upgrade
RUN apk add --no-cache bash nodejs gcc
RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev && \
	apk add --no-cache openblas-dev && \
    apk add --no-cache --update python3 && \
    apk add linux-headers linux-pam
RUN pip3 install --upgrade pip setuptools && \
python3 -m pip install jupyter && \
npm install -g configurable-http-proxy && \
python3 -m pip install pyzmq notebook
ADD jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

# INSTALLING ML PACKAGES
RUN pip install  numpy
RUN pip install  scipy 
RUN python3 -m pip install --upgrade pip scikit-learn
#RUN pip install https://github.com/better/alpine-tensorflow/releases/download/alpine3.7-tensorflow1.7.0/ tensorflow-1.7.0-cp36-cp36m-linux_x86_64.whl

ENTRYPOINT ["sh","-c","jupyter notebook --allow-root"]