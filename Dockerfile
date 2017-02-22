FROM ubuntu:14.04
MAINTAINER Melissa Gymrek <mgymrek@mit.edu>
RUN sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && gpg -a --export E084DAB9 | apt-key add -
RUN apt-get -qqy update
RUN apt-get install -y -q r-base r-base-dev gdebi-core libapparmor1 supervisor wget default-jdk libcairo2-dev libxml2-dev
RUN (wget http://download2.rstudio.org/rstudio-server-1.0.136-amd64.deb && gdebi -n rstudio-server-1.0.136-amd64.deb)
RUN rm /rstudio-server-1.0.136-amd64.deb
RUN (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd)
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8787
CMD ["/usr/bin/supervisord"]
