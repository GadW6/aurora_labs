FROM jenkins/jenkins:2.391

# Switch to user root for installations
USER root

# Updating the apt sources
RUN apt-get update -y

# Install pyton dependency
RUN apt-get install -y python

# Switch back to default jenkins user
USER jenkins