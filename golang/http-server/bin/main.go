package main

import (
	"fmt"

	"me.mitul.http-server/internal/common/message"
)

func main() {
	m := message.NewMessage()
	data := []byte("Hello World\nJello Xorld")
	n, err := m.Parse(data)
	if err != nil {
		fmt.Printf("%s", err.Error())
	}
	fmt.Printf("Parsed: %d of %d bytes\n", n, len(data))
	fmt.Printf("Body: L%d of D%d bytes\n", m.Length, len(m.Content))
	fmt.Printf("Body: [%s]", string(m.Content))
}
