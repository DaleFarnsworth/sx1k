FLAGS = -ldflags "-s -w"

default: linux/amd64/sx1k

all: darwin/amd64/sx1k linux/386/sx1k linux/amd64/sx1k linux/arm/sx1k linux/arm64/sx1k linux/ppc64/sx1k linux/ppc64le/sx1k linux/riscv64/sx1k linux/s390x/sx1k

darwin/amd64/sx1k: main.go
	GOOS=darwin GOARCH=amd64 go build $(FLAGS) -o darwin/amd64/sx1k

linux/386/sx1k: main.go
	GOOS=linux GOARCH=386 go build $(FLAGS) -o linux/386/sx1k

linux/amd64/sx1k: main.go
	GOOS=linux GOARCH=amd64 go build $(FLAGS) -o linux/amd64/sx1k
	upx --brute linux/amd64/sx1k

linux/arm/sx1k: main.go
	GOOS=linux GOARCH=arm go build $(FLAGS) -o linux/arm/sx1k

linux/arm64/sx1k: main.go
	GOOS=linux GOARCH=arm64 go build $(FLAGS) -o linux/arm64/sx1k

linux/ppc64/sx1k: main.go
	GOOS=linux GOARCH=ppc64 go build $(FLAGS) -o linux/ppc64/sx1k

linux/ppc64le/sx1k: main.go
	GOOS=linux GOARCH=ppc64le go build $(FLAGS) -o linux/ppc64le/sx1k

linux/riscv64/sx1k: main.go
	GOOS=linux GOARCH=riscv64 go build $(FLAGS) -o linux/riscv64/sx1k

linux/s390x/sx1k: main.go
	GOOS=linux GOARCH=s390x go build $(FLAGS) -o linux/s390x/sx1k
