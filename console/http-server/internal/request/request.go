package request

import (
	"errors"
	"fmt"
	"io"
	"strconv"

	"me.mitul.http-server/internal/common"
	"me.mitul.http-server/internal/common/fieldline"
	"me.mitul.http-server/internal/common/message"
	"me.mitul.http-server/internal/common/statusline"
)

type ParserState string

const (
	StateInit    ParserState = "init"
	StateDone    ParserState = "done"
	StateLine    ParserState = "line"
	StateHeaders ParserState = "headers"
	StateBody    ParserState = "body"
	StateError   ParserState = "error"
)

type Request struct {
	ParserState ParserState
	StatusLine  statusline.RequestStatusLine
	FieldLine   fieldline.FieldLine
	Message     message.Message
}

func newRequest() *Request {
	return &Request{
		ParserState: StateInit,
		StatusLine:  *statusline.NewRequestStatus(),
		FieldLine:   *fieldline.NewFieldLine(),
		Message:     *message.NewMessage(),
	}
}

// func (r *Request) Print() {
// 	fmt.Printf("Request Status: %s\n", r.ParserState)

// 	fmt.Printf("Request Line:\n")
// 	fmt.Printf("> Method: %s\n", r.StatusLine.Method)
// 	fmt.Printf("> Path: %s\n", r.StatusLine.Resource)
// 	fmt.Printf("> Version: %s\n", r.StatusLine.HttpVersion)

// 	fmt.Printf("Request Headers:\n")
// 	for k, v := range r.FieldLine.Iter() {
// 		fmt.Printf("> %s: %s\n", k, v)
// 	}

// 	if r.Message.Length > 0 {
// 		fmt.Printf("Request Body:\n")
// 		fmt.Printf("> Length: %d\n", r.Message.Length)
// 		fmt.Printf("> Content: %s\n", string(r.Message.Content))
// 	}
// }

func (r *Request) done() bool {
	return r.ParserState == StateDone
}

func (r *Request) error() bool {
	return r.ParserState == StateError
}

func (r *Request) ContentLength(defaultValue int) int {
	v, ok := r.FieldLine.Get("Content-Length")
	if !ok {
		return defaultValue
	}
	i, err := strconv.Atoi(v)
	if err != nil {
		return defaultValue
	}
	return i
}

func (r *Request) parse(b []byte) (int, error) {
	read := 0
	err_str := ""

outer:
	for {
		switch r.ParserState {
		case StateInit:
			r.ParserState = StateLine

		case StateLine:
			n, err := r.StatusLine.Parse(b[read:])
			if err != nil || n == 0 {
				r.ParserState = StateError
				err_str = err.Error()
				break
			}
			read += n
			r.ParserState = StateHeaders

		case StateHeaders:
			n, done, err := r.FieldLine.Parse(b[read:])
			if err != nil {
				r.ParserState = StateError
				err_str = err.Error()
				break
			}
			if !done && n == 0 {
				r.ParserState = StateError
				err_str = "Unable to process all headers"
				break
			}
			read += n
			r.ParserState = StateBody

		case StateBody:
			if r.ContentLength(0) == 0 {
				r.ParserState = StateDone
				break
			}
			n, err := r.Message.Parse(b[read+len(common.CRLF):])
			if err != nil {
				r.ParserState = StateError
				err_str = err.Error()
				break
			}
			if n == 0 {
				r.ParserState = StateError
				err_str = "Unreachable point"
				break
			}
			read += n
			r.ParserState = StateDone

		case StateError:
			return 0, fmt.Errorf("[Request#parse]: %s", err_str)

		case StateDone:
			break outer
		}
	}

	return read, nil
}

func RequestFromReader(r io.Reader) (*Request, error) {
	req := newRequest()
	buffer := make([]byte, 1024)
	pos := 0

	for !req.done() && !req.error() {
		rn, err := r.Read(buffer[pos:])
		if err != nil {
			if errors.Is(err, io.EOF) {
				req.ParserState = StateDone
				break
			}
			return nil, err
		}
		pos += rn

		pn, err := req.parse(buffer[:pos])
		if err != nil {
			return nil, err
		}

		if pn < pos {
			copy(buffer, buffer[pn:pos])
		} else {
			copy(buffer, buffer[pn:])
		}
		pos -= pn
	}

	return req, nil
}
