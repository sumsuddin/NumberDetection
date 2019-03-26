FROM nvidia/cuda:9.0-cudnn7-devel

RUN apt update && apt install -y wget curl fish sudo unzip python-tk git

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O ~/anaconda.sh && bash ~/anaconda.sh -b && rm ~/anaconda.sh
ENV PATH /root/anaconda3/bin:$PATH

RUN git clone https://github.com/Ivalua/object_detection_ocr.git
WORKDIR object_detection_ocr
RUN conda env update --file keras-tf-py35.yml

RUN apt update && apt install nano

#RUN useradd -ms /bin/bash -g root -G sudo -p dockeruser dockeruser
#RUN echo dockeruser:dockeruser | chpasswd
#USER dockeruser

ADD keras.json /root/.keras/keras.json

RUN apt update && apt install -y libsm6 libxext6 libglib2.0-0

RUN apt purge --allow-change-held-packages libcudnn7* -y
RUN apt-get update && apt-get install --no-install-recommends libcudnn7=7.0.3.11-1+cuda9.0 libcudnn7-dev=7.0.3.11-1+cuda9.0 &&  apt-mark hold libcudnn7 
