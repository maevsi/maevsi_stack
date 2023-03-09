package body_forward_auth

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"log"
	"net/http"
)

// Config holds configuration to be passed to the plugin i.e. variables that come from the dockerfile
type Config struct {
	AuthUrl string
}

// CreateConfig populates the Config data object
func CreateConfig() *Config {
	return &Config{
		// Default values can be set here like
		// AuthUrl: "http://127.0.0.1",
	}
}

type BodyForwardAuth struct {
	next    http.Handler
	authUrl string
	name    string
}

// New instantiates and returns the required components used to handle an HTTP request
func New(ctx context.Context, next http.Handler, config *Config, name string) (http.Handler, error) {
	log.Printf("The body_forward_auth plugin was instantiated")
	log.Printf("The authentication URL is: %s", config.AuthUrl)
	if len(config.AuthUrl) == 0 {
		return nil, fmt.Errorf("AuthUrl cannot be empty")
	}

	return &BodyForwardAuth{
		next:    next,
		authUrl: config.AuthUrl,
		name:    name,
	}, nil
}

func (bfa *BodyForwardAuth) ServeHTTP(rw http.ResponseWriter, req *http.Request) {
	log.Printf("The ServeHTTP function was called. Will read the body now.")
	body, err := io.ReadAll(req.Body)
	if err != nil {
		http.Error(rw, err.Error(), http.StatusInternalServerError)
		log.Printf("Error while reading the body: %e\n", err)
	}

	httpClient := &http.Client{}
	proxyRequest, err := http.NewRequest(req.Method, bfa.authUrl, bytes.NewReader(body))
	if err != nil {
		http.Error(rw, err.Error(), http.StatusBadGateway)
		log.Printf("An error occured while creating the request: %e\n", err)
	}

	proxyRequest.Header = req.Header
	response, err := httpClient.Do(proxyRequest)
	if err != nil {
		http.Error(rw, err.Error(), http.StatusInternalServerError)
		log.Printf("An error occured while doing the request: %e", err)
	}

	responseBody, _ := io.ReadAll(response.Body)
	log.Printf("%s", responseBody)

	if response.StatusCode >= 200 && response.StatusCode < 300 {
		log.Printf("Got Response with status code: %d", response.StatusCode)
		req.Body = io.NopCloser(bytes.NewBuffer(body))
		bfa.next.ServeHTTP(rw, req)
	} else {
		log.Printf("Got response with status code: %d", response.StatusCode)
		http.Error(rw, response.Status, response.StatusCode)
		return
	}
}
