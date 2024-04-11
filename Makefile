# platforms = linux arm macOS windows
# ARCH = amd64 arm 386
#
# ${platforms}:
# 	echo $@

# k:
# 	echo k

APP=test_app
#posible OS: linux,darwin,windows

target Linux: TARGETOS=linux
target Linux: TARGETARCH=amd64
target arm: TARGETOS=linux
target arm: TARGETARCH=arm64
target macOS: TARGETOS=darwin
target macOS: TARGETARCH=arm64
target Windows:	TARGETOS=windows
target Windows: TARGETARCH=386

TARGETOS=linux
TARGETARCH=amd64

IMAGE_TAG = ${REGESTRY}${APP}:${VERSION}-${TARGETOS}

#posible ARCH: amd64,arm,386

#
VERSION=v1.0.0
#
REGESTRY=gcr.io/gke-test-416709/



VERSION=v1.0.0
#
REGESTRY=gcr.io/k8s-k3s-419002/

format: 
	gofmt -s -w ./

get:
	go get

build: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o ${APP}
	docker buildx build . -t ${REGESTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

Linux: format
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o ${APP}	

arm: format
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -v -o ${APP}
	
macOS: format
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -v -o ${APP}
	
Windows: format
	CGO_ENABLED=0 GOOS=windows GOARCH=386 go build -v -o ${APP}
	
image:
	docker build . -t ${REGESTRY}${APP}:${VERSION}-linux-amd64
	docker build . -t ${REGESTRY}${APP}:${VERSION}-linux-arm64
	docker build . -t ${REGESTRY}${APP}:${VERSION}-darwin-arm64
	docker build . -t ${REGESTRY}${APP}:${VERSION}-windows-386

clean: 
	rm -rf ${APP}
	docker rmi $(shell docker images --filter=reference="${REGESTRY}${APP}:${VERSION}-*" -q) -f