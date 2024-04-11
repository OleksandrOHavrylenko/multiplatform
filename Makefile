platforms = linux arm macOS windows
# ARCH = amd64 arm 386
#
# ${platforms}:
# 	echo $@

# k:
# 	echo k

APP=test_app
#posible OS: linux,darwin,windows

target linux: TARGETOS=linux
target linux: TARGETARCH=amd64
target arm: TARGETOS=linux
target arm: TARGETARCH=arm64
target macOS: TARGETOS=darwin
target macOS: TARGETARCH=arm64
target windows:	TARGETOS=windows
target windows: TARGETARCH=386

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

image:
	docker buildx build --platform ${TARGETOS}/${TARGETARCH} . -t ${REGESTRY}${APP}:${VERSION}-${TARGETOS}

${platforms}: build

push:
	docker push ${REGESTRY}${APP}:${VERSION}-${TARGETOS}
	
clean: 
	rm -rf ${APP}
	docker rmi ${REGESTRY}${APP}:${VERSION}-${TARGETOS}