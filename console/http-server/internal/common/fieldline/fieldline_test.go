package fieldline

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestSingleHeader(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host: localhost:3001\r\n\r\n")

	n, done, err := h.Parse(data)
	require.Nil(t, err)
	assert.True(t, done)
	assert.Equal(t, 22, n)
	if v, ok := h.Get("Host"); ok {
		assert.Equal(t, "localhost:3001", v)
	}
}

func TestMultipleHeaders(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host: localhost:3001\r\nAccept: */*\r\nContent-Length: 5\r\n\r\nHello")

	n, done, err := h.Parse(data)
	require.NoError(t, err)
	assert.True(t, done)
	assert.Equal(t, 54, n)
	if v, ok := h.Get("Host"); ok {
		assert.Equal(t, "localhost:3001", v)
	}
	if v, ok := h.Get("Accept"); ok {
		assert.Equal(t, "*/*", v)
	}
	if v, ok := h.Get("Content-Length"); ok {
		assert.Equal(t, "5", v)
	}
}

func TestMultipleHeaderValues1(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host: localhost:3001, localhost:3004\r\nAccept: */*\r\nContent-Length: 5\r\n\r\nHello")

	n, done, err := h.Parse(data)
	require.NoError(t, err)
	assert.True(t, done)
	assert.Equal(t, 70, n)
	if v, ok := h.Get("Host"); ok {
		assert.Equal(t, "localhost:3001,localhost:3004", v)
	}
	if v, ok := h.Get("Accept"); ok {
		assert.Equal(t, "*/*", v)
	}
	if v, ok := h.Get("Content-Length"); ok {
		assert.Equal(t, "5", v)
	}
}

func TestMultipleHeaderValues2(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host: localhost:3001\r\nHost: localhost:3004\r\nAccept: */*\r\nContent-Length: 5\r\n\r\nHello")

	n, done, err := h.Parse(data)
	require.NoError(t, err)
	assert.True(t, done)
	assert.Equal(t, 76, n)
	if v, ok := h.Get("Host"); ok {
		assert.Equal(t, "localhost:3001,localhost:3004", v)
	}
	if v, ok := h.Get("Accept"); ok {
		assert.Equal(t, "*/*", v)
	}
	if v, ok := h.Get("Content-Length"); ok {
		assert.Equal(t, "5", v)
	}
}

func TestUnexpectedSpace1(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host : localhost:3001\r\nAccept: */*\r\nContent-Length: 5\r\n\r\nHello")

	n, done, err := h.Parse(data)
	require.Error(t, err)
	assert.False(t, done)
	assert.Equal(t, 0, n)
}

func TestUnexpectedSpace2(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host: localhost:3001\r\n Accept: */*\r\nContent-Length: 5\r\n\r\nHello")

	n, done, err := h.Parse(data)
	require.Error(t, err)
	assert.False(t, done)
	assert.Equal(t, 0, n)
}

func TestMissingHeaderKey(t *testing.T) {
	h := NewFieldLine()
	data := []byte(": localhost:3001\r\nAccept: */*\r\nContent-Length: 5\r\n\r\nHello")

	n, done, err := h.Parse(data)
	require.Error(t, err)
	assert.False(t, done)
	assert.Equal(t, 0, n)
}

func TestMissingHeaderValue(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host: \r\nAccept: */*\r\nContent-Length: 5\r\n\r\nHello")

	n, done, err := h.Parse(data)
	require.Error(t, err)
	assert.False(t, done)
	assert.Equal(t, 0, n)
}

func TestEmptyHeader1(t *testing.T) {
	h := NewFieldLine()
	data := []byte("\r\n\r\n")

	n, done, err := h.Parse(data)
	require.NoError(t, err)
	assert.True(t, done)
	assert.Equal(t, 0, n)
}

func TestEmptyHeader2(t *testing.T) {
	h := NewFieldLine()
	data := []byte("\r\n")

	n, done, err := h.Parse(data)
	require.NoError(t, err)
	assert.True(t, done)
	assert.Equal(t, 0, n)
}

func TestEmptyHeader3(t *testing.T) {
	h := NewFieldLine()
	data := []byte("")

	n, done, err := h.Parse(data)
	require.Error(t, err)
	assert.False(t, done)
	assert.Equal(t, 0, n)
}

func TestInvalidSeparator1(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host: localhost:3001\nAccept: */*\r\n\r\nHello")

	n, done, err := h.Parse(data)
	require.Error(t, err)
	assert.False(t, done)
	assert.Equal(t, 0, n)
}

func TestInvalidSeparator2(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host: localhost:3001\rAccept: */*\r\n\r\nHello")

	n, done, err := h.Parse(data)
	require.Error(t, err)
	assert.False(t, done)
	assert.Equal(t, 0, n)
}

func TestInvalidSeparator3(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host: localhost:3001\r\nAccept: */*\r\nHello")

	n, done, err := h.Parse(data)
	require.Error(t, err)
	assert.False(t, done)
	assert.Equal(t, 0, n)
}

func TestInvalidSeparator4(t *testing.T) {
	h := NewFieldLine()
	data := []byte("Host:localhost:3001\r\nAccept */*\r\nHello")

	n, done, err := h.Parse(data)
	require.Error(t, err)
	assert.False(t, done)
	assert.Equal(t, 0, n)
}

func TestInvalidHeaderKey(t *testing.T) {
	h := NewFieldLine()
	data := []byte("H@ost:localhost:3001\r\n")

	_, done, err := h.Parse(data)
	require.Error(t, err)
	assert.False(t, done)
}
