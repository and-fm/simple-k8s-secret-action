package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func main() {
	var secretName string;
	var secretNamespace string;
	if len(os.Args) > 2 {
		secretName = os.Args[1];
		secretNamespace = os.Args[2]
	} else {
		panic("must provide the secret name and namespace args!")
	}

	fmt.Println(secretName)

	secretsFile, err := os.Open("secrets.txt")
	secretCmdArgs := make([]string, 7);

	if err != nil {
		panic("error reading secrets!")
	}

	secretCmdArgs[0] = "kubectl";
	secretCmdArgs[1] = fmt.Sprintf("create secret generic %s --dry-run=client \\", secretName);

	fileScanner := bufio.NewScanner(secretsFile)
	fileScanner.Split(bufio.ScanLines)

	// var fileLines []string
	i := 2
	for fileScanner.Scan() {
		text := fileScanner.Text()
		parts := strings.Split(text, ":")
		secretCmdArgs[i] = fmt.Sprintf("--from-literal=%s=%s \\", parts[0], parts[1]);
		fmt.Printf("secret name: %s, value: %s\n", parts[0], parts[1])
		i++
	}

	secretCmdArgs = append(secretCmdArgs, fmt.Sprintf("-n %s -o yaml", secretNamespace))

	createSecretCmd := exec.Command(secretCmdArgs[0], secretCmdArgs[1:]...);
	
	// out, err := strings.Join(createSecretCmd.Args, " ")
	fmt.Print(strings.Join(createSecretCmd.Args, " "))
}