package main

import (
    "bufio"
    "encoding/json"
    "flag"
    "fmt"
    "net/http"
    "os"
    "strings"
)

type AWSInstanceMetaData interface{}
var key string

func init() {
    flag.StringVar(&key, "key", "", "key to fetch")
}

func getMetaData(url string) AWSInstanceMetaData {
    metadata := make(map[string]interface{})
    rawdata := fetchData(url)
    // Loop over top level items
    for _, item := range rawdata {
        switch {
        // Recurse for child items
        case strings.HasSuffix(item, "/"):
            metadata[item[:len(item)-1]] = getMetaData(url + item)
        default:
            metadata[item] = fetchData(url + item)[0]
        }
    }

    return metadata
}

func fetchData(url string) []string {
    response, err := http.Get(url)
    if err != nil {
        fmt.Printf("Error during metadata request: %v\n", err)
        os.Exit(1)
    }
    defer response.Body.Close()

    reader := bufio.NewReader(response.Body)
    metadata := make([]string, 0)
    for {
        item, err := reader.ReadString('\n')
        metadata = append(metadata, strings.TrimRight(item, "\n"))
        if err != nil {
            break
        }
    }
    return metadata
}

func main() {
    flag.Parse()
    metadataURL := "http://169.254.169.254/latest/meta-data/"
    var metadata AWSInstanceMetaData
    if key != "" {
        metadata = getMetaData(metadataURL + key)
    } else {
        metadata = getMetaData(metadataURL)
    }
    data, err := json.Marshal(metadata)

    if err != nil {
        fmt.Printf("Error: %v\n", err)
        os.Exit(1)
    }

    os.Stdout.Write(data)
    fmt.Println()
}