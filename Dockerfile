FROM debian:buster-20210621-slim

# If you want the updates (available at the bootstrap date) to be installed
# inside the container during the bootstrap instead of the General Availability
# point release (7.x) then uncomment the following line
#UpdateURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/updates/$basearch/

COPY  ./parallel_mandle.py /usr/local/bin/mandle/parallel_mandle.py
COPY  ./zoom_mandle.py /usr/local/bin/mandle/zoom_mandle.py

RUN apt update

RUN apt install -y zlib1g-dev \
                   libjpeg-dev \
                   libfreetype6-dev \
                   liblcms2-dev \
                   libopenjp2-7-dev \
                   libtiff-dev \
                   tk-dev \
                   tcl-dev \
                   libharfbuzz-dev \
                   libfribidi-dev \
                   python3 \
                   python3-pip
               
RUN  python3 --version && \
  python3 -m pip install --upgrade pip wheel && \
  python3 -m pip install --upgrade Pillow numpy && \
  python3 -m pip list && \
  which python3

RUN chmod 755 /usr/local/bin/mandle/zoom_mandle.py

ENTRYPOINT ["/usr/local/bin/mandle/zoom_mandle.py"]
CMD ["--help"]

#TODO: Add metadata and edit the runscript
#%runscript
#  /usr/local/bin/mandle/zoom_mandle.py
#
#%help
# This container includes the python Pillow and numpy libraries, needed to run
# Eric's Mandlebrot gif generator, at /usr/local/bin/mandle/zoom_mandle.py.
