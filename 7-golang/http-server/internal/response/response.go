package response

import (
	"fmt"
	"io"
	"log"

	"me.mitul.http-server/internal/common/fieldline"
	"me.mitul.http-server/internal/common/message"
	"me.mitul.http-server/internal/common/statusline"
)

type Response struct {
	StatusLine statusline.ResponseStatusLine
	FieldLine  fieldline.FieldLine
	Message    message.Message
	Writer     io.Writer
}

func NewResponse(writer io.Writer) *Response {
	return &Response{
		StatusLine: *statusline.NewResponseStatus(),
		FieldLine:  *fieldline.NewFieldLine(),
		Message:    *message.NewMessage(),
		Writer:     writer,
	}
}

func (r *Response) SetStatus(s statusline.StatusCode) {
	switch s {

	case statusline.OK:
		r.StatusLine = *statusline.HttpStatusOK

	case statusline.NoContent:
		r.StatusLine = *statusline.HttpStatusNoContent

	case statusline.BadRequest:
		r.StatusLine = *statusline.HttpStatusBadRequest

	case statusline.NotFound:
		r.StatusLine = *statusline.HttpStatusNotFound

	case statusline.InternalServerError:
		r.StatusLine = *statusline.HttpStatusInternalServerError

	}
}

func (r *Response) SetHeader(k string, v string) {
	r.FieldLine.Set(k, v)
}

func (r *Response) SetBody(b []byte) {
	r.Message.Parse(b)
}

func (r *Response) WriteStatus() error {
	err := r.StatusLine.Write(r.Writer)
	if err != nil {
		log.Fatalf("Error writing status: %s", err.Error())
		return err
	}
	return nil
}

func (r *Response) WriteHeaders() error {
	err := r.FieldLine.Write(r.Writer)
	if err != nil {
		log.Fatalf("Error writing headers: %s", err.Error())
		return err
	}
	return nil
}

func (r *Response) WriteBody(b []byte) (int, error) {
	n, err := r.Writer.Write(b)
	if err != nil {
		log.Fatalf("Error writing body: %s", err.Error())
		return 0, err
	}
	return n, nil
}

func (r *Response) Send() (int, error) {
	r.WriteStatus()
	r.WriteHeaders()
	n, err := r.WriteBody(r.Message.Content)
	return n, err
}

func (r *Response) SendStatus(s statusline.StatusCode) {
	r.SetStatus(s)

	if r.Message.Length == 0 {
		r.SetBody(fmt.Appendf(nil, "%d %s", r.StatusLine.StatusCode, r.StatusLine.StatusPhrase))
	}

	if _, ok := r.FieldLine.Get("Content-Type"); !ok {
		r.SetHeader("Content-Type", "text/plain")
	}
	r.SetHeader("Connection", "close")
	r.SetHeader("Server", "GoHttpServer/v1.0")
	r.SetHeader("Content-Length", fmt.Sprint(r.Message.Length))

	r.Send()
}
