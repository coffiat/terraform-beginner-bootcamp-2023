
// Package Declaration: In Go, there are two types of packages: executable and non-executable.
// The package main declaration indicates that this Go file is intended to create an executable program, not a reusable library.
// In Go, the main package is a special package, and it's the entry point for running an executable program.
// When you create a Go executable, it should always be in the main package.
package main

// fmt is short format, it contains functions for formated I/O.
import (
	//"log"
	"fmt"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

// func main(): Defines the main function, the entry point of the application.
// when you run the program, it starts executing from this function.

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,
	})
	// format Printline
	// Prints to standard output.
	fmt.Println("Hello, world!")
}

// in golang, a titlecase function will get exported
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{

		ResourcesMap: map[string]*schema.Resource{},

		DataSourcesMap: map[string]*schema.Resource{},

		Schema: map[string]*schema.Schema{

			"endpoint": {
				Type:        schema.TypeString,
				Required:    true,
				Description: "The endpoint for the external service",
			},
			"token": {
				Type:        schema.TypeString,
				Sensitive:   true, // make the token as sensitive to hide it the logs
				Required:    true,
				Description: "Bearer token for authorization",
			},
			"user_uuid": {
				Type:        schema.TypeString,
				Required:    true,
				Description: "UUID for configuration",
				//validateFunc: validateUUID,

			},
		},
	}
	//p.ConfigureContextFunc = providerconfigure(p)
	return p

}

// func validateUUID(v interface{}, k string) (ws []string, errors []error) {
// 	log.Print('validateUUID:start')
// 	value:= v.(string)
// 	if _,err = uuid.Parse(value);err !=nil {
// 		errors = append(error, fmt.Errorf("invalid UUID format"))
// 	}
// 	log.Print('validateUUID:end')
//}
