all: image

image:
	@echo "Building must-gather image"
	docker build -f Dockerfile -t ocs-must-gather . 
