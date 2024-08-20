package server

import (
	"io"
	"log"
	"net"

	"me.mitul.http-server/internal/common/statusline"
	"me.mitul.http-server/internal/request"
	"me.mitul.http-server/internal/response"
)

type ServerState string

const (
	ServerWaiting ServerState = "waiting"
	ServerRunning ServerState = "running"
	ServerStopped ServerState = "stopped"
)

type Handler func(req *request.Request, res *response.Response) error

type Server struct {
	State     ServerState
	handler   Handler
	middlware []Handler
	listener  net.Listener
}

func (s *Server) Close() error {
	log.Println("Server Shutting Down...!")
	s.State = ServerStopped
	return nil
}

func (sv *Server) Use(m func() Handler) {
	sv.middlware = append(sv.middlware, m())
}

func Serve(port uint16, handler Handler) (*Server, error) {
	addr := net.TCPAddr{Port: int(port), IP: net.IPv6loopback}
	listener, err := net.ListenTCP(addr.Network(), &addr)
	if err != nil {
		return nil, err
	}

	sv := &Server{
		State:    ServerWaiting,
		handler:  handler,
		listener: listener,
	}
	go sv.listen()
	sv.State = ServerRunning

	return sv, nil
}

func (sv *Server) listen() {
	defer sv.listener.Close()

	for {
		conn, err := sv.listener.Accept()
		if err != nil {
			if sv.State == ServerStopped {
				return
			}
			log.Printf("Error accepting connection: %#v", err)
			continue
		}
		go sv.handle(conn)
	}
}

func (sv *Server) handle(rw io.ReadWriteCloser) {
	defer rw.Close()

	res := response.NewResponse(rw)

	req, err := request.RequestFromReader(rw)
	if err != nil {
		log.Printf("400 Bad Request: %s", err.Error())
		res.SendStatus(statusline.BadRequest)
		return
	}

	for _, m := range sv.middlware {
		go m(req, res)
	}

	err = sv.handler(req, res)
	if err != nil {
		log.Printf("500 Internal Server Error: %s", err.Error())
		res.SendStatus(statusline.InternalServerError)
		return
	}
}
