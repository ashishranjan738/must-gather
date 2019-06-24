all: image

image:
	@echo "Building must-gather image"
	docker build Dockerfile -t ocs-must-gather . 
