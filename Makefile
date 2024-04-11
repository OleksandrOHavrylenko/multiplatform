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
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o ${APP}
	docker buildx build . -t ${REGESTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

arm: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o ${APP}
	docker buildx build . -t ${REGESTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

macOS: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o ${APP}
	docker buildx build . -t ${REGESTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

Windows: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o ${APP}
	docker buildx build . -t ${REGESTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

clean: 
	rm -rf ${APP}
	docker rmi $(shell docker images --filter=reference="${REGESTRY}${APP}:${VERSION}-*" -q) -f