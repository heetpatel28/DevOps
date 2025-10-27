# Kubernetes Commands Handbook

A comprehensive guide to essential Kubernetes (`kubectl`) commands for container orchestration, complete with descriptions, real-world use cases, and practical examples.

## Table of Contents

- [Basic Kubernetes Commands](#basic-kubernetes-commands)
  - [kubectl version](#1-kubectl-version)
  - [kubectl cluster-info](#2-kubectl-cluster-info)
  - [kubectl get nodes](#3-kubectl-get-nodes)
  - [kubectl get pods](#4-kubectl-get-pods)
  - [kubectl get services](#5-kubectl-get-services)
  - [kubectl get namespaces](#6-kubectl-get-namespaces)
  - [kubectl describe pod](#7-kubectl-describe-pod)
  - [kubectl logs](#8-kubectl-logs)
  - [kubectl create namespace](#9-kubectl-create-namespace)
  - [kubectl delete pod](#10-kubectl-delete-pod)
- [Intermediate Kubernetes Commands](#intermediate-kubernetes-commands)
  - [kubectl apply](#11-kubectl-apply)
  - [kubectl delete](#12-kubectl-delete)
  - [kubectl scale](#13-kubectl-scale)
  - [kubectl expose](#14-kubectl-expose)
  - [kubectl exec](#15-kubectl-exec)
  - [kubectl port-forward](#16-kubectl-port-forward)
  - [kubectl get configmaps](#17-kubectl-get-configmaps)
  - [kubectl get secrets](#18-kubectl-get-secrets)
  - [kubectl edit](#19-kubectl-edit)
  - [kubectl rollout status](#20-kubectl-rollout-status)
- [Advanced Kubernetes Commands](#advanced-kubernetes-commands)
  - [kubectl rollout undo](#21-kubectl-rollout-undo)
  - [kubectl top node / pod](#22-kubectl-top-node--pod)
  - [kubectl cordon / uncordon](#23-kubectl-cordon--uncordon)
  - [kubectl drain](#24-kubectl-drain)
  - [kubectl taint](#25-kubectl-taint)
  - [kubectl get events](#26-kubectl-get-events)
  - [kubectl apply -k](#27-kubectl-apply--k)
  - [kubectl config view](#28-kubectl-config-view)
  - [kubectl config use-context](#29-kubectl-config-use-context)
  - [kubectl debug](#30-kubectl-debug)
  - [kubectl patch](#31-kubectl-patch)
  - [kubectl rollout history](#32-kubectl-rollout-history)
  - [kubectl autoscale](#33-kubectl-autoscale)
  - [kubectl label](#34-kubectl-label)
  - [kubectl annotate](#35-kubectl-annotate)
  - [kubectl get ingress](#36-kubectl-get-ingress)
  - [kubectl create configmap / secret](#37-kubectl-create-configmap--secret)
  - [kubectl api-resources](#38-kubectl-api-resources)

---

## Basic Kubernetes Commands

### 1. `kubectl version`
- **Description**: Displays the version of the `kubectl` client and the Kubernetes server it's connected to.
- **Real-World Use Case**: To verify your client and server versions are compatible and to check if you're connected to the correct cluster.

**Examples**:
```bash
# Display the full client and server version
kubectl version
# Display only the short version numbers
kubectl version --short
```

### 2. `kubectl cluster-info`
- **Description**: Shows the addresses of the Kubernetes control plane and services running in the cluster.
- **Real-World Use Case**: To get the endpoint for the Kubernetes API server and to verify that core components like CoreDNS are running.

**Examples**:
```bash
# Display the main cluster information
kubectl cluster-info
# Dump all cluster information into a file for debugging
kubectl cluster-info dump --output-directory=./cluster-state
```

### 3. `kubectl get nodes`
- **Description**: Lists all the nodes (worker machines) that are part of the Kubernetes cluster.
- **Real-World Use Case**: To check the health and status of your cluster's nodes to ensure they are `Ready` to accept workloads.

**Examples**:
```bash
# List all nodes with their status, roles, and version
kubectl get nodes
# Get a wider output with more details like internal/external IPs
kubectl get nodes -o wide
```

### 4. `kubectl get pods`
- **Description**: Lists all the pods in the current namespace. A pod is the smallest deployable unit in Kubernetes, representing a single instance of a running process.
- **Real-World Use Case**: The most common command for checking if your application instances are running, restarting, or have encountered errors.

**Examples**:
```bash
# List all pods in the default namespace
kubectl get pods
# List all pods in all namespaces
kubectl get pods --all-namespaces
```

### 5. `kubectl get services`
- **Description**: Lists all the services in the current namespace. A service provides a stable network endpoint (IP address and port) for a set of pods.
- **Real-World Use Case**: To find the IP address or DNS name that you can use to access your application running in a set of pods.

**Examples**:
```bash
# List all services in the current namespace
kubectl get services
# Get detailed information about a specific service in YAML format
kubectl get service my-service -o yaml
```

### 6. `kubectl get namespaces`
- **Description**: Lists all the namespaces in the cluster. Namespaces are a way to divide cluster resources between multiple users or teams.
- **Real-World Use Case**: To see the different logical environments (e.g., `development`, `staging`, `production`) that have been set up in the cluster.

**Examples**:
```bash
# List all namespaces
kubectl get namespaces
# Get a specific namespace
kubectl get namespace default
```

### 7. `kubectl describe pod`
- **Description**: Shows a large amount of detailed, human-readable information about a specific resource, most commonly a pod.
- **Real-World Use Case**: The primary command for troubleshooting a pod that is not starting correctly. It shows events, volume mounts, container status, and more.

**Examples**:
```bash
# Describe a pod to find out why it's in a 'Pending' or 'CrashLoopBackOff' state
kubectl describe pod my-app-pod-12345
# Describe a node to see its resource allocation and running pods
kubectl describe node my-worker-node-1
```

### 8. `kubectl logs`
- **Description**: Prints the logs (standard output) from a container within a pod.
- **Real-World Use Case**: To see your application's output, check for error messages, or debug its behavior.

**Examples**:
```bash
# View the logs for a specific pod
kubectl logs my-app-pod-12345
# Follow the logs in real-time (similar to 'tail -f')
kubectl logs -f my-app-pod-12345
```

### 9. `kubectl create namespace`
- **Description**: Creates a new namespace in the cluster.
- **Real-World Use Case**: To set up a new, isolated environment for a project or team.

**Examples**:
```bash
# Create a new namespace called "production"
kubectl create namespace production
# Create a namespace from a YAML file definition
kubectl create -f my-namespace.yaml
```

### 10. `kubectl delete pod`
- **Description**: Deletes a specific pod. If the pod is managed by a ReplicaSet or Deployment, a new pod will likely be created to replace it.
- **Real-World Use Case**: To manually restart a stuck or misbehaving pod by deleting it and letting its controller recreate it.

**Examples**:
```bash
# Delete a pod by its name
kubectl delete pod my-app-pod-12345
# Forcefully delete a pod that is stuck in a 'Terminating' state
kubectl delete pod my-stuck-pod --grace-period=0 --force
```

---

## Intermediate Kubernetes Commands

### 11. `kubectl apply`
- **Description**: Applies a configuration to a resource from a file or from standard input. It will create the resource if it doesn't exist, or update it if it does.
- **Real-World Use Case**: The standard, declarative way to manage all your Kubernetes resources. You define your application's desired state in YAML files and use `apply` to make it happen.

**Examples**:
```bash
# Apply the configuration in a deployment.yaml file
kubectl apply -f deployment.yaml
# Apply all .yaml files in a directory
kubectl apply -f ./my-app-configs/
```

### 12. `kubectl delete`
- **Description**: Deletes Kubernetes resources, specified by file, type and name, or label selector.
- **Real-World Use Case**: To remove an application and its associated resources (like services and deployments) from the cluster.

**Examples**:
```bash
# Delete the resources defined in a YAML file
kubectl delete -f deployment.yaml
# Delete a deployment and a service by name
kubectl delete deployment/my-app service/my-app-service
```

### 13. `kubectl scale`
- **Description**: Adjusts the number of running replicas for a Deployment, ReplicaSet, or StatefulSet.
- **Real-World Use Case**: To manually increase the number of instances of your application to handle more traffic, or decrease them to save resources.

**Examples**:
```bash
# Scale a deployment to 3 replicas
kubectl scale deployment/my-app-deployment --replicas=3
# Scale a statefulset to 5 replicas
kubectl scale statefulset/my-database --replicas=5
```

### 14. `kubectl expose`
- **Description**: Creates a Service to expose a resource (like a Deployment) to the network, making it accessible.
- **Real-World Use Case**: A quick way to create a network service for your deployment so that it can be accessed from outside the cluster or by other pods.

**Examples**:
```bash
# Expose a deployment as a LoadBalancer service on port 80
kubectl expose deployment/my-web-server --type=LoadBalancer --port=80
# Expose a deployment as a ClusterIP service (internal only)
kubectl expose deployment/my-api --port=8080 --target-port=8000
```

### 15. `kubectl exec`
- **Description**: Executes a command inside a container running in a pod.
- **Real-World Use Case**: To get an interactive shell into a running container for live debugging or to run a utility command.

**Examples**:
```bash
# Get an interactive bash shell in a container
kubectl exec -it my-app-pod-12345 -- /bin/bash
# List files in a container without getting a shell
kubectl exec my-app-pod-12345 -- ls /app
```

### 16. `kubectl port-forward`
- **Description**: Forwards a port on your local machine to a port on a pod.
- **Real-World Use Case**: To securely access an application or database running in a pod from your local machine for development or debugging, without exposing it to the public internet.

**Examples**:
```bash
# Forward local port 8080 to port 80 on a pod
kubectl port-forward my-app-pod-12345 8080:80
# Forward to a database pod on a random local port
kubectl port-forward service/my-database :5432
```

### 17. `kubectl get configmaps`
- **Description**: Lists the ConfigMaps in the current namespace. ConfigMaps are used to store non-confidential configuration data in key-value pairs.
- **Real-World Use Case**: To check the configuration settings that are being injected into your applications.

**Examples**:
```bash
# List all ConfigMaps
kubectl get configmaps
# Get the details of a specific ConfigMap in YAML format
kubectl get configmap my-app-config -o yaml
```

### 18. `kubectl get secrets`
- **Description**: Lists the Secrets in the current namespace. Secrets are used to store sensitive information, such as passwords, API keys, and TLS certificates.
- **Real-World Use Case**: To verify that your application's secrets have been created correctly.

**Examples**:
```bash
# List all secrets
kubectl get secrets
# Decode a secret to view its contents (requires base64 decoding)
kubectl get secret my-db-secret -o jsonpath='{.data.password}' | base64 --decode
```

### 19. `kubectl edit`
- **Description**: Opens the configuration of a live resource in your default text editor, allowing you to make and apply changes directly.
- **Real-World Use Case**: For making a quick, temporary change to a resource without updating its source YAML file. (Using `kubectl apply` is better for permanent changes).

**Examples**:
```bash
# Edit a deployment to change its image version
kubectl edit deployment/my-app-deployment
# Edit a service to change its port
kubectl edit service/my-service
```

### 20. `kubectl rollout status`
- **Description**: Watches the status of a deployment's rollout until it's complete.
- **Real-World Use Case**: After applying an update to a deployment, you use this command to see if the new version is deploying successfully or if it's getting stuck.

**Examples**:
```bash
# Watch the status of a deployment
kubectl rollout status deployment/my-app-deployment
# Watch the status of a statefulset
kubectl rollout status statefulset/my-database
```

---

## Advanced Kubernetes Commands

### 21. `kubectl rollout undo`
- **Description**: Rolls back a deployment to a previous version.
- **Real-World Use Case**: When you discover a bug in a new release, this command provides a fast and easy way to revert to the last known good version.

**Examples**:
```bash
# Roll back to the previous deployment revision
kubectl rollout undo deployment/my-app-deployment
# Roll back to a specific revision number
kubectl rollout undo deployment/my-app-deployment --to-revision=3
```

### 22. `kubectl top node / pod`
- **Description**: Shows the current CPU and memory usage for nodes or pods. (Requires the Metrics Server to be installed in the cluster).
- **Real-World Use Case**: To identify which pods or nodes are consuming the most resources, helping with performance tuning and capacity planning.

**Examples**:
```bash
# Show resource usage for all nodes
kubectl top nodes
# Show resource usage for all pods in a specific namespace
kubectl top pods -n my-namespace
```

### 23. `kubectl cordon / uncordon`
- **Description**: `cordon` marks a node as unschedulable, meaning no new pods will be placed on it. `uncordon` makes it schedulable again.
- **Real-World Use Case**: Before performing maintenance on a node (like a reboot), you `cordon` it to prevent Kubernetes from scheduling new work there.

**Examples**:
```bash
# Mark a node as unschedulable
kubectl cordon my-worker-node-2
# Mark the node as schedulable again after maintenance
kubectl uncordon my-worker-node-2
```

### 24. `kubectl drain`
- **Description**: Safely evicts all pods from a node, allowing them to be gracefully terminated and rescheduled on other nodes. It also cordons the node.
- **Real-World Use Case**: The standard procedure for removing a node from the cluster for maintenance or decommissioning.

**Examples**:
```bash
# Safely drain a node, ignoring pods managed by DaemonSets
kubectl drain my-worker-node-3 --ignore-daemonsets
# Force the drain even if there are pods not managed by a controller
kubectl drain my-worker-node-3 --force --ignore-daemonsets
```

### 25. `kubectl taint`
- **Description**: Applies a "taint" to a node. Pods that do not have a "toleration" for this taint will not be scheduled on the node.
- **Real-World Use Case**: To reserve specific nodes for specific workloads, for example, tainting a node with a powerful GPU so that only pods that require a GPU will be scheduled there.

**Examples**:
```bash
# Taint a node to only allow pods with a specific toleration
kubectl taint nodes my-gpu-node gpu=true:NoSchedule
# Remove the taint from the node
kubectl taint nodes my-gpu-node gpu:NoSchedule-
```

### 26. `kubectl get events`
- **Description**: Displays a chronological list of events that have occurred in the cluster, such as pods being scheduled, images being pulled, or containers failing.
- **Real-World Use Case**: A powerful tool for debugging cluster-level issues by seeing the sequence of events that led to a problem.

**Examples**:
```bash
# List all events in the current namespace, sorted by time
kubectl get events --sort-by='.lastTimestamp'
# Watch for new events as they happen
kubectl get events -w
```

### 27. `kubectl apply -k`
- **Description**: Applies resources from a directory containing a `kustomization.yaml` file. Kustomize is a tool for customizing Kubernetes configurations.
- **Real-World Use Case**: To manage application configurations across different environments (dev, staging, prod) by overlaying environment-specific patches on a common base configuration.

**Examples**:
```bash
# Apply the kustomization configuration in the 'overlays/production' directory
kubectl apply -k overlays/production
# View the final YAML that kustomize will generate without applying it
kubectl kustomize overlays/staging
```

### 28. `kubectl config view`
- **Description**: Displays the contents of your `kubeconfig` file, which contains your cluster connection details and authentication information.
- **Real-World Use Case**: To check which cluster you are currently configured to connect to.

**Examples**:
```bash
# Show the entire kubeconfig
kubectl config view
# Show only the current context
kubectl config current-context
```

### 29. `kubectl config use-context`
- **Description**: Switches your active cluster connection to a different context defined in your `kubeconfig` file.
- **Real-World Use Case**: When you work with multiple Kubernetes clusters (e.g., a local one and a cloud-based one), this command lets you switch between them.

**Examples**:
```bash
# List all available contexts
kubectl config get-contexts
# Switch to the 'docker-desktop' context
kubectl config use-context docker-desktop
```

### 30. `kubectl debug`
- **Description**: Creates a temporary, ephemeral container in a pod or on a node for interactive debugging.
- **Real-World Use Case**: To attach a debugging container with extra tools (like `curl` or `netcat`) to a running application pod to troubleshoot network issues without modifying the original pod.

**Examples**:
```bash
# Start a debugging session on a pod
kubectl debug -it my-app-pod-12345 --image=busybox --target=my-app-container
# Create a debug pod on a specific node
kubectl debug node/my-worker-node-1 -it --image=ubuntu
```

### 31. `kubectl patch`
- **Description**: Partially updates a live resource in the cluster without needing to provide the full resource definition.
- **Real-World Use Case**: To quickly change a single field on a resource, like updating an annotation or a container image tag, without using `kubectl edit`.

**Examples**:
```bash
# Patch a deployment to change the image of a container
kubectl patch deployment my-deployment --patch '{"spec":{"template":{"spec":{"containers":[{"name":"nginx","image":"nginx:1.21.6"}]}}}}'
# Patch a service to add an annotation
kubectl patch service my-service -p '{"metadata":{"annotations":{"new-key":"new-value"}}}'
```

### 32. `kubectl rollout history`
- **Description**: Shows the history of revisions for a deployment.
- **Real-World Use Case**: To see the list of past deployments, which is useful before performing a `rollout undo` to a specific revision.

**Examples**:
```bash
# View the rollout history of a deployment
kubectl rollout history deployment/my-app-deployment
# View the details of a specific revision
kubectl rollout history deployment/my-app-deployment --revision=2
```

### 33. `kubectl autoscale`
- **Description**: Creates a HorizontalPodAutoscaler (HPA) that automatically scales a resource (like a Deployment) based on observed CPU or memory usage.
- **Real-World Use Case**: To automatically add more pods to your application when traffic increases and remove them when traffic decreases, ensuring performance and saving costs.

**Examples**:
```bash
# Create an HPA to scale a deployment based on CPU utilization
kubectl autoscale deployment my-app-deployment --cpu-percent=80 --min=2 --max=10
# Get the status of the HPA
kubectl get hpa
```

### 34. `kubectl label`
- **Description**: Adds, updates, or removes labels on a resource. Labels are key/value pairs used to organize and select resources.
- **Real-World Use Case**: To label pods with their application name, environment, or version, so you can easily select them with commands like `kubectl get pods -l app=my-app`.

**Examples**:
```bash
# Add a label to a pod
kubectl label pods my-app-pod-12345 environment=production
# Overwrite an existing label on a node
kubectl label nodes my-worker-node-1 disktype=ssd --overwrite
```

### 35. `kubectl annotate`
- **Description**: Adds, updates, or removes annotations on a resource. Annotations are for storing non-identifying metadata.
- **Real-World Use Case**: To add descriptive information, contact details, or tool-specific configuration to a resource that is not used for selection.

**Examples**:
```bash
# Add an annotation to a pod
kubectl annotate pods my-app-pod-12345 description="Main web frontend pod"
# Remove an annotation from a deployment
kubectl annotate deployment/my-app-deployment description-
```

### 36. `kubectl get ingress`
- **Description**: Lists the Ingress resources in the current namespace. Ingress manages external access to services in the cluster, typically HTTP.
- **Real-World Use Case**: To check the routing rules that direct external traffic (e.g., from a domain name) to your internal services.

**Examples**:
```bash
# List all ingress resources
kubectl get ingress
# Describe an ingress to see its rules and backend services
kubectl describe ingress my-app-ingress
```

### 37. `kubectl create configmap / secret`
- **Description**: A direct, imperative way to create ConfigMaps or Secrets from files or literal key-value pairs.
- **Real-World Use Case**: For quickly creating a simple ConfigMap or Secret without writing a full YAML file.

**Examples**:
```bash
# Create a ConfigMap from literal values
kubectl create configmap my-app-config --from-literal=api.url=http://my-api --from-literal=app.mode=production
# Create a generic secret from literal values
kubectl create secret generic my-db-secret --from-literal=username=admin --from-literal=password='supersecret'
```

### 38. `kubectl api-resources`
- **Description**: Lists all the available API resource types that your Kubernetes cluster supports.
- **Real-World Use Case**: To discover the short names and API groups for different resource types, which is useful when you're not sure of the exact name (e.g., `deploy` for `deployments`).

**Examples**:
```bash
# List all available API resources
kubectl api-resources
# List resources that support the 'get' and 'list' verbs
kubectl api-resources --verbs=get,list
```