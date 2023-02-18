FROM openjdk:11-jdk

# Install necessary tools
RUN apt-get update && \
    apt-get install -y git curl && \
    rm -rf /var/lib/apt/lists/*

# Create a jenkins user
RUN useradd -m -s /bin/bash jenkins

# Switch to the jenkins user
USER jenkins

# Copy the agent jar
COPY ./agent.jar ./agent.jar

# Set the entrypoint for the agent
ENTRYPOINT ["java", "-jar", "agent.jar", "-jnlpUrl", "http://jenkins:8080/computer/agent/jenkins-agent.jnlp", "-secret". "49f4b4995b54f38a6bdb3598e91db9e9281b947dde0e5d96e08404865be328b4", "-workDir", "/home/jenkins/agent"]
