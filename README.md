[![StepSecurity Maintained Action](https://raw.githubusercontent.com/step-security/maintained-actions-assets/main/assets/maintained-action-banner.png)](https://docs.stepsecurity.io/actions/stepsecurity-maintained-actions)

# GitHub Action for deploying to Azure Static Web Apps

This Github Action enables developers to build and publish their applications to Azure App Service Static Web Apps. This
action utilizes [Oryx](https://github.com/microsoft/Oryx) to detect and build an application, then uploads the resulting
application content, as well as any Azure Functions, to Azure.

* [More information about Azure Static Web Apps](https://aka.ms/swadocs)
* [More information about this GitHub Action Workflow](https://aka.ms/swaworkflowconfig)

## Usage

```yaml
jobs:
  build_and_deploy:
    runs-on: ubuntu-latest
    name: Build and Deploy
    steps:
      - name: Checkout
        uses: actions/checkout@v6

      - name: Build And Deploy
        id: builddeploy
        uses: step-security/static-web-apps-deploy@v1
        with:
          azure_static_web_apps_api_token: ${{ secrets.AZURE_STATIC_WEB_APPS_API_TOKEN }}
          repo_token: ${{ secrets.GITHUB_TOKEN }}
          action: "upload"
          app_location: "/"
          api_location: "api"
          output_location: "dist"
```

## Issues and Feedback

If you’d like to report an issue or provide feedback, please create issues against
this [repository](https://github.com/step-security/static-web-apps-deploy).

