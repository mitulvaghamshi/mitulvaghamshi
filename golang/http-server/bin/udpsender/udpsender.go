package main

import (
	"bufio"
	"fmt"
	"log"
	"net"
	"os"
)

func main() {
	addr := net.UDPAddr{Port: 3001}
	conn, err := net.DialUDP(addr.Network(), nil, &addr)
	if err != nil {
		log.Fatalln(err)
	}
	defer conn.Close()

	reader := bufio.NewReader(os.Stdin)
	for {
		fmt.Print("(q to exit)> ")
		input, err := reader.ReadString('\n')
		if err != nil {
			log.Fatalln(err)
		}
		if input == "q\n" {
			break
		}
		fmt.Fprint(conn, input)
	}
}

// nc -u -l 3001
