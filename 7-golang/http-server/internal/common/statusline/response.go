package statusline

import (
	"fmt"
	"io"
)

type StatusCode int

const (
	OK                  StatusCode = 200
	NoContent           StatusCode = 204
	BadRequest          StatusCode = 400
	NotFound            StatusCode = 404
	InternalServerError StatusCode = 500
)

type ResponseStatusLine struct {
	Protocol     string
	StatusCode   StatusCode
	StatusPhrase string
}

var (
	HttpStatusOK = &ResponseStatusLine{
		Protocol:     "HTTP/1.1",
		StatusCode:   OK,
		StatusPhrase: "OK",
	}
	HttpStatusNoContent = &ResponseStatusLine{
		Protocol:     "HTTP/1.1",
		StatusCode:   NoContent,
		StatusPhrase: "No Content",
	}
	HttpStatusBadRequest = &ResponseStatusLine{
		Protocol:     "HTTP/1.1",
		StatusCode:   BadRequest,
		StatusPhrase: "Bad Request",
	}
	HttpStatusNotFound = &ResponseStatusLine{
		Protocol:     "HTTP/1.1",
		StatusCode:   NotFound,
		StatusPhrase: "Not Found",
	}
	HttpStatusInternalServerError = &ResponseStatusLine{
		Protocol:     "HTTP/1.1",
		StatusCode:   InternalServerError,
		StatusPhrase: "Internal Server Error",
	}
)

func NewResponseStatus() *ResponseStatusLine {
	return new(ResponseStatusLine)
}

func (r *ResponseStatusLine) Write(w io.Writer) error {
	_, err := fmt.Fprintf(w, "%s %d %s\r\n", r.Protocol, r.StatusCode, r.StatusPhrase)
	if err != nil {
		return err
	}
	return nil
}
