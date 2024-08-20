package request

import (
	"io"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// GET / HTTP/1.1
// Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
// Accept-Encoding: gzip, deflate, br, zstd
// Accept-Language: en-US,en;q=0.9
// Cache-Control: no-cache
// Connection: keep-alive
// DNT: 1
// Host: localhost:3001
// Pragma: no-cache
// Sec-Fetch-Dest: document
// Sec-Fetch-Mode: navigate
// Sec-Fetch-Site: none
// Sec-Fetch-User: ?1
// Upgrade-Insecure-Requests: 1
// User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36
// sec-ch-ua: "Google Chrome";v="147", "Not.A/Brand";v="8", "Chromium";v="147"
// sec-ch-ua-mobile: ?0
// sec-ch-ua-platform: "macOS"

type ChunkReader struct {
	Data  string
	Chunk int
	Pos   int
}

func (cr *ChunkReader) Read(b []byte) (n int, err error) {
	if cr.Pos >= len(cr.Data) {
		return 0, io.EOF
	}

	end_position := min(cr.Pos+cr.Chunk, len(cr.Data))
	n = copy(b, cr.Data[cr.Pos:end_position])
	cr.Pos += n

	if n > cr.Chunk {
		n = cr.Chunk
		cr.Pos -= n - cr.Chunk
	}

	return n, nil
}

func TestRequestLineParse(t *testing.T) {
	// Test: Get RequestLine
	var reader = &ChunkReader{
		Data:  "GET / HTTP/1.1\r\nHost: localhost:3001\r\nUser-Agent: curl/8.7.1\r\nAccept: */*\r\nContent-Length: 5\r\n\r\nHello",
		Chunk: 1024,
	}
	var req, err = RequestFromReader(reader)
	require.NotNil(t, req)
	require.NoError(t, err)
	assert.Equal(t, "GET", req.StatusLine.Method)
	assert.Equal(t, "/", req.StatusLine.Resource)
	assert.Equal(t, "HTTP/1.1", req.StatusLine.HttpVersion)
	if v, ok := req.FieldLine.Get("Host"); ok {
		assert.Equal(t, "localhost:3001", v)
	}
	if v, ok := req.FieldLine.Get("Accept"); ok {
		assert.Equal(t, "*/*", v)
	}
	if v, ok := req.FieldLine.Get("User-Agent"); ok {
		assert.Equal(t, "curl/8.7.1", v)
	}
	if v, ok := req.FieldLine.Get("Content-Length"); ok {
		assert.Equal(t, "5", v)
	}

	// Test: Get RequestLine with path
	reader = &ChunkReader{
		Data:  "GET /coffie HTTP/1.1\r\nHost: localhost:3001\r\nUser-Agent: curl/8.7.1\r\nAccept: */*\r\nContent-Length: 0\r\n\r\n",
		Chunk: 1024,
	}
	req, err = RequestFromReader(reader)
	require.NotNil(t, req)
	require.NoError(t, err)
	assert.Equal(t, "GET", req.StatusLine.Method)
	assert.Equal(t, "/coffie", req.StatusLine.Resource)
	assert.Equal(t, "HTTP/1.1", req.StatusLine.HttpVersion)

	// Test: Get RequestLine with invalid target/path
	reader = &ChunkReader{
		Data:  "POST cats HTTP/1.1\r\nHost: localhost:3001\r\nUser-Agent: curl/8.7.1\r\nAccept: */*\r\nContent-Length: 18\r\n\r\n{'name': 'Cat101'}",
		Chunk: 1024,
	}
	req, err = RequestFromReader(reader)
	require.Nil(t, req)
	require.Error(t, err)

	// Test: Get RequestLine with invalid method
	reader = &ChunkReader{
		Data:  "STORE / HTTP/1.1\r\nHost: localhost:3001\r\nUser-Agent: curl/8.7.1\r\nAccept: */*\r\nContent-Length: 0\r\n\r\n",
		Chunk: 1024,
	}
	req, err = RequestFromReader(reader)
	require.Nil(t, req)
	require.Error(t, err)

	// Test: Get RequestLine with invalid version
	reader = &ChunkReader{
		Data:  "GET /coffie HTTP/1.0\r\nHost: localhost:3001\r\nUser-Agent: curl/8.7.1\r\nAccept: */*\r\nContent-Length: 0\r\n\r\n",
		Chunk: 1024,
	}
	req, err = RequestFromReader(reader)
	require.Nil(t, req)
	require.Error(t, err)

	// Test: Get RequestLine with invalid separator
	reader = &ChunkReader{
		Data:  "GET /coffie HTTP/1.0\nHost: localhost:3001\nUser-Agent: curl/8.7.1\nAccept: */*\nContent-Length: 0\n\n",
		Chunk: 1024,
	}
	req, err = RequestFromReader(reader)
	require.Nil(t, req)
	require.Error(t, err)

	// Test: Missing part in RequestLine.
	reader = &ChunkReader{
		Data:  "/cats HTTP/1.1\r\nHost: localhost:3001\r\nUser-Agent: curl/8.7.1\r\nAccept: */*\r\nContent-Length: 0\r\n\r\n",
		Chunk: 1024,
	}
	req, err = RequestFromReader(reader)
	require.Nil(t, req)
	require.Error(t, err)
}

func TestRequestLineParse2(t *testing.T) {
	// Test: Unexpected spaces in RequestLine.
	var reader = &ChunkReader{
		Data:  `GET /cats HTTP/1.1\r\n Host: localhost:3001\r\nUser-Agent   : curl/8.7.1\r\n    Accept: */*\r\n			Content-Length			:			\s\s\s\s\s 0\r\n\r\n`,
		Chunk: 1024,
	}
	req, err := RequestFromReader(reader)
	require.Nil(t, req)
	require.Error(t, err)
}
