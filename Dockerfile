FROM ubuntu:14.04
MAINTAINER tiziano Di Gennaro "tiziano.digennaro@gmail.com"
# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade
# Install Python
RUN apt-get install -y python-dev python-pip
# Add requirements.txt
ADD requirments.txt .
# Install app requirements
RUN pip2 install -r requirments.txt
# Create app directory
RUN mkdir -p /var/www/app
ADD main.py /var/www/app
# Set the default directory for our environment
ENV HOME /var/www/app
WORKDIR /var/www/app
# Expose port 5000 for uwsgi
EXPOSE 5000

ENTRYPOINT ["python"]
CMD ["main.py"]

