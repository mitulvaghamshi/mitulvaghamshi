package fieldline

import (
	"bytes"
	"fmt"
	"io"
	"net/http"
	"strings"

	"me.mitul.http-server/internal/common"
)

type FieldLine struct {
	headers map[string]string
}

func NewFieldLine() *FieldLine {
	return &FieldLine{
		headers: make(map[string]string),
	}
}

func (fl *FieldLine) Get(key string) (string, bool) {
	k := http.CanonicalHeaderKey(key)
	v, ok := fl.headers[k]
	return v, ok
}

func (fl *FieldLine) Set(key string, value string) {
	k := http.CanonicalHeaderKey(key)
	fl.headers[k] = strings.TrimSpace(value)
}

func (fl *FieldLine) Del(key string) {
	k := http.CanonicalHeaderKey(key)
	delete(fl.headers, k)
}

func (fl *FieldLine) Add(key string, value string) {
	k := http.CanonicalHeaderKey(key)
	v := strings.TrimSpace(value)
	if o, ok := fl.headers[k]; ok {
		fl.headers[k] = fmt.Sprintf("%s,%s", o, v)
	} else {
		fl.headers[k] = value
	}
}

func (fl *FieldLine) Write(w io.Writer) error {
	var err error = nil

	for k, v := range fl.headers {
		_, err = fmt.Fprintf(w, "%s: %s\r\n", k, v)
	}
	_, err = fmt.Fprint(w, "\r\n")

	return err
}

func (fl FieldLine) Parse(b []byte) (int, bool, error) {
	n := 0
	done := false

	for {
		pos := bytes.Index(b, common.CRLF)
		if pos == -1 {
			return 0, false, fmt.Errorf("[Headers]: Missing 'CRLF'")
		}
		if pos == 0 {
			done = true
			break
		}

		k, v, err := parse_header_line(b[:pos])
		if err != nil {
			return 0, false, err
		}

		if b, c := validate_key(k); !b {
			return 0, false, fmt.Errorf("[Headers]: Unexpected key char: %s", string(c))
		}

		v = bytes.ReplaceAll(v, []byte(" "), []byte(""))

		fl.Add(string(k), string(v))
		n += pos + len(common.CRLF)
		b = b[pos+len(common.CRLF):]
	}

	return n, done, nil
}

func parse_header_line(b []byte) ([]byte, []byte, error) {
	if bytes.ContainsAny(b, string(common.CRLF)) {
		return nil, nil, fmt.Errorf("[Headers]: Unexpected byte of: [\\n, \\r]")
	}

	key, value, ok := bytes.Cut(b, []byte(":"))
	if !ok {
		return nil, nil, fmt.Errorf("[Headers]: Split at ':', K(%s), V(%s)", key, value)
	}

	if bytes.Contains(key, []byte(" ")) {
		return nil, nil, fmt.Errorf("[Headers]: Invalid space in key value, K(%s)", key)
	}

	value = bytes.TrimSpace(value)

	if len(key) <= 0 || len(value) <= 0 {
		return nil, nil, fmt.Errorf("[Headers]: Missing key or value, K(%s), V(%s)", key, value)
	}

	return key, value, nil
}

func validate_key(b []byte) (bool, byte) {
	for _, v := range b {
		is_valid := false
		if (v >= '0' && v <= '9') || (v >= 'A' && v <= 'Z') || (v >= 'a' && v <= 'z') {
			is_valid = true
		}
		switch v {
		case '!', '#', '$', '%', '&', '\'', '*', '+', '-', '.', '^', '_', '`', '|', '~':
			is_valid = true
		}
		if !is_valid {
			return false, v
		}
	}
	return true, 0
}
