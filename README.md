# Node.js Kubernetes CI/CD with Minikube

## Prerequisites

   Before running this project, install:
   - [Docker](https://docs.docker.com/get-docker/)
   - [Minikube](https://minikube.sigs.k8s.io/docs/start/)
   - [kubectl](https://kubernetes.io/docs/tasks/tools/)
   - [Git](https://git-scm.com/)
   - GitHub repository with:
   - `DOCKER_USERNAME` secret
   - `DOCKER_PASSWORD` secret

---

## System Setup

1. **Setup Docker**

   a. Install Docker Desktop and create an account.

   b. Go to settings and Enable Kubernetes. Then click on **Apply and Restart**.

   c. Install the dependencies and restart your system.

2. **Setup Kubernetes**

   a. Install Minikube and Kubectl from the official websites.

   b. Add the path to the kubectl.exe file to **Path** in environment variables.

   c. Run the following command to check if kubectl has been installed successfully or not:

      ```sh
      kubectl version --client
      ```
      
      The result should show the installed version of kubectl.

   d. Run the following command to initiate a local Kuberetes cluster:

      ```sh
      minikube start
      ```


## Steps to Deploy

1. **Build Docker Image:**
   ```sh
   docker build -t your-dockerhub-username/node-app .
   ```

2. **Push to Docker Hub:**
   ```sh
   docker push your-dockerhub-username/node-app
   ```

3. **Deploy to Kubernetes:**
   ```sh
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   kubectl apply -f hpa.yaml
   kubectl apply -f configmap.yaml
   kubectl apply -f secret.yaml
   kubectl apply -f persistent-volume.yaml
   kubectl apply -f persistent-volume-claim.yaml
   ```

4. **Verify Deployment:**
   ```sh
   kubectl get pods
   kubectl get services
   ```

5. **Test Application:**
   ```sh
   curl http://<EXTERNAL-IP>:<PORT>
   ```

## CI/CD Workflow

1. **CI: Build & Push**

   -> Triggered automatically when you push to the main branch.

   ->Builds Docker image.

   -> Pushes image to Docker Hub.

2. **CD: Local Deployment**

   -> Run locally to pull and deploy the latest image (in git bash):
   ```sh
   ./deploy-local.sh
   ```

   -> Script will:
      a. Fetch latest commit SHA from your local repo.
      b. Update Kubernetes deployment to new image.
      c. Wait for rollout to finish.

