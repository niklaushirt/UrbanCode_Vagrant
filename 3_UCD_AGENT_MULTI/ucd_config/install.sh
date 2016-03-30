#!/bin/bash

        echo '  # Installation directory of the agent
                locked/agent.home=/opt/ibm-ucd/agent

                # Name of the agent (should be unique)
                locked/agent.name=AGENT_VAGRANT_'$1'
                locked/agent.initial.teams=JKE

                # IP or host of the server or relay to connect to
                locked/agent.jms.remote.host=192.168.232.77
                locked/agent.jms.remote.port=7918

                # If the agent should verify the certificate of the server or relay it connects to
                locked/agent.mutual_auth=false

                # Windows service installation options
                locked/agent.service=true
                locked/agent.service.name=ibm-ucdagent
                locked/agent.service.login=.\localsystem
                locked/agent.service.password=nopass
                locked/agent.service.autostart=false' > agent.install.properties
      
      
        #GET AGENT FROM UCD SERVER
        wget http://192.168.232.77:8080/tools/ibm-ucd-agent.zip
        unzip ibm-ucd-agent.zip
        cd ibm-ucd-agent-install/
      

        #INSTALL UCD AGENT
        sudo ./install-agent-from-file.sh ../agent.install.properties

        #START UCD AGENT
        sudo /opt/ibm-ucd/agent/bin/agent start

        #DOCKER UI
        #docker run -d -p 9000:9000 --name "DOCKER_UI" --privileged -v /var/run/docker.sock:/var/run/docker.sock dockerui/dockerui

        #RANCHER
        #sudo docker run -d --name RANCHER_SERVER --restart=always -p 9003:8080 rancher/server

    