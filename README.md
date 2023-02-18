# Welcome Aurora Labs!

I am excited to share the project that I have developed as per the requirements. Below, you will find a simplified architecture design that illustrates the project's components and their relationships:
![](documentation/aurora_labs.drawio.png?raw=true)

## Requirements
The system requirements for this project are as following:

|-------------------------------|-----------------------------|
|Operating System					      |Preference using *nix system (to run startup script), but any system will do|
|RAM       |According to docker stats while running: 1GB (but 2GB is better)           |
|DISK SPACE|1.35Gb (Repo folder size: ~350Mb, Docker compose stack + images: ~1Gb) |
|Internet| Need internet for docker build|



## Introduction
When looking at the assignment it would pretty straight-forward, but when diving into the actual development something comes to mind: "If my git version control is saas based and my docker compose stack is locally hosted, how will i handle the webhook ? "
After some reflection, 3 options came up to my mind:

-	Git Saas + Docker compose hosted locally.
	The idea is to use a git saas (github, gitlab, etc..) and send the webhook to my local docker compose stack.
	For this setup i need to port forward traffic through my home router by changing its configuration..
-	Git Saas + Cloud VM (Ec2, etc...).
	The idea is to connect the git webhook to a virtual machine on the cloud.
	For this setup i need to spin up a VM (possible financial cost) and expose the ports used by docker-compose.
-	Self Hosted Git + docker compose hosted locally.
	The idea here is to have everything running locally i don't have to rely on any external resources, but this setup brings a 	lot of unknown entities and overhead to the task


As you may have guessed it - although it may have been the most challenging solution - i went for the 3rd option. 

### Research
Now that i know how my docker compose stack is suppose to look like, let's ask google for a self hosted git open source
supporting webhooks solution and see what comes out.
2 popular solutions came back: Gitlab and Gitea.
Now, Gitlab is familiar to me and according to their documentation, the docker minimum requirements are heavy.
On the other hand, Gitea is lightweight, but lacks the documentation, full featured, mature and community of his competitor.

As you probably guessed it - although completely unfamiliar with the service - I went for Gitea.


##	Deployment

####	Startup script (Bash)

    #!/bin/bash
    # Run me as sudo to install all necessary dependencies
    # and make sure to run this script inside the root directory of this repo
      
    #################################################
    # Build images
    #################################################
    docker build  -f  ./dockerfiles/jenkins.Dockerfile  -t  jenkins_python:latest  .
    docker build  -f  ./dockerfiles/bapi.Dockerfile  -t  bapi:latest  .
    
    # TODO: create jenkins agent
    # docker build -f ./dockerfiles/agent.Dockerfile -t jenkins_agent:latest .
    
    #################################################
    # Deploy the docker compose stack
    #################################################
    docker compose  -f  ./docker-compose.yml  up  -d

As we can see, the script creates the custom base images for the docker compose.
And then lastly, deploys the docker compose itself.

##### Run the following command: 
    sudo sh run.sh

Please follow the first 2 lines of the script stating that you should run this script when your current path is the root path of the repository and make sure you run the script as sudo if you haven't added docker group as part of sudoers...
	    
    $ docker compose ps
    NAME                COMMAND                  SERVICE             STATUS              PORTS
    bapi                "docker-entrypoint.s…"   bapi                running             0.0.0.0:5000->5000/tcp, :::5000->5000/tcp
    gitea               "/usr/bin/entrypoint…"   gitea               running             0.0.0.0:222->22/tcp, 0.0.0.0:3000->3000/tcp, :::222->22/tcp, :::3000->3000/tcp
    jenkins             "/usr/bin/tini -- /u…"   jenkins             running             0.0.0.0:8080->8080/tcp, 0.0.0.0:50000->50000/tcp, :::8080->8080/tcp, :::50000->50000/tcp

Once you have reached this state, then the stack is running properly.

#### Jenkins
To login to jenkins use the following credentials:
> Url: **http://localhost:8080/**
> User: **admin**
> Password: **password**

--> Make your way to *Dashboard* > *Main*  to visit the pipeline.

#### Gitea
To login the Gitea, use the following credentials:
> Url: **http://localhost:3000/**
> User: **git**
> Password: **password**

--> Make your way to *Explore* > *git/jenkins* to visit the repository.
(Any changes made here should trigger automatic webhook to Jenkins pipeline) 


## Result
![](documentation/jenkins_job.png?raw=true)

If the result differ in any way, it'd be more than happy to challenge my case.

#### Caveat
The string 'DevOps is great' shown as part of the stdout of the pipeline is actually a response to a curl query made from the main.py python script to a third container running a very slim down nodejs backend api application.
Why ? To simulate api interractions occuring behind the scenes, and also just because i can :)


## Key Takeaways
Yes i am aware that a Jenkins/Gitea production credentials would never look like that, but for simplicity sake i choose to leave it that way.
Also, i would not use the jenkins controller as the orchestrator and executor of the pipelines.
I would spin up a cluster of controller and agents, and scale out the cluster according to the needs. 
As for Git version control, i would probably never use a self hosted service since most of them offer data retention, 
~100% uptime, shared runners, etc...
I also want to point out that given more time, i am sure i could make never ending improvements.


**What I learned**:

 - Gitea Service
 - Jenkins permanent agent is trickier than it looks using JNPL4 (need to research more on that)
 - https://stackedit.io can go a long way when writing MD



Thank you for the opportunity.
I hope it reaches you in good form !
