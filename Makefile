FLAGS = -ldflags "-s -w"

default: linux/amd64/sx1k

all:darwin/386/sx1k darwin/amd64/sx1k darwin/arm/sx1k darwin/arm64/sx1k linux/386/sx1k linux/amd64/sx1k linux/arm/sx1k linux/arm64/sx1k linux/mips/sx1k linux/mips64/sx1k linux/mips64le/sx1k linux/mipsle/sx1k linux/ppc64/sx1k linux/ppc64le/sx1k linux/riscv64/sx1k linux/s390x/sx1k

darwin/386/sx1k: main.go
	GOOS=darwin ARCH=386 go build $(FLAGS) -o darwin/386/sx1k

darwin/amd64/sx1k: main.go
	GOOS=darwin ARCH=amd64 go build $(FLAGS) -o darwin/amd64/sx1k

darwin/arm/sx1k: main.go
	GOOS=darwin ARCH=arm go build $(FLAGS) -o darwin/arm/sx1k

darwin/arm64/sx1k: main.go
	GOOS=darwin ARCH=arm64 go build $(FLAGS) -o darwin/arm64/sx1k

linux/386/sx1k: main.go
	GOOS=linux ARCH=386 go build $(FLAGS) -o linux/386/sx1k

linux/amd64/sx1k: main.go
	GOOS=linux ARCH=amd64 go build $(FLAGS) -o linux/amd64/sx1k
	upx --brute linux/amd64/sx1k

linux/arm/sx1k: main.go
	GOOS=linux ARCH=arm go build $(FLAGS) -o linux/arm/sx1k

linux/arm64/sx1k: main.go
	GOOS=linux ARCH=arm64 go build $(FLAGS) -o linux/arm64/sx1k

linux/mips/sx1k: main.go
	GOOS=linux ARCH=mips go build $(FLAGS) -o linux/mips/sx1k

linux/mips64/sx1k: main.go
	GOOS=linux ARCH=mips64 go build $(FLAGS) -o linux/mips64/sx1k

linux/mips64le/sx1k: main.go
	GOOS=linux ARCH=mips64le go build $(FLAGS) -o linux/mips64le/sx1k

linux/mipsle/sx1k: main.go
	GOOS=linux ARCH=mipsle go build $(FLAGS) -o linux/mipsle/sx1k

linux/ppc64/sx1k: main.go
	GOOS=linux ARCH=ppc64 go build $(FLAGS) -o linux/ppc64/sx1k

linux/ppc64le/sx1k: main.go
	GOOS=linux ARCH=ppc64le go build $(FLAGS) -o linux/ppc64le/sx1k

linux/riscv64/sx1k: main.go
	GOOS=linux ARCH=riscv64 go build $(FLAGS) -o linux/riscv64/sx1k

linux/s390x/sx1k: main.go
	GOOS=linux ARCH=s390x go build $(FLAGS) -o linux/s390x/sx1k
