# Octopus Worker Firebase Tools

A Docker image for Octopus Deploy workers with Firebase CLI tools pre-installed.

## Base Image

This image is based on `octopusdeploy/worker-tools:6.5.0-ubuntu.22.04` and includes all the tools from the official Octopus Deploy worker image.

## Additional Tools

- **Node.js** (v20 LTS) - installed via nvm
- **npm** - Node package manager
- **Firebase CLI** - Firebase command-line tools for deployments

## Usage

### Pull from Docker Hub

```bash
docker pull petegoo/octopus-worker-firebase-tools:latest
```

### Use in Octopus Deploy

In your Octopus Deploy project, configure a step to use this container image:

1. Go to your deployment process
2. Add or edit a step
3. Under "Execution Location", select "Run on a worker"
4. Under "Container Image", select "Run inside a container on a worker"
5. Enter the image: `petegoo/octopus-worker-firebase-tools:latest`

### Example Firebase Deployment Script

```bash
# Authenticate with Firebase (use a service account token)
export FIREBASE_TOKEN="${FirebaseToken}"

# Deploy to Firebase Hosting
firebase deploy --only hosting --project ${FirebaseProject}

# Or deploy Firebase Functions
firebase deploy --only functions --project ${FirebaseProject}
```

## Building Locally

```bash
# Build the image
docker build -t octopus-worker-firebase-tools .

# Run tests
docker-compose -f docker-compose.test.yml up --build

# Or run tests manually
docker run --rm -v $(pwd)/tests:/tests octopus-worker-firebase-tools /tests/test-installation.sh
```

## Testing

The test suite verifies:

- nvm is installed correctly
- Node.js is accessible
- npm is accessible
- Firebase CLI is installed and functional
- Key Firebase commands are available (deploy, functions, hosting)

Run tests:

```bash
docker-compose -f docker-compose.test.yml up --build
```

## Versions

| Tool | Version |
|------|---------|
| Base Image | octopusdeploy/worker-tools:6.5.0-ubuntu.22.04 |
| Node.js | 20.x (LTS) |
| nvm | 0.40.1 |
| Firebase CLI | Latest |

## License

MIT
