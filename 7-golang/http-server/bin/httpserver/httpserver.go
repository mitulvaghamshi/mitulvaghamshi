package main

import (
	"crypto/sha256"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"strings"
	"syscall"

	"me.mitul.http-server/internal/common/statusline"
	"me.mitul.http-server/internal/request"
	"me.mitul.http-server/internal/response"
	"me.mitul.http-server/internal/server"
)

const PORT = 3001

func main() {
	sv, err := server.Serve(PORT, handler)
	if err != nil {
		log.Fatalf("Unable to start server: %s", err.Error())
	}
	defer sv.Close()

	sv.Use(logger)
	log.Println("Server listening at port", PORT)

	sig_chan_buff := make(chan os.Signal, 1)
	signal.Notify(sig_chan_buff, syscall.SIGINT, syscall.SIGTERM)
	<-sig_chan_buff
}

func logger() server.Handler {
	file, err := os.CreateTemp("./logs/", "log-*.log")
	if err != nil {
		log.Println("Logging live...")
	} else {
		log.Println("Logging to file...")
		log.SetOutput(file)
	}
	return func(req *request.Request, res *response.Response) error {
		log.Printf("%-7s %s\n", req.StatusLine.Method, req.StatusLine.Resource)
		return nil
	}
}

func handler(req *request.Request, res *response.Response) error {
	if p, ok := strings.CutPrefix(req.StatusLine.Resource, "/stream/"); ok {
		if len(p) <= 0 {
			res.SendStatus(statusline.BadRequest)
			return nil
		}

		n, err := strconv.Atoi(p)
		if err != nil {
			res.SendStatus(statusline.BadRequest)
			return nil
		}

		hres, herr := http.Get(fmt.Sprintf("https://httpbin.org/stream/%d", n))
		if herr != nil {
			return herr
		}

		res.SetStatus(statusline.OK)
		res.WriteStatus()

		res.SetHeader("Server", "GoHttpServer/v1.0")
		res.SetHeader("Connection", "keep-alive")
		res.SetHeader("Content-Type", "text/plain")
		res.SetHeader("Transfer-Encoding", "chunked")
		res.FieldLine.Add("Trailer", "X-Content-Length")
		res.FieldLine.Add("Trailer", "X-Content-SHA256")
		res.WriteHeaders()

		the_body := []byte{}
		for {
			buffer := make([]byte, 32)
			n, err := hres.Body.Read(buffer)
			if err != nil {
				break
			}
			the_body = append(the_body, buffer...)
			res.WriteBody(fmt.Appendf(nil, "%x\r\n", n))
			res.WriteBody(fmt.Append(buffer[:n], "\r\n"))
		}
		res.WriteBody([]byte("0\r\n"))

		res.FieldLine.Del("Server")
		res.FieldLine.Del("Connection")
		res.FieldLine.Del("Content-Type")
		res.FieldLine.Del("Transfer-Encoding")
		res.FieldLine.Del("Trailer")
		res.SetHeader("X-Content-Length", fmt.Sprint(len(the_body)))
		res.SetHeader("X-Content-SHA256", fmt.Sprintf("%x", sha256.Sum256(the_body)))
		res.WriteHeaders() // Treailers
		res.WriteBody([]byte("0\r\n"))

		return nil
	}

	switch req.StatusLine.Resource {

	case "/ping":
		res.SetBody([]byte("pong\r\n"))
		res.SendStatus(statusline.OK)

	case "/echo":
		if req.Message.Length == 0 {
			res.SendStatus(statusline.NoContent)
		} else {
			res.SetBody(req.Message.Content)
			res.SetBody([]byte("\r\n"))
			res.SendStatus(statusline.OK)
		}

	case "/video":
		vf, err := os.ReadFile("static/sample.mp4")
		if err != nil {
			return err
		}
		res.SetStatus(statusline.OK)
		res.WriteStatus()

		res.SetHeader("Connection", "keep-alive")
		res.SetHeader("Content-Type", "video/mp4")
		res.SetHeader("Content-Length", fmt.Sprint(len(vf)))
		res.WriteHeaders()

		res.WriteBody(vf)
		res.WriteBody([]byte("\r\n"))

	case "/index.html":
		index, err := os.ReadFile("static/index.html")
		if err != nil {
			return err
		}
		res.SetBody(index)
		res.SetBody([]byte("\r\n"))
		res.SetHeader("Content-Type", "text/html")
		res.SendStatus(statusline.OK)

	default:
		_404, err := os.ReadFile("static/404.html")
		if err != nil {
			return err
		}
		res.SetBody(_404)
		res.SetBody([]byte("\r\n"))
		res.SetHeader("Content-Type", "text/html")
		res.SendStatus(statusline.NotFound)
	}

	return nil
}
