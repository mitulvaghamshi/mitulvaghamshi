package statusline

import (
	"bytes"
	"fmt"
	"strings"

	"me.mitul.http-server/internal/common"
)

type RequestStatusLine struct {
	Method      string
	Resource    string
	HttpVersion string
}

var http_verbs = map[string]uint8{
	"GET":     0,
	"HEAD":    0,
	"POST":    0,
	"PUT":     0,
	"PATCH":   0,
	"DELETE":  0,
	"CONNECT": 0,
	"OPTIONS": 0,
	"TRACE":   0,
}

func NewRequestStatus() *RequestStatusLine {
	return new(RequestStatusLine)
}

func (sl *RequestStatusLine) Parse(b []byte) (int, error) {
	status_line, _, ok := bytes.Cut(b, common.CRLF)
	if !ok {
		return 0, fmt.Errorf("[StatusLine]: Missing: 'CRLF'")
	}

	parts := bytes.Split(status_line, []byte(" "))
	if len(parts) != 3 {
		return 0, fmt.Errorf("[StatusLine]: Length: (3 == %d)", len(status_line))
	}

	sl.Method = string(parts[0])
	sl.Resource = string(parts[1])
	sl.HttpVersion = string(parts[2])

	if err := sl.validate(); err != nil {
		return 0, fmt.Errorf("[StatusLine]: %s", err.Error())
	}

	return len(status_line) + len(common.CRLF), nil
}

func (sl *RequestStatusLine) validate() error {
	if _, ok := http_verbs[strings.ToUpper(sl.Method)]; !ok {
		return fmt.Errorf("Unrecognized Method: '%s'", sl.Method)
	}
	if sl.Resource[0] != '/' {
		return fmt.Errorf("Path should start with '/'")
	}
	if sl.HttpVersion != "HTTP/1.1" {
		return fmt.Errorf("Expected 'HTTP/1.1', got: %s", sl.HttpVersion)
	}
	return nil
}
