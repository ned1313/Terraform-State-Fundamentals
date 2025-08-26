# Base Web App Configuration

This basic web app configuration will deploy a VPC and EC2 instance in the us-west-2 region. During the *Terraform State Fundamentals* course you will make changes to the configuration based on the requests from the Globomantics team and to explore Terraform state commands and features. The commands for each module are in the commands folder of the repository.

Before you begin making changes, you should make a copy of the `base_app` directory and make your changes in that copy. Run one of the following commands depending on your shell:

```bash
# Linux and Mac
cp ./base_app ./nacho_brigade
```

```powershell
# PowerShell
Copy-Item -Recurse .\base_app\ .\nacho_brigade
```
