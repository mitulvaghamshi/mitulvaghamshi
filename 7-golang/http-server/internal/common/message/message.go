package message

import (
	"fmt"
	"io"
)

type Message struct {
	Length  int
	Content []byte
}

func NewMessage() *Message {
	return new(Message)
}

func (m *Message) Write(w io.Writer) (int, error) {
	n, err := fmt.Fprint(w, string(m.Content))
	if err != nil {
		return 0, err
	}
	return n, nil
}

func (m *Message) Parse(b []byte) (int, error) {
	m.Content = append(m.Content, b...)
	m.Length = len(m.Content)
	return m.Length, nil
	// for len(b) > 0 {
	// 	line, rest, ok := bytes.Cut(b, common.CRLF)
	// 	if len(line) > 0 {
	// 		fmt.Fprint(buffer, string(line))
	// 		n += len(line)
	// 		b = rest
	// 	}
	// 	if ok {
	// 		fmt.Fprint(buffer, string("\n"))
	// 		n += 1
	// 	}
	// }
}
