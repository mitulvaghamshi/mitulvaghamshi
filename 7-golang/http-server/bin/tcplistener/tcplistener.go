package main

import (
	"bytes"
	"fmt"
	"io"
	"log"
	"net"
)

func main() {
	addr := net.TCPAddr{Port: 3001}
	ln, err := net.ListenTCP(addr.Network(), &addr)
	if err != nil {
		log.Fatalln(err)
	}
	defer ln.Close()

	for {
		conn, err := ln.AcceptTCP()
		if err != nil {
			log.Fatalln(err)
		}
		for line := range getLinesChannel(conn) {
			fmt.Println(line)
		}
	}
}

func getLinesChannel(r io.ReadCloser) <-chan string {
	out := make(chan string, 1)

	go func() {
		defer r.Close()
		defer close(out)

		var content = ""

		for {
			buffer := make([]byte, 8)
			n, err := r.Read(buffer)
			if err != nil {
				break
			}

			buffer = buffer[:n]
			if i := bytes.IndexByte(buffer, '\n'); i != -1 {
				content += string(buffer[:i])
				buffer = buffer[i+1:]
				out <- content
				content = ""
			}

			content += string(buffer)
		}

		if len(content) != 0 {
			out <- content
		}
	}()

	return out
}

// nc -v localhost 3001
// echo -e "GET /stream/100 HTTP/1.1\r\nHost: localhost:3001\r\nConnection: close\r\n\r\n" | nc -v localhost 3001
