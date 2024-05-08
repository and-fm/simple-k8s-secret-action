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

	secretsFile, err := os.Open("secrets.txt")

	if err != nil {
		panic("error reading secrets!")
	}

	initArgs := []string{"create", "secret", "generic", secretName, "--dry-run=client"}

	createSecretCmd := exec.Command("kubectl", initArgs...);

	fileScanner := bufio.NewScanner(secretsFile)
	fileScanner.Split(bufio.ScanLines)

	for fileScanner.Scan() {
		text := fileScanner.Text()
		secretName, secretValue, found := strings.Cut(text, ":")
		if !found {
			continue
		}
		createSecretCmd.Args = append(createSecretCmd.Args, fmt.Sprintf("--from-literal=%s=%s", secretName, secretValue));
	}

	finalArgs := []string{"-n", secretNamespace, "-o", "yaml"}

	createSecretCmd.Args = append(createSecretCmd.Args, finalArgs...)

	bytes, err := createSecretCmd.CombinedOutput()
	if err != nil {
		panic(fmt.Sprintf("error executing kubectl: %s", err))
	}
	fmt.Print(string(bytes[:]))
}