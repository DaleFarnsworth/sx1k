// Copyright 2020 Dale Farnsworth. All rights reserved.

// Dale Farnsworth
// 1007 W Mendoza Ave
// Mesa, AZ  85210
// USA
//
// dale@farnsworth.org

// This program is free software: you can redistribute it and/or modify
// it under the terms of version 3 of the GNU General Public License
// as published by the Free Software Foundation.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strconv"
	"syscall"
	"time"

	"github.com/dalefarnsworth/go-xmodem/xmodem"
	"github.com/pkg/term"
)

const (
	versionMajor = 1
	versionMinor = 1

	uploadTimeout = 10 * time.Second

	buflen = 16 * 1024
)

var progname string

func xmodemSend1K(term *term.Term, data []byte) {
	term.Flush()

	term.SetReadTimeout(uploadTimeout)
	counter := 0
	previousBlock := -1
	callback := func(block int) {
		if counter%40 == 0 {
			if counter != 0 {
				fmt.Fprint(os.Stderr, "\n")
			}
		}
		marker := "."
		if block != previousBlock+1 {
			marker = "R"
		}
		fmt.Fprint(os.Stderr, marker)
		counter++
		previousBlock = block
	}
	err := xmodem.ModemSend1K(term, data, callback)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Fprintln(os.Stderr, "\nTransfer complete.")

	term.Flush()
}

func usage(strs ...string) {
	if len(strs) > 0 {
		for _, str := range strs {
			fmt.Fprintln(os.Stderr, str)
		}
		fmt.Fprintln(os.Stderr)
	}
	fmt.Fprintf(os.Stderr, "Usage: %s <file_to_send> [devname [baud]]\n", progname)
	fmt.Fprintf(os.Stderr, "  or   %s --help\n", progname)
	fmt.Fprintf(os.Stderr, "  or   %s --version\n", progname)
	os.Exit(1)
}

func help() {
	help := `
This program sends xmodem 1k packets using stdin/stdout.

    Usage: %s <file_to_send> [devname [baud]]
      or   %s --help
      or   %s --version

where <file_to_send> is the name of the file to be sent via xmodem,
devname is the optional serial device name, and
baud is the desired baud rate.`

	fmt.Printf(help, progname, progname, progname)
	fmt.Println()
}

func version() {
	fmt.Printf("%s version %d.%d\n", progname, versionMajor, versionMinor)
}

func main() {
	progname = filepath.Base(os.Args[0])
	log.SetPrefix(progname + ": ")
	log.SetFlags(log.Lshortfile)

	nArgs := len(os.Args)

	if nArgs < 2 || nArgs > 4 {
		usage()
	}

	if nArgs == 2 {
		switch os.Args[1] {
		case "-h", "--help":
			help()
			os.Exit(0)

		case "-v", "--version":
			version()
			os.Exit(0)
		}
	}

	filename := os.Args[1]

	devName := ""
	if nArgs > 2 {
		devName = os.Args[2]
	}

	baud := 0
	if nArgs == 4 {
		baudString := os.Args[3]
		var err error
		baud, err = strconv.Atoi(baudString)
		if err != nil {
			usage("Unrecognized baud: %s\n", baudString)
		}
	}

	var t *term.Term
	var err error
	if devName != "" {
		t, err = term.Open(devName, term.RawMode)
	} else {
		t, err = term.OpenFD(syscall.Stdin, term.RawMode)
	}
	if err != nil {
		usage(err.Error())
	}
	defer t.Close()

	if baud != 0 {
		t.SetSpeed(baud)
	}

	data, err := ioutil.ReadFile(filename)
	if err != nil {
		usage(err.Error())
	}

	xmodemSend1K(t, data)

	t.Restore()
}
