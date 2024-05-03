# Simple k8s Secret Action

A simple and extendable action that can take in any number of secrets, and generate a valid k8s secret yaml as output to use in other actions.

## Inputs

The following inputs can be used as `step.with` keys:

| Name      | Type | Default | Required | Description                           |
| --------- | ---- | ------- | -------- | ------------------------------------- |
| `secrets` | List |         | `true`   | The actual list of secrets to pass in |

## Workflows

Branch protection rules require a PR before code can be merged into _main_. There are two PR workflows:

- Dependency review will check upstream base Apline Linux image or Github Actions for updates. If there are High or Critical vulnerabilities found in feature branch, the workflow will fail.
- [Trivy scanner](https://github.com/aquasecurity/trivy) will check the built Docker image for vulnerabilities. If there's a High or Critical CVEs found in the image, the workflow will fail.

A successful merge into _main_ will update the _latest_ release and update the _latest_ tagged container image uploaded to GitHub Packages.

## Contributions

Any help keeping this repo healthy and secure would be appreciated! \
Remaining in the to-do is automating semantic version releases in case users need to rollback to older, stable versions.

## Usage

Here is an example deploy.yaml file for the action:

```yaml
name: Create a simple k8s secret
on:
  workflow_dispatch:
    tags: none
jobs:
  create_secret:
    name: Create secret
    runs-on: ubuntu-latest
    steps:
      - name: Generate secret via kubectl
        uses: and-fm/simple-k8s-secret-action@v0.1
        with:
          secrets:
            SECRET_1: ${{ secrets.SECRET_1 }}
            SECRET_2: ${{ secrets.SECRET_2 }}
```
