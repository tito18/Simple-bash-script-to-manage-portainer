#!/bin/bash

ver="portainer/portainer-ce:2.15.1-alpine"

PS3='Choose an option to portainer: '
opts=("stop" "start" "changeVER" "viewVER" "quit")

select opt in "${opts[@]}"; do

	case $opt in
		"stop")
			echo "To stop and remove portainer container"
			docker stop portainer && docker rm portainer
			break
			;;
		"start")
			echo "To start portainer"
			docker run -d -p 9090:8000 -p 9091:9000 --name=portainer --restart=always \
			-v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data \
			"${ver}"
			break
			;;
		"changeVER")
			docker stop portainer && docker rm portainer
			echo "Introduce the portainer version that you want to deploy"
			read ver
			docker run -d -p 9090:8000 -p 9091:9000 --name=portainer --restart=always \
            -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data \
            "${ver}"
			break
			;;
		"viewVER")
			echo "The portainer version that running is ${ver}"
			break
			;;
		"quit")
			echo "User requested exit"
			exit
			;;
		*) echo "invalid option $REPLY";;
	esac
done
