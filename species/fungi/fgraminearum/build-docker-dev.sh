#!/bin/bash

IMAGE_NAME="knetminer-fusarium-dev"

SPECIES_DIR=`pwd | rev | cut -d '/' -f1 | rev`
cd ../../..
cp .dockerignore-template .dockerignore
cat .gitignore >> .dockerignore
ls -1 | grep -v species/fungi/$SPECIES_DIR | grep -v pom.xml | grep -v common >> .dockerignore

docker image build \
    	--build-arg tax_id=5518  \
    	--build-arg species_name="Fusarium graminearum" \
    	--build-arg species_link_name=fusarium \
    	--build-arg keywords="fusarium, f.graminearum, knetminer, quickstart, demo" \
    	--build-arg description="Fusarium Knetminer" \
    	--build-arg reference_genome=true \
  --build-arg species_dir="species/fungi/$SPECIES_DIR" \
  --build-arg oxl_file="FungiKNET.oxl" \
  --build-arg knetminer_port=8081 \
  --squash -t $IMAGE_NAME \
  -f common/quickstart/Dockerfile-dev .

if [ $? -eq 0 ]; then
	rm .dockerignore
	cd species/fungi/$SPECIES_DIR
	echo "You can run this Docker using: docker run -p8080:8080 -it --rm $IMAGE_NAME"
	echo "Then access it at http://localhost:8080/client/"
	echo "Note: port 8080 is the Tomcat default; replace with the knetminer_port defined in this file"
fi
